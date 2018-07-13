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
                        returnUrl:'${returnUrl}'
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
                                window.location.href = result.returnUrl;
                        }
                    })
                }
            });
        })
    </script>
</head>
<body>
<div class="bar">
    <div class="bar_w">
        <p class="l">
		<span class="l">
			收藏本网站！北京<a href="#" title="更换">[更换]</a>
		</span>
        </p>
        <ul class="r uls">
            <li class="dev">您好,欢迎来到易行运动网！</li>
            <li class="dev"><a href="#" title="在线客服">在线客服</a></li>
            <li class="dev after"><a href="#" title="English">English</a></li>
        </ul>
    </div>
</div>
<div class="w loc">
    <div class="h-title" id="logo">
        <div class="h-logo l"><img src="/res/img/pic/logo-1.png"/></div>
        <div class="l" style="margin: 13px 10px;font-size: 20px;font-family: '微软雅黑';letter-spacing: 2px">欢迎登录</div>
    </div>
</div>
<div class="sign">
    <div class="l ad420x205"><a href="#" title="title"><img src="/res/img/pic/ppp0.jpg" width="400" height="400"/></a>
    </div>
    <div class="r">
        <h2 title="登录易行运动网">登录易行运动网</h2>
        <form id="jvForm" action="../buyer/index.jsp" method="post">
            <input type="hidden" name="returnUrl" value="${returnUrl}" id="returnUrl"/>
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
</div>
</body>
</html>