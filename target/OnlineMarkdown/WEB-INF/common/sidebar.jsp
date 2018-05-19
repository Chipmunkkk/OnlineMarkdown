<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="sidebar" data-background-color="white" data-active-color="info">

    <!--
        Tip 1: you can change the color of the sidebar's background using: data-background-color="white | black"
        Tip 2: you can change the color of the active button using the data-active-color="primary | info | success | warning | danger"
    -->

    <div class="sidebar-wrapper">
        <div class="logo">
            <a href="#" class="simple-text">
                Online Markdown
            </a>
        </div>

        <ul class="nav" style="float:none;">
            <li ${param.tabIdx eq 0?"class='active'":''}>
                <a href="${pageContext.request.contextPath}/mark">
                    <i class="ti-write"></i>
                    <p>Post 一篇</p>
                </a>
            </li>

            <li ${param.tabIdx eq 1?"class='active'":''}>
                <a href="${pageContext.request.contextPath}/0">
                    <i class="ti-list"></i>
                    <p>Get 一下</p>
                </a>
            </li>

            <li class="active-pro">
                <a href="upgrade.html">
                    <p style="text-align: center">关于</p>
                </a>
            </li>
        </ul>
    </div>
</div>