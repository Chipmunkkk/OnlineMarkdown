<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- 模态框（Modal） -->
<div class="modal fade" id="markdown_alert" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 class="modal-title" id="myModalLabel">
                    警告
                </h4>
            </div>
            <div class="modal-body">
                你,确定要删除这篇文章
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭
                </button>
                <button type="button" class="btn btn-danger" id="btn-delete">
                    确定
                </button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>
<!-- Notifications Plugin -->
<script src="${pageContext.request.contextPath}/resources/assets/js/bootstrap-notify.js"></script>
<script>
    $('#markdown_alert').on('show.bs.modal', function (event) {
        var span = $(event.relatedTarget);
        var markdownId = span.context.dataset.markdownid;
        var markdownTitle = span.context.dataset.markdowntitle;
        var authorId = span.context.dataset.authorid;
        var modal = $(this);
        modal.find('#btn-delete').click(function () {
            $.ajax({
                type: "POST",
                url: "/OnlineMarkdown/" + authorId + "/markdown/" + markdownId,
                data: {
                    _method: "delete"
                },
                success: function (data) {
                    if (data.success == 0) {
                        window.location.reload();
                    }
                },
                error: function () {
                    console.log(data)
                }
            })
        })
    })
</script>