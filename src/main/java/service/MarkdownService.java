package service;

import dao.MarkdownDao;
import entity.Markdown;
import org.springframework.stereotype.Service;
import util.OMUtil;

import javax.annotation.Resource;

@Service
public class MarkdownService {

    @Resource
    MarkdownDao markdownDao;

    public boolean saveMarkdown(Markdown markdown) {
        markdown.setUpdateDate(OMUtil.generateFormattedDate());
        return markdownDao.saveMarkdown(markdown) > 0;
    }

    public Markdown getMarkdown(long authorId, long markdownId) {
        return markdownDao.getMarkdown(authorId, markdownId);
    }

    public boolean createMarkdown(Markdown markdown) {
        return markdownDao.createMarkdown(markdown) > 0;
    }

    public boolean deleteMarkdown(long authorId, long markdownId) {
        return markdownDao.deleteMarkdown(authorId, markdownId) > 0;
    }
}
