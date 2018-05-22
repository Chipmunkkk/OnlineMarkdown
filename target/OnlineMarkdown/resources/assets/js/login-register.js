function login() {
    var email = $("#email").val();
    var password = $("#password").val();
    if (email == '') {
        showError("请输入邮箱哦～");
        return;
    }
    if (password == '') {
        showError("密码不能为空呀～");
        return;
    }
    $.ajax({
        type: "POST",
        url: "/OnlineMarkdown/loginConfirm",
        data: {
            email: email,
            password: password
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
    var re_password = $("#re-password").val();
    var nickname = $("#nickname").val();
    var email = $("#email").val();

    if (nickname == '') {
        showError("给自己起一个好听的名字吧～");
        return;
    }
    if (email == '') {
        showError("请输入邮箱哦～");
        return;
    }
    if (password == '' || re_password == '') {
        showError("密码不能为空呀～");
        return;
    }
    if (password.length < 6) {
        showError("密码至少6位哟～");
        return;
    }
    if (password != '' && re_password != '') {
        if (password != re_password) {
            showError("两次输入的密码不一样啊～");
            return;
        }
    }
    $.ajax({
        type: "POST",
        url: "/OnlineMarkdown/registerConfirm",
        data: {
            nickname: nickname,
            email: email,
            password: password
        },
        success: function (data) {
            if (data.success == 0) {
                window.location.href = "/OnlineMarkdown/login";
            } else {
                showError(data.msg);
            }
        },
        error: function () {
            showError("请求失败，请重试");
        }
    });

}

function showError(msg) {
    $('.error').addClass('alert alert-danger').html(msg);
    $('input[type="password"]').val('');
}

function checkEmail() {
    var email = $("#email").val();
    verifyEmail(email);
    $.ajax({
        type: "POST",
        url: "/OnlineMarkdown/check",
        data: {
            email: email
        },
        success: function (data) {
            if (data.success == 0) {
                $('#btn-register').removeAttr('disabled');
            } else {
                showError("该邮箱已被注册，请更换邮箱地址～");
            }
        },
        error: function () {
            showError("请求失败，请重试");
        }
    });
}

function verifyEmail(email) {
    //对电子邮件的验证
    var myreg = /^([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/;
    if (!myreg.test(email)) {
        showError('请输入有效的邮箱地址！');
        $("#email").focus();
        return false;
    }
}
   