<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<nav class="navbar navbar-default">
    <div class="container-fluid">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar bar1"></span>
                <span class="icon-bar bar2"></span>
                <span class="icon-bar bar3"></span>
            </button>
            <a class="navbar-brand" href="#">${param.nav_title}</a>
        </div>
        <div class="collapse navbar-collapse">
            <ul class="nav navbar-nav navbar-right">
                <c:choose>
                    <c:when test="${sessionScope.author ne null}">
                        <li>
                            <a>
                                <p>${sessionScope.author.nickname}</p>
                            </a>
                        </li>
                        <li>
                            <a data-toggle="modal"
                               href="${pageContext.request.contextPath}/${sessionScope.author.authorId}">
                                <p>编辑信息</p>
                            </a>
                        </li>
                        <li>
                            <a data-toggle="modal" href="${pageContext.request.contextPath}/logout">
                                <p>注销</p>
                            </a>
                        </li>
                    </c:when>
                    <c:otherwise>
                        <li>
                            <a data-toggle="modal" href="javascript:void(0)" onclick="openLoginModal('');">
                                <p>登录</p>
                            </a>
                        </li>
                        <li>
                            <a data-toggle="modal" href="javascript:void(0)" onclick="openRegisterModal();">
                                <p>注册</p>
                            </a>
                        </li>
                    </c:otherwise>
                </c:choose>
            </ul>

        </div>
    </div>
</nav>