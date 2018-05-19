<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="renderer" content="webkit">
    <title>Online Markdown</title>

    <script src="${pageContext.request.contextPath}/resources/js/jquery.min.js"></script>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/editormd.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/editormd.min.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/editormd.preview.min.css"/>
    <script type="application/javascript"
            src="${pageContext.request.contextPath}/resources/js/editormd.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/lib/marked.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/lib/prettify.min.js"></script>

    <link rel="stylesheet" href="http://cdn.static.runoob.com/libs/bootstrap/3.3.7/css/bootstrap.min.css">
    <!-- Animation library for notifications   -->
    <link href="${pageContext.request.contextPath}/resources/assets/css/animate.min.css" rel="stylesheet"/>

    <!--  Paper Dashboard core CSS    -->
    <link href="${pageContext.request.contextPath}/resources/assets/css/paper-dashboard.css" rel="stylesheet"/>

    <!--  CSS for Demo Purpose, don't include it in your project     -->
    <link href="${pageContext.request.contextPath}/resources/assets/css/demo.css" rel="stylesheet"/>

    <link href="${pageContext.request.contextPath}/resources/assets/css/themify-icons.css" rel="stylesheet">

    <%--<link href="${pageContext.request.contextPath}/resources/assets/css/bootstrap.css" rel="stylesheet"/>--%>

    <link href="${pageContext.request.contextPath}/resources/assets/css/login-register.css" rel="stylesheet"/>

    <script src="${pageContext.request.contextPath}/resources/assets/js/jquery-1.10.2.js"
            type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/resources/assets/js/bootstrap.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/resources/assets/js/login-register.js"
            type="text/javascript"></script>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/assets/css/online-markdown.css"/>
</head>

<body>
<jsp:include page="modal/modal_dialog.jsp"/>
<jsp:include page="modal/modal_login_register.jsp"/>