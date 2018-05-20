package controller;

import com.alibaba.fastjson.JSONObject;
import entity.Author;
import entity.Markdown;
import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import service.OMService;
import util.OMUtil;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@CrossOrigin(origins = "*", maxAge = 3600)
public class OMController {

    @Autowired
    private OMService omService;

    @RequestMapping("/")
    public String index() {
        return "mark";
    }

    @RequestMapping("/login")
    public String login() {
        return "login";
    }

    @RequestMapping("/register")
    public String register() {
        return "register";
    }

    @RequestMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/";
    }

    @RequestMapping("/edit")
    public String edit() {
        return "edit";
    }

    @RequestMapping("/upload")
    public void upload(HttpServletRequest request, HttpServletResponse response, @RequestParam(value = "editormd-image-file", required = false) MultipartFile image) {
        try {
            request.setCharacterEncoding("utf-8");
            response.setHeader("Content-Type", "text/html");
            String rootPath = request.getSession().getServletContext().getRealPath("/images/");
            //文件路径不存在则需要创建文件路径
            File filePath = new File(rootPath);
            if (!filePath.exists()) {
                filePath.mkdirs();
            }
            //最终文件名
            File realFile = new File(rootPath + File.separator + image.getOriginalFilename());
            FileUtils.copyInputStreamToFile(image.getInputStream(), realFile);
            //下面response返回的json格式是editor.md所限制的，规范输出就OK
            response.getWriter().write("{\"success\": 1, \"message\":\"上传成功\",\"url\":\"/OnlineMarkdown/images/" + image.getOriginalFilename() + "\"}");
        } catch (Exception e) {
            try {
                response.getWriter().write("{\"success\":0}");
            } catch (IOException e1) {
                e1.printStackTrace();
            }
        }
    }

    @RequestMapping(value = "/loginConfirm", produces = {"application/json;charset=UTF-8"})
    @ResponseBody
    public String login(String email, String password, HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        Author author = omService.login(email, password);
        if (author != null) {
            result.put("success", 0);
            result.put("msg", "登录成功");
            session.setAttribute("author", author);
        } else {
            result.put("success", 1);
            result.put("msg", "用户名/密码错误,请重试～");
        }
        return JSONObject.toJSONString(result);
    }

    @RequestMapping(value = "/check", produces = {"application/json;charset=UTF-8"})
    @ResponseBody
    public String check(String email) {
        Map<String, Object> result = new HashMap<>();
        if (omService.emailIsExist(email)) {
            result.put("success", 1);
            result.put("msg", "该邮箱已被注册");
        } else {
            result.put("success", 0);
            result.put("msg", "该邮箱可以使用");
        }
        return JSONObject.toJSONString(result);
    }

    @RequestMapping(value = "/registerConfirm", produces = {"application/json;charset=UTF-8"})
    @ResponseBody
    public String register(String nickname, String email, String password) {
        Map<String, Object> result = new HashMap<>();
        Author author = new Author(nickname, email, password);
        if (omService.register(author)) {
            result.put("success", 0);
            result.put("msg", "注册成功");
        } else {
            result.put("success", 1);
            result.put("msg", "注册失败，请重试～");
        }
        return JSONObject.toJSONString(result);
    }

    @GetMapping("/{authorId}")
    public ModelAndView getMarkdowns(@PathVariable long authorId, String page) {
        if (page == null) {
            page = "1";
        }
        System.out.println(page);
        Map<String, Object> result = new HashMap<>();
        List<Markdown> markdowns = omService.getMarkdowns(authorId);
        Author author = omService.getAuthor(authorId);
        if (author != null && markdowns != null) {
            result.put("author", author);
            result.put("markdowns", OMUtil.splitResultByPage(markdowns, Integer.parseInt(page)));
            result.put("count", markdowns.size());
            result.put("current_page", page);
            result.put("total_pages", (int) markdowns.size() / 10 + 1);
            return new ModelAndView("user", result);
        }
        return null;
    }

    @RequestMapping("/mark")
    public String mark() {
        return "forward:/";
    }

    @GetMapping("/{authorId}/markdown/{markdownId}")
    public ModelAndView getMarkdown(@PathVariable long authorId, @PathVariable long markdownId) {
        Map<String, Object> result = new HashMap<>();
        Markdown markdown = omService.getMarkdown(authorId, markdownId);
        if (markdown != null) {
            result.put("markdown", markdown);
            return new ModelAndView("mark", result);
        }
        return null;
    }

    @PutMapping("/{authorId}/markdown/{markdownId}")
    public void updateMarkdown(HttpServletRequest request, HttpServletResponse response, @PathVariable long authorId, @PathVariable long markdownId, String content) {
        Markdown markdown = omService.getMarkdown(authorId, markdownId);
        markdown.setContent(content);
        if (omService.saveMarkdown(markdown)) {
            try {
                response.getWriter().write("content:" + markdown.getContent());
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }


}
