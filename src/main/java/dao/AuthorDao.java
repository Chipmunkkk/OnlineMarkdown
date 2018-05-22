package dao;

import entity.Author;
import entity.Markdown;

import java.util.List;

public interface AuthorDao {

    int register(Author author);

    int emailIsExist(String email);

    Author login(String email, String password);

    int updateProfile(long authorId, String nickname, String email, String password, String description);

    int getMarkdownCount(long authorId);

    List<Markdown> getMarkdowns(long authorId, int page, int per_page);

    Author getAuthor(long authorId);
}
