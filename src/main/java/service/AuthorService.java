package service;

import dao.AuthorDao;
import entity.Author;
import entity.Markdown;
import org.springframework.stereotype.Service;
import util.OMUtil;

import javax.annotation.Resource;
import java.util.List;

@Service
public class AuthorService {

    @Resource
    AuthorDao authorDao;

    public boolean register(Author author) {
        author.setAuthorId(OMUtil.generateUID("A"));
        return authorDao.register(author) > 0;
    }

    public Author login(String email, String password) {
        return authorDao.login(email, password);
    }

    public boolean emailIsExist(String email) {
        return authorDao.emailIsExist(email) > 0;
    }

    public Author getAuthor(long authorId) {
        return authorDao.getAuthor(authorId);
    }

    public int getMarkdownCount(long authorId) {
        return authorDao.getMarkdownCount(authorId);
    }

    public List<Markdown> getMarkdowns(long authorId, int page, int per_page) {
        return authorDao.getMarkdowns(authorId, (page - 1) * per_page, per_page);
    }

    public boolean updateProfile(long authorId, String nickname, String email, String password, String description) {
        return authorDao.updateProfile(authorId, nickname, email, password, description) > 0;
    }
}
