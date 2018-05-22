<%@ page import="entity.Markdown" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="../common/header.jsp"/>
<div class="wrapper">
    <jsp:include page="../common/sidebar.jsp">
        <jsp:param name="tabIdx" value="0"/>
    </jsp:include>
    <div class="main-panel">
        <jsp:include page="../common/nav.jsp">
            <jsp:param name="nav_title" value="Markdown Here"/>
        </jsp:include>
        <div class="content">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-md-12">
                        <div class="card">
                            <div id="my-editormd" style=";border-radius: 6px;">
                                <c:choose>
                                    <c:when test="${markdown.content ne null}">
                <textarea id="my-editormd-markdown-doc" name="my-editormd-markdown-doc"
                          style="display:none;">${markdown.content}</textarea>
                                    </c:when>
                                    <c:otherwise>
                <textarea id="my-editormd-markdown-doc" name="my-editormd-markdown-doc"
                          style="display:none;"></textarea>
                                    </c:otherwise>
                                </c:choose>
                                <!-- 注意：name属性的值-->
                                <textarea id="my-editormd-html-code" name="my-editormd-html-code"
                                          style="display:none;"></textarea>
                            </div>
                            <div id="content"
                                 class="mdl-cell mdl-card mdl-cell--12-col mdl-shadow--2dp content editormd-preview-theme-dark"
                                 style="display:none;">
                                <textarea style="display:none;" name="editormd-markdown-doc"></textarea>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <jsp:include page="../common/bottom.jsp"/>
    </div>
</div>
<script type="text/javascript">
    var markdown = JSON.parse(sessionStorage.getItem('markdown'));
    window.onload = function () {
        if (markdown != null) {
            $("#title").val(markdown.title);
        }
    }
    $(function () {
        if (markdown != null) {
            $("#my-editormd-markdown-doc").val(markdown.content);
        }
    })
    sessionStorage.removeItem('markdown');

    if (getQueryString('tag') == 0) {
        showNotice('文章保存成功', 'success')
    }

    function getQueryString(name) {
        var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");  // 匹配目标参数
        var result = window.location.search.substr(1).match(reg); // 对querystring匹配目标参数
        if (result != null) {
            return decodeURIComponent(result[2]);
        } else {
            return null;
        }
    }

    function showNotice(msg, type) {
        $.notify({
            icon: 'ti-bell',
            message: "<b>" + msg + "</b>"

        }, {
            type: type,
            timer: 4000
        });
    }

    var windowHeight = $(window).height();
    var Editormd;
    $(function () {
        Editormd = editormd("my-editormd", {
            width: "100%",
            height: windowHeight - ((74 + 30) * 2),
            syncScrolling: "single",
            path:
                "${pageContext.request.contextPath}/resources/lib/",
            emoji:
                true,//emoji表情，默认关闭
            taskList:
                true,
            tocm:
                true, // Using [TOCM]
            imageUpload:
                true,
            imageFormats:
                ["jpg", "jpeg", "gif", "png", "bmp", "webp"],
            imageUploadURL:
                "/OnlineMarkdown/upload",
            saveHTMLToTextarea:
                true,
            toolbarIcons:
                function () {
                    return ["save", "undo", "redo", "|",
                        "bold", "del", "italic", "quote", "ucwords", "uppercase", "lowercase", "|",
                        "h1", "h2", "h3", "h4", "h5", "h6", "|",
                        "list-ul", "list-ol", "hr", "|",
                        "link", "reference-link", "image", "code", "preformatted-text", "code-block", "table", "datetime", "emoji", "html-entities", "pagebreak", "|",
                        "goto-line", "watch", "preview", "fullscreen", "clear", "search", "|",
                        "help", "info", "|", "title"]
                }

            ,
            toolbarIconsClass: {
                "save":
                    "fa-save" //保存按钮
            }
            ,
            toolbarCustomIcons: {
                title: "<input type='text' id='title' value='${markdown.title}' style='border:0px;border-bottom:1px solid;width:300px' placeholder='在此输入文章标题' required='required'/>"
            }
            ,
            toolbarHandlers: {
                /**
                 * @param {Object}      cm         CodeMirror对象
                 * @param {Object}      icon       图标按钮jQuery元素对象
                 * @param {Object}      cursor     CodeMirror的光标对象，可获取光标所在行和位置
                 * @param {String}      selection  编辑器选中的文本
                 */
                "save":
                    function (cm, icon, cursor, selection) {
                        if (${sessionScope.author.authorId eq null}) {
                            var info = {
                                title: $('#title').val(),
                                content: $("#my-editormd-html-code").val(),
                                html: editormd("my-editormd").getHTML()
                            };
                            sessionStorage.setItem('markdown', JSON.stringify(info));
                            console.log("保存成功")
                            window.location.href = "/OnlineMarkdown/login";
                        }
                        if ($('#title').val() == '') {
                            $('#title').val('未命名Markdown');
                        }
                        $.ajax({
                            type: "POST",
                            <c:choose>
                            <c:when test="${markdown.content ne null}">
                            url: "/OnlineMarkdown/${sessionScope.author.authorId}/markdown/${markdown.markdownId}",
                            </c:when>
                            <c:otherwise>
                            url: "/OnlineMarkdown/${sessionScope.author.authorId}/markdown",
                            </c:otherwise>
                            </c:choose>
                            data: {
                                ${markdown.content eq null? "" :"_method: 'put',"}
                                title: $("#title").val(),
                                markdown: $("#my-editormd-html-code").val(),
                                html: editormd("my-editormd").getHTML()
                            },
                            success: function (data) {
                                window.location.href = "/OnlineMarkdown/${sessionScope.author.authorId}/markdown/" + data.mark.markdownId + "?tag=0";
                                console.log("Save success!")
                            },
                            error: function () {
                                console.log("Save failed!")
                            }
                        });
                    },
            },
            lang: {
                toolbar: {
                    "save":
                        "保存"
                }
            }
        })
        ;
    });
</script>
<script type="text/javascript">
    $(function () {
        editormd.markdownToHTML("content")
    });
</script>
<jsp:include page="../common/footer.jsp"/>