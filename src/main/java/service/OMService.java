package service;

import dao.OMDao;
import entity.Author;
import entity.Markdown;
import org.springframework.stereotype.Service;
import util.OMUtil;

import javax.annotation.Resource;
import java.util.List;

@Service
public class OMService {

    @Resource
    OMDao omDao;

    public boolean register(Author author) {
        author.setAuthorId(OMUtil.generateUID("A"));
        return omDao.register(author) > 0;
    }

    public boolean saveMarkdown(Markdown markdown) {
        return omDao.saveMarkdown(markdown) > 0;
    }

    public List<Markdown> getMarkdowns(long authorId) {
        return omDao.getMarkdowns(authorId);
    }

    public Markdown getMarkdown(long authorId, long markdownId) {
        return omDao.getMarkdown(authorId, markdownId);
    }

    public Author getAuthor(long authorId) {
        return omDao.getAuthor(authorId);
    }

    public boolean emailIsExist(String email) {
        return omDao.emailIsExist(email) > 0;
    }

    public Author login(String email, String password) {
        return omDao.login(email, password);
    }
}
