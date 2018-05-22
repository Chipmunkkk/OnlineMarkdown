<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="../common/header.jsp"/>
<div class="wrapper">
    <jsp:include page="../common/sidebar.jsp">
        <jsp:param name="tabIdx" value="2"/>
    </jsp:include>
    <div class="main-panel">
        <jsp:include page="../common/nav.jsp">
            <jsp:param name="nav_title" value="个人中心"/>
        </jsp:include>
        <div class="content">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-lg-4 col-md-5">
                        <div class="card card-user">
                            <div class="image">
                                <img src="${pageContext.request.contextPath}/resources/assets/img/background.jpg"/>
                            </div>
                            <div class="content">
                                <div class="author">
                                    <img class="avatar border-white"
                                         src="${pageContext.request.contextPath}/resources/assets/img/faces/face-2.jpg"
                                         alt="${author.nickname}"/>
                                    <h4 class="title">${author.nickname}</h4>
                                </div>
                                <p class="description text-center">
                                    ${author.description}
                                </p>
                            </div>
                            <hr>
                            <div class="text-center">
                                <div class="row">
                                    <div class="col-md-3 col-md-offset-1">
                                    </div>
                                    <div class="col-md-4">
                                        <h5>${count}<br/>
                                            <small>已写作</small>
                                        </h5>
                                    </div>
                                    <div class="col-md-3">
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="card" id="daily-pic-panel" style="height: 322px;">
                            <div class="header">
                                <h4 class="title"></h4>
                            </div>
                            <div class="content">

                            </div>
                        </div>
                    </div>
                    <div class="col-lg-8 col-md-7">
                        <div class="card" id="markdown-panel">
                            <div class="header">
                                <h4 class="title">我的信息</h4>
                                <hr>
                            </div>
                            <div class="content" style="position: relative;padding-top: 5px;">
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="form-group">
                                            <label>用户名</label>
                                            <input type="text" class="form-control border-input" autocomplete="off"
                                                   id="nickname"
                                                   placeholder="用户名" value="${author.nickname}"
                                                   style="border: 0px;border-bottom: 1px solid #CCC5B9; background-color: white;border-radius: 0px;">
                                            <input type="hidden" id="authorId" value="${author.authorId}">
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="form-group">
                                            <label>邮箱</label>
                                            <input type="email" class="form-control border-input" autocomplete="off"
                                                   id="email"
                                                   placeholder="电子邮箱" value="${author.email}"
                                                   style="border: 0px;border-bottom: 1px solid #CCC5B9; background-color: white;border-radius: 0px;">
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="form-group">
                                            <label>密码</label>
                                            <input type="password" class="form-control border-input" id="password"
                                                   autocomplete="off"
                                                   placeholder="密码" value="${author.password}"
                                                   style="border: 0px;border-bottom: 1px solid #CCC5B9; background-color: white;border-radius: 0px;">
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="form-group">
                                            <label>确认密码</label>
                                            <input type="password" class="form-control border-input"
                                                   id="re-password"
                                                   autocomplete="off"
                                                   placeholder="确认密码" value="${author.password}"
                                                   style="border: 0px;border-bottom: 1px solid #CCC5B9; background-color: white;border-radius: 0px;">
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="form-group">
                                            <label>个人简介</label>
                                            <textarea rows="5" class="form-control border-input" id="description"
                                                      placeholder="简单的介绍下自己吧～"
                                                      style="background-color: white;">${author.description}</textarea>
                                        </div>
                                    </div>
                                </div>
                                <div class="text-center">
                                    <button type="submit" id="btn_update" class="btn btn-info btn-fill btn-wd"
                                            onclick="updateProfile()">更新信息
                                    </button>
                                </div>
                                <div class="clearfix"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <jsp:include page="../common/bottom.jsp"/>
    </div>
</div>
<script>
    function updateProfile() {
        var button = $('#btn_update');

        var authorId = $('#authorId').val();
        var nickname = $('#nickname').val();
        var email = $('#email').val();
        var password = $('#password').val();
        var re_password = $('#re-password').val();
        var description = $('#description').val();
        console.log(password)
        console.log(re_password)
        console.log(password == re_password)
        console.log(authorId)
        if (password == '' || re_password == '') {
            showNotice("密码不能为空呀～");
            button.attr("disable", true);
            return;
        }
        if (password.length < 6) {
            showNotice("密码至少6位哟～");
            button.attr("disable", true);
            return;
        }
        if (password != '' && re_password != '') {
            if (password != re_password) {
                showNotice("两次输入的密码不一样啊～");
                button.attr("disable", true);
                return;
            }
        }
        button.removeAttr("disable");
        $.ajax({
            type: "POST",
            url: "/OnlineMarkdown/" + authorId + "/edit",
            data: {
                _method: "put",
                nickname: nickname,
                email: email,
                password: password,
                description: description
            },
            success: function (data) {
                if (data.success == 0) {
                    window.location.reload();
                }
            },
            error: function (data) {
                console.log(data)
            }
        })
    }

    function showNotice(msg) {
        $.notify({
            icon: 'ti-bell',
            message: "<b>" + msg + "</b>"

        }, {
            type: 'warning',
            timer: 4000
        });
    }
</script>
<jsp:include page="../common/footer.jsp"/>