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
                '<input id="email" class="form-control" type="text" placeholder="邮箱" name="email">' +
                '<input id="password" class="form-control" type="password" placeholder="密码" name="password">' +
                '<input id="password_confirmation" class="form-control" type="password" placeholder="确认密码" name="password_confirmation">' +
                '<input class="btn btn-default btn-register" type="submit" value="注册" name="commit" onclick="register()">' +
                '</div>';
            $('.registerBox').html(registerHtml).fadeIn('fast');
            $('.register-footer').fadeIn('fast');
        });
        $('.modal-title').html('注册');
    });
    $('.error').removeClass('alert alert-danger').html('');

}

function showLoginForm() {
    $('.registerBox').fadeOut('fast', function () {
        $('.registerBox').html('');
        $('.register-footer').fadeOut('fast', function () {
            var loginHtml =
                '<div>' +
                '<input id="email" class="form-control" type="text" placeholder="邮箱" name="email">' +
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

function openLoginModal() {
    showLoginForm();
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
    /*   Remove this comments when moving to server
    $.post( "/login", function( data ) {
            if(data == 1){
                window.location.replace("/home");            
            } else {
                 shakeModal(); 
            }
        });
    */

    /*   Simulate error message from the server   */
    shakeModal("用户名或密码错误，请重试～");
}

function register() {
    console.log($("#password").val());
    console.log($("#password_confirmation").val());
    if ($("#password").val() != '' || $("#password_confirmation").val() != '') {
        shakeModal("密码不能为空～")
    } else if ($("#password").val().length < 6) {
        shakeModal("密码至少6位～");
    } else if ($("#password").val() != '' && $("#password_confirmation").val() != '') {
        if ($("#password").val() != $("#password_confirmation").val()) {
            shakeModal("两次输入的密码不一致～");
        }
    } else {
        $.ajax({
            type: "POST",
            url: "/OnlineMarkdown/register",
            data: {
                nickname: $("#nickname").val(),
                email: $("#email").val(),
                password: $("#password").val(),
                password_confirmation: $("#password_confirmation").val()
            },
            success: function (data) {
                console.log(data);
            },
            error: function () {
                console.log("error")
            }
        });
    }
}

function shakeModal(msg) {
    $('#loginModal .modal-dialog').addClass('shake');
    $('.error').addClass('alert alert-danger').html(msg);
    $('input[type="password"]').val('');
    setTimeout(function () {
        $('#loginModal .modal-dialog').removeClass('shake');
    }, 1000);
}

   