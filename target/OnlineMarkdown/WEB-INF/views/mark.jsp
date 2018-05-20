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
        <textarea id="my-editormd-markdown-doc" name="my-editormd-markdown-doc"
                  style="display:none;">${markdown.content}</textarea>
                                <!-- 注意：name属性的值-->
                                <textarea id="my-editormd-html-code" name="my-editormd-html-code"
                                          style="display:none;"></textarea>
                            </div>
                            <div id="content"
                                 class="mdl-cell mdl-card mdl-cell--12-col mdl-shadow--2dp content editormd-preview-theme-dark"
                                 style="display:none;">
                                <textarea style="display:none;" name="editormd-markdown-doc"></textarea>
                            </div>
                            <input type="hidden" id="auto-saver-status" value="true">
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <jsp:include page="../common/bottom.jsp"/>
    </div>
</div>
<script type="text/javascript">
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
            tex:
                true,// 开启科学公式TeX语言支持，默认关闭

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
                    return ["save-button", "auto-save", "undo", "redo", "|",
                        "bold", "del", "italic", "quote", "ucwords", "uppercase", "lowercase", "|",
                        "h1", "h2", "h3", "h4", "h5", "h6", "|",
                        "list-ul", "list-ol", "hr", "|",
                        "link", "reference-link", "image", "code", "preformatted-text", "code-block", "table", "datetime", "emoji", "html-entities", "pagebreak", "|",
                        "goto-line", "watch", "preview", "fullscreen", "clear", "search", "|",
                        "help", "info"]
                }

            ,
            toolbarIconsClass: {
                "save-button":
                    "fa-save", //保存按钮
                "auto-save":
                    "fa-clock-o" //自动保存按钮,默认开启自动保存
            }
            ,
            toolbarHandlers: {
                /**
                 * @param {Object}      cm         CodeMirror对象
                 * @param {Object}      icon       图标按钮jQuery元素对象
                 * @param {Object}      cursor     CodeMirror的光标对象，可获取光标所在行和位置
                 * @param {String}      selection  编辑器选中的文本
                 */
                "save-button":

                    function (cm, icon, cursor, selection) {
                        $.ajax({
                            type: "POST",
                            url: "/OnlineMarkdown/0/markdown/0",
                            data: {
                                _method: "put",
                                content: $("#my-editormd-html-code").val(),
                                title: editormd("my-editormd").getHTML()
                            },
                            success: function (data) {
                                console.log("Save success!");
                            },
                            error: function () {
                                console.log("Save failed!")
                            }
                        });
                    }

                ,
            }
            ,
            lang: {
                toolbar: {
                    "save-button":
                        "保存",
                    "auto-save":
                        "自动保存，每5分钟自动保存一次，默认开启"
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