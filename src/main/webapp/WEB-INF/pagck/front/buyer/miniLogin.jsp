<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <title>登录_易行运动网</title>
    <link rel="stylesheet" href="/res/css/style.css"/>
    <script type="text/javascript" src="/res/assets/js/jquery-1.11.3.min.js"></script>
    <script type="text/javascript">
        function img() {
            $('.code').prop("src", "/buyer/kaptcha?d=" + new Date());
        }

        $(function () {
            $('#submitBtn').click(function () {
                var username = $('#username').val();
                var password = $('#password').val();
                var kaptcha = $('#kaptcha').val();
                var skuId = $('#skuId').val();
                var amount = $('#amount').val();
                if (username == '') {
                    $('#errorName').show();
                    $("#message").html("请输入用户名！");
                    img();
                    return false;
                } else if (password == '') {
                    $('#errorName').show();
                    $("#message").html("请输入密码！");
                    img();
                    return false;
                } else if (kaptcha == '') {
                    $('#errorName').show();
                    $("#message").html("请输入验证码！");
                    img();
                    return false;
                } else {
                    $.post("/buyer/login", {
                        username: username,
                        password: password,
                        kaptcha: kaptcha,
                        returnUrl: "/buyer/addItem"
                    }, function (result) {
                        var status = result.status;
                        switch (status) {
                            case 1:
                                $('#errorName').show();
                                $("#message").html("验证码输入不正确！");

                                //清空验证码
                                $('#kaptcha').val('');
                                //重新生成验证码
                                img();
                                break;
                            case 3:
                                $('#errorName').show();
                                $("#message").html("账号或密码不正确！");
                                //清空原来的账号和密码
                                $('#username').val('');
                                $('#password').val('');
                                //清空验证码
                                $('#kaptcha').val('');
                                //重新生成验证码
                                img();
                                break;
                            case 2:
                                var url = result.returnUrl + '?skuId=' + skuId + "&amount=" + amount ;
                                parent.location.href = url;
                        }
                    })
                }
            });
        })
    </script>
</head>
<body>
<div style="width: 300px;height: 150px">
        <form id="jvForm" action="../buyer/index.jsp" method="post">
            <input type="hidden" value="${skuId}" name="skuId" id="skuId">
            <input type="hidden" value="${amount}" name="amount" id="amount">
            <ul class="uls form">
                <li id="errorName" class="errorTip" style="display: none">
                    <div id="message"></div>
                </li>
                <li><label for="username">用户名：</label>
                    <span class="bg_text">
					<input type="text" id="username" name="username" maxLength="100"/>
				</span>
                </li>
                <li><label for="password">密　码：</label>
                    <span class="bg_text">
					<input type="password" id="password" name="password" maxLength="32"/>
				</span>
                </li>
                <li><label for="kaptcha">验证码：</label>
                    <span class="bg_text small">
					<input type="text" id="kaptcha" name="kaptcha" maxLength="7"/>
				</span>
                    <img src="/buyer/kaptcha" onclick="img()" class="code"
                         alt="换一张"/><a href="javascript:void(0);" onclick="img()" title="换一张">换一张</a></li>
                <li><label for="submitBtn">&nbsp;</label><input id="submitBtn" type="button" value="登 录"
                                                                class="hand btn66x23"/><a href="#"
                                                                                          title="忘记密码？">忘记密码？</a>
                </li>
            </ul>
        </form>

</div>
</body>
</html>