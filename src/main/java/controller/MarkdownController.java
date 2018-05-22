package controller;

import com.alibaba.fastjson.JSONObject;
import entity.Markdown;
import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import service.MarkdownService;
import util.OMUtil;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.Map;

@Controller
@CrossOrigin(origins = "*", maxAge = 3600)
public class MarkdownController {

    @Autowired
    MarkdownService markdownService;

    @RequestMapping(value = "/upload", produces = {"application/json;charset=UTF-8"})
    @ResponseBody
    public String upload(HttpServletRequest request, HttpServletResponse response, @RequestParam(value = "editormd-image-file", required = false) MultipartFile image) {
        Map<String, Object> result = new HashMap<>();
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
            result.put("success", 1);
            result.put("message", "上传成功");
            result.put("url", "/OnlineMarkdown/images/" + image.getOriginalFilename());
        } catch (Exception e) {
            result.put("success", 0);
        }
        return JSONObject.toJSONString(result);
    }

    @GetMapping(value = "/{authorId}/markdown/{markdownId}", produces = {"application/json;charset=UTF-8"})
    public ModelAndView getMarkdown(HttpServletRequest request, HttpServletResponse response, @PathVariable long authorId, @PathVariable long markdownId) throws UnsupportedEncodingException {
        Map<String, Object> result = new HashMap<>();
        Markdown markdown = markdownService.getMarkdown(authorId, markdownId);
        if (markdown != null) {
            result.put("markdown", markdown);
            return new ModelAndView("mark", result);
        } else {
            return null;
        }
    }

    @PutMapping(value = "/{authorId}/markdown/{markdownId}", produces = {"application/json;charset=UTF-8"})
    @ResponseBody
    public String updateMarkdown(HttpServletRequest request, HttpServletResponse response, @PathVariable long authorId, @PathVariable long markdownId, String title, String markdown) {
        Map<String, Object> result = new HashMap<>();
        Markdown mark = markdownService.getMarkdown(authorId, markdownId);
        mark.setTitle(title);
        mark.setContent(markdown);
        if (markdownService.saveMarkdown(mark)) {
            result.put("success", 0);
            result.put("msg", "保存Markdown成功");
            result.put("mark", mark);
        } else {
            result.put("success", 1);
            result.put("msg", "保存Markdown失败");
        }
        return JSONObject.toJSONString(result);
    }

    @PostMapping(value = "/{authorId}/markdown", produces = {"application/json;charset=UTF-8"})
    @ResponseBody
    public String postMarkdown(HttpServletRequest request, HttpServletResponse response, @PathVariable long authorId, String title, String markdown) {
        Map<String, Object> result = new HashMap<>();
        Markdown mark = new Markdown();
        mark.setAuthorId(authorId);
        mark.setTitle(title);
        mark.setContent(markdown);
        mark.setMarkdownId(OMUtil.generateUID("M"));
        mark.setUpdateDate(OMUtil.generateFormattedDate());
        if (markdownService.createMarkdown(mark)) {
            result.put("success", 0);
            result.put("msg", "创建Markdown成功");
            result.put("mark", mark);

        } else {
            result.put("success", 1);
            result.put("msg", "创建Markdown失败");
        }
        return JSONObject.toJSONString(result);
    }

    @DeleteMapping(value = "/{authorId}/markdown/{markdownId}", produces = {"application/json;charset=UTF-8"})
    @ResponseBody
    public String deleteMarkdown(@PathVariable long authorId, @PathVariable long markdownId) {
        Map<String, Object> result = new HashMap<>();
        if (markdownService.deleteMarkdown(authorId, markdownId)) {
            result.put("success", 0);
            result.put("msg", "删除Markdown成功");
        } else {
            result.put("success", 1);
            result.put("msg", "删除Markdown失败");
        }
        return JSONObject.toJSONString(result);
    }

}
