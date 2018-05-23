<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="renderer" content="webkit">
    <title>登录</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/assets/css/animate.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/assets/css/style.css">
    <link href="${pageContext.request.contextPath}/resources/assets/css/login-register.css" rel="stylesheet"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/editormd.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/editormd.min.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/editormd.preview.min.css"/>
    <!-- Modernizr JS -->
    <script src="${pageContext.request.contextPath}/resources/assets/js/modernizr-2.6.2.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/assets/js/login-register.js"
            type="text/javascript"></script>
</head>
<body>
<div class="container">
    <div class="row">
        <div class="col-md-4 col-md-push-8">
            <!-- Start Sign In Form -->
            <form action="#" class="fh5co-form animate-box" data-animate-effect="fadeInRight">
                <h2>登录</h2>
                <div class="error"></div>
                <div class="form-group">
                    <label for="email" class="sr-only">邮箱</label>
                    <input type="email" class="form-control" id="email" name="email" placeholder="邮箱"
                           autocomplete="email">
                </div>
                <div class="form-group">
                    <label for="password" class="sr-only">密码</label>
                    <input type="password" class="form-control" id="password" name="password" placeholder="密码"
                           autocomplete="off">
                </div>
                <div class="form-group">
                    <p><label for="remember"><input type="checkbox" id="remember"> 记住我</label>
                        | <a href="forgot3.html">忘记密码？</a></p>
                </div>
                <div class="form-group">
                    <p>还没有账户么？<a href="${pageContext.request.contextPath}/register">快去创建一个账户吧～</a>
                    </p>
                </div>
                <div class="form-group">
                    <input type="button" value="登录" class="btn btn-primary" onclick="login()">
                </div>
            </form>

        </div>
    </div>
    <div class="row"
         style="padding-top: 60px;clear: both;position: absolute;bottom: 10px;left: 50%;transform: translateX(-50%);">
        <div class="col-md-12 text-center">
            <p>
                <small>&copy;&nbsp;<span id="newYear"></span>
                    , made with <i class="fa fa-heart heart" aria-hidden="true"></i> by <a
                            href="https://blog.shaozb.xin" target="_blank">Shaozb </a>.<a
                            href="http://www.miitbeian.gov.cn"
                            target="_blank">辽ICP备18000573号</a>
                </small>
            </p>
        </div>
    </div>
</div>
<script src="${pageContext.request.contextPath}/resources/js/jquery.min.2.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/bootstrap.min.js"></script>
<!-- Placeholder -->
<script src="${pageContext.request.contextPath}/resources/assets/js/jquery.placeholder.min.js"></script>
<!-- Waypoints -->
<script src="${pageContext.request.contextPath}/resources/assets/js/jquery.waypoints.min.js"></script>
<!-- Main JS -->
<script src="${pageContext.request.contextPath}/resources/assets/js/main.js"></script>
<script src="${pageContext.request.contextPath}/resources/assets/js/online-markdown.js"></script>
<script src=""
</body>
</html>
