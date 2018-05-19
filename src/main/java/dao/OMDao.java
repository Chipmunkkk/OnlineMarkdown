package dao;

import entity.Author;
import entity.Markdown;

import java.util.List;

public interface OMDao {

    int saveMarkdown(Markdown markdown);

    List<Markdown> getMarkdowns(long authorId);

    Markdown getMarkdown(long authorId, long markdownId);

    Author getAuthor(long authorId);

    int register(Author author);

    int emailIsExist(String email);

    Author login(String email, String password);
}
