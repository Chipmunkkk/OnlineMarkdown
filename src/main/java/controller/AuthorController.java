package controller;

import com.alibaba.fastjson.JSONObject;
import entity.Author;
import entity.Markdown;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import service.AuthorService;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@CrossOrigin(origins = "*", maxAge = 3600)
public class AuthorController {

    @Autowired
    AuthorService authorService;

    @RequestMapping(value = "/registerConfirm", produces = {"application/json;charset=UTF-8"})
    @ResponseBody
    public String register(String nickname, String email, String password) {
        Map<String, Object> result = new HashMap<>();
        Author author = new Author(nickname, email, password);
        if (authorService.register(author)) {
            result.put("success", 0);
            result.put("msg", "注册成功");
        } else {
            result.put("success", 1);
            result.put("msg", "注册失败，请重试～");
        }
        return JSONObject.toJSONString(result);
    }

    @RequestMapping(value = "/loginConfirm", produces = {"application/json;charset=UTF-8"})
    @ResponseBody
    public String login(String email, String password, HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        Author author = authorService.login(email, password);
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
        if (authorService.emailIsExist(email)) {
            result.put("success", 1);
            result.put("msg", "该邮箱已被注册");
        } else {
            result.put("success", 0);
            result.put("msg", "该邮箱可以使用");
        }
        return JSONObject.toJSONString(result);
    }

    @GetMapping("/{authorId}")
    public ModelAndView getMarkdowns(@PathVariable long authorId, String page) {
        int per_page = 13;
        if (page == null) {
            page = "1";
        }
        Map<String, Object> result = new HashMap<>();
        List<Markdown> markdowns = authorService.getMarkdowns(authorId, Integer.parseInt(page), per_page);
        int count = authorService.getMarkdownCount(authorId);
        Author author = authorService.getAuthor(authorId);
        if (author != null) {
            result.put("author", author);
            result.put("markdowns", markdowns);
            result.put("count", count);
            result.put("current_page", page);
            if (count % per_page == 0) {
                result.put("total_pages", (count / per_page));
            } else {
                result.put("total_pages", (int) (count / per_page) + 1);
            }
            return new ModelAndView("user", result);
        }
        return null;
    }

    @GetMapping("/{authorId}/edit")
    public ModelAndView edit(@PathVariable long authorId) {
        Map<String, Object> result = new HashMap<>();
        Author author = authorService.getAuthor(authorId);
        result.put("author", author);
        result.put("count", authorService.getMarkdownCount(authorId));
        return new ModelAndView("edit", result);
    }


    @PutMapping(value = "/{authorId}/edit", produces = {"application/json;charset=UTF-8"})
    @ResponseBody
    public String updateProfile(@PathVariable long authorId, String nickname, String email, String password, String description) {
        Map<String, Object> result = new HashMap<>();
        if (authorService.updateProfile(authorId, nickname, email, password, description)) {
            result.put("success", 0);
            result.put("msg", "个人信息更新成功");
        } else {
            result.put("success", 1);
            result.put("msg", "个人信息更新失败");
        }
        return JSONObject.toJSONString(result);
    }

    @RequestMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/";
    }
}
