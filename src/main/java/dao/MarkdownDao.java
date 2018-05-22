package dao;

import entity.Markdown;

public interface MarkdownDao {

    int saveMarkdown(Markdown markdown);

    Markdown getMarkdown(long authorId, long markdownId);

    int createMarkdown(Markdown markdown);

    int deleteMarkdown(long authorId, long markdownId);

}
