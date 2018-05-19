<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="modal fade login" id="loginModal">
    <div class="modal-dialog login animated">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title">登录</h4>
            </div>
            <div class="modal-body">
                <div class="box">
                    <div class="content">
                        <div class="error"></div>
                        <div class="form loginBox"></div>
                        <div class="form registerBox"></div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <div class="forgot login-footer">
                            <span>还没有账户么？
                                 <a href="javascript: showRegisterForm();">快去创建一个账户～</a>
                            </span>
                </div>
                <div class="forgot register-footer" style="display:none">
                    <span>已经有账户了？</span>
                    <a href="javascript: showLoginForm();">那就登录吧～</a>
                </div>
            </div>
        </div>
    </div>
</div>