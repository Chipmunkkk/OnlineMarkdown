<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="../common/header.jsp"/>
<div class="wrapper">
    <jsp:include page="../common/sidebar.jsp">
        <jsp:param name="tabIdx" value="1"/>
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
                        <div class="card" id="daily-pic-panel">
                            <%--<div class="row">--%>
                            <%--<div class="col-sm-6 col-md-4">--%>
                            <%--<div class="thumbnail">--%>
                            <%--<img src="..." alt="...">--%>
                            <%--<div class="caption">--%>
                            <%--<h3>Thumbnail label</h3>--%>
                            <%--<p>...</p>--%>
                            <%--<p><a href="#" class="btn btn-primary" role="button">Button</a> <a href="#"--%>
                            <%--class="btn btn-default"--%>
                            <%--role="button">Button</a>--%>
                            <%--</p>--%>
                            <%--</div>--%>
                            <%--</div>--%>
                            <%--</div>--%>
                            <%--</div>--%>
                            <div class="header">
                                <h4 class="title">Team Members</h4>
                            </div>
                            <div class="content">

                            </div>
                        </div>
                    </div>
                    <div class="col-lg-8 col-md-7">
                        <div class="card" id="markdown-panel">
                            <div class="header">
                                <h4 class="title">我的Markdown</h4>
                                <hr>
                            </div>
                            <div class="content" style="position: relative;padding-top: 5px;">
                                <ul class="list-group" id="markdown-list">
                                    <c:forEach items="${markdowns}" var="markdown" varStatus="idx">
                                        <li class="list-group-item"><a
                                                href="./${markdown.authorId}/markdown/${markdown.markdownId}">
                                                ${idx.index + 1}. ${markdown.title}</a>
                                            <small><fmt:formatDate value="${markdown.updateDate}" type="date"
                                                                   dateStyle="full"/></small>
                                            <span class="glyphicon glyphicon-trash" aria-hidden="true"
                                                  data-toggle="modal" data-target="#markdown_alert"></span></li>
                                    </c:forEach>
                                </ul>
                            </div>
                            <ul class="pagination">
                                <c:choose>
                                    <c:when test="${current_page eq 1}">
                                        <li class="disabled">
                                            <a href="#" aria-label="Previous">
                                                <span aria-hidden="true">&laquo;</span>
                                            </a>
                                        </li>
                                    </c:when>
                                    <c:otherwise>
                                        <li><a href="${pageContext.request.contextPath}/0/?page=${current_page - 1}"
                                               aria-label="Previous">
                                            <span aria-hidden="true">&laquo;</span></a>
                                        </li>
                                    </c:otherwise>
                                </c:choose>
                                <c:forEach begin="1" end="${total_pages}" varStatus="idx">
                                    <li ${idx.index eq current_page?"class='am-active'":''}><a
                                            href="${pageContext.request.contextPath}/0/?page=${idx.index}">${idx.index}</a>
                                    </li>
                                </c:forEach>
                                <c:choose>
                                    <c:when test="${current_page eq total_pages}">
                                        <li class="disabled">
                                            <a href="#" aria-label="Next">
                                                <span aria-hidden="true">&raquo;</span>
                                            </a>
                                        </li>
                                    </c:when>
                                    <c:otherwise>
                                        <li>
                                            <a href="${pageContext.request.contextPath}/0/?page=${current_page + 1}"
                                               aria-label="Next">
                                                <span aria-hidden="true">&raquo;</span></a>
                                        </li>
                                    </c:otherwise>
                                </c:choose>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <jsp:include page="../common/bottom.jsp"/>
    </div>
</div>
<jsp:include page="../common/footer.jsp"/>