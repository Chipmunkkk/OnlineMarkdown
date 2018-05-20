<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="sidebar" data-background-color="white" data-active-color="info">
    <div class="sidebar-wrapper">
        <div class="logo">
            <a href="#" class="simple-text">
                在线<br>Markdown 编辑器
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
                <c:choose>
                <c:when test="${sessionScope.author.authorId eq null}">
                <a data-toggle="modal" href="javascript:void(0)" onclick="openLoginModal('');">
                    </c:when>
                    <c:otherwise>
                    <a href="${pageContext.request.contextPath}/${sessionScope.author.authorId}">
                        </c:otherwise>
                        </c:choose>
                        <i class="ti-list"></i>
                        <p>Get 一下</p>
                    </a>
            </li>
            <li class="active-pro">
                <a href="https://github.com/Chipmunkkk" target="_blank">
                    <p style="text-align: center">关于</p>
                </a>
            </li>
        </ul>
    </div>
</div>