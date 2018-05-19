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
    public ModelAndView index() {
        Map model = new HashMap();
        model.put("title", "index");
        return new ModelAndView("index", model);
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

    @RequestMapping("/login")
    @ResponseBody
    public String login() {
        Map model = new HashMap();
        model.put("data", 1);
        return JSONObject.toJSONString(model);
    }

    @RequestMapping("/register")
    @ResponseBody
    public String register(String nickname, String email, String password) {
        Map model = new HashMap();
        Author author = new Author(nickname, email, password);
        model.put("author", author);
        return JSONObject.toJSONString(model);
    }

    @GetMapping("/{authorId}")
    public ModelAndView getMarkdowns(@PathVariable long authorId, String page) {
        if (page == null) {
            page = "1";
        }
        System.out.println(page);
        Map model = new HashMap();
        List<Markdown> markdowns = omService.getMarkdowns(authorId);
        Author author = omService.getAuthor(authorId);
        if (author != null && markdowns != null) {
            model.put("author", author);
            model.put("markdowns", OMUtil.splitResultByPage(markdowns, Integer.parseInt(page)));
            model.put("count", markdowns.size());
            model.put("current_page", page);
            model.put("total_pages", (int) markdowns.size() / 10 + 1);
            return new ModelAndView("list", model);
        }
        return null;
    }

    @RequestMapping("/mark")
    public String mark() {
        return "edit";
    }

    @GetMapping("/{authorId}/markdown/{markdownId}")
    public ModelAndView getMarkdown(@PathVariable long authorId, @PathVariable long markdownId) {
        Map model = new HashMap();
        Markdown markdown = omService.getMarkdown(authorId, markdownId);
        if (markdown != null) {
            model.put("markdown", markdown);
            return new ModelAndView("edit", model);
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