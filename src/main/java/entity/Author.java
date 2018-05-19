package entity;

import lombok.Data;

@Data
public class Author {

    private long authorId;
    private String nickname;
    private String description;
    private String avatar;
    private String email;
    private String password;

    public Author(){

    }

    public Author(String nickname, String email, String password) {
        this.nickname = nickname;
        this.email = email;
        this.password  = password;
    }
}
