package entity;

import lombok.Data;

import java.util.Date;

@Data
public class Markdown {

    private long markdownId;
    private long authorId;
    private Date updateDate;
    private String title;
    private String content;
    private int num;

}
