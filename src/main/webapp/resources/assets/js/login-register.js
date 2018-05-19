/*
 *
 * login-register modal
 * Autor: Creative Tim
 * Web-autor: creative.tim
 * Web script: #
 * 
 */
function showRegisterForm() {
    $('.loginBox').fadeOut('fast', function () {
        $('.loginBox').html('');
        $('.login-footer').fadeOut('fast', function () {
            var registerHtml =
                '<div>' +
                '<input id="nickname" class="form-control" type="text" placeholder="用户名" name="nickname">' +
                '<input id="email" class="form-control" onchange="checkEmail()" type="text" placeholder="邮箱" name="email">' +
                '<input id="password" class="form-control" type="password" placeholder="密码" name="password">' +
                '<input id="password_confirmation" class="form-control" type="password" placeholder="确认密码" name="password_confirmation">' +
                '<input class="btn btn-default btn-register" type="submit" value="注册" disabled="disabled" onclick="register()">' +
                '</div>';
            $('.registerBox').html(registerHtml).fadeIn('fast');
            $('.register-footer').fadeIn('fast');
        });
        $('.modal-title').html('注册');
    });
    $('.error').removeClass('alert alert-danger').html('');

}

function showLoginForm(email) {
    $('.registerBox').fadeOut('fast', function () {
        $('.registerBox').html('');
        $('.register-footer').fadeOut('fast', function () {
            var loginHtml =
                '<div>' +
                '<input id="email" class="form-control" type="text" placeholder="邮箱" name="email" value="' + email + '">' +
                '<input id="password" class="form-control" type="password" placeholder="密码" name="password">' +
                '<input class="btn btn-default btn-login" type="button" value="登录" onclick="login()">' +
                '</div>';

            $('.loginBox').html(loginHtml).fadeIn('fast');
            $('.login-footer').fadeIn('fast');
        });
        $('.modal-title').html('登录');
    });
    $('.error').removeClass('alert alert-danger').html('');
}

function openLoginModal(email) {
    showLoginForm(email);
    setTimeout(function () {
        $('#loginModal').modal('show');
    }, 230);

}

function openRegisterModal() {
    showRegisterForm();
    setTimeout(function () {
        $('#loginModal').modal('show');
    }, 230);

}

function login() {
    var email = $("#email").val();
    var password = $("#password").val();
    if (email == '') {
        shakeModal("请输入邮箱哦～");
        return;
    }
    if (password == '') {
        shakeModal("密码不能为空呀～");
        return;
    }
    $.ajax({
        type: "POST",
        url: "/OnlineMarkdown/login",
        data: {
            email: email,
            password: password,
        },
        success: function (data) {
            if (data.success == 0) {
                window.location.href = "/OnlineMarkdown";
            } else {
                shakeModal(data.msg);
            }
        },
        error: function () {
            shakeModal("请求失败，请重试");
        }
    });
}

function register() {
    var password = $("#password").val();
    var password_confirmation = $("#password_confirmation").val();
    var nickname = $("#nickname").val();
    var email = $("#email").val();

    if (nickname == '') {
        shakeModal("给自己起一个好听的名字吧～");
        return;
    }
    if (email == '') {
        shakeModal("请输入邮箱哦～");
        return;
    }
    if (password == '' || password_confirmation == '') {
        shakeModal("密码不能为空呀～");
        return;
    }
    if (password.length < 6) {
        shakeModal("密码至少6位哟～");
        return;
    }
    if (password != '' && password_confirmation != '') {
        if (password != password_confirmation) {
            shakeModal("两次输入的密码不一样啊～");
            return;
        }
    }
    $.ajax({
        type: "POST",
        url: "/OnlineMarkdown/register",
        data: {
            nickname: nickname,
            email: email,
            password: password,
            password_confirmation: password_confirmation
        },
        success: function (data) {
            if (data.success == 0) {
                openLoginModal($("#email").val());
            } else {
                shakeModal(data.msg);
            }
        },
        error: function () {
            shakeModal("请求失败，请重试");
        }
    });

}

function shakeModal(msg) {
    $('#loginModal .modal-dialog').addClass('shake');
    $('.error').addClass('alert alert-danger').html(msg);
    $('input[type="password"]').val('');
    setTimeout(function () {
        $('#loginModal .modal-dialog').removeClass('shake');
    }, 1000);
}

function checkEmail() {
    $.ajax({
        type: "POST",
        url: "/OnlineMarkdown/check",
        data: {
            email: $("#email").val(),
        },
        success: function (data) {
            if (data.success == 0) {
                $('.btn-register').removeAttr('disabled');
            }
        },
        error: function () {
            shakeModal("请求失败，请重试");
        }
    });
}

   