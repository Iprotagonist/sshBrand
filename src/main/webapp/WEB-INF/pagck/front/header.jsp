<%--
  Created by IntelliJ IDEA.
  User: thundersoft
  Date: 2017/12/13
  Time: 15:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<link rel="stylesheet" href="/res/css/style.css"/>
<script type="text/javascript">
    //登陆
    function login() {
        //window.location.href值是 :http://localhost:8080/front/product/toList
        window.location.href = "/buyer/toLogin?returnUrl=" + window.location.href;
    }

    function logout() {
        window.location.href = "/buyer/logout";
    }

    function delItem(id) {
        window.location.href = "/item/del/"+id;
    }

    function toCart() {
        window.location.href = "/buyer/toCart";
    }

    function myOrder() {
        window.location.href = "/buyer/toOrder";
    }
</script>
<div class="bar">
    <div class="bar_w">
        <p class="l">
		<span class="l">
			收藏本网站！北京<a href="#" title="更换">[更换]</a>
		</span>
        </p>
        <ul class="r uls">
            <li class="dev">您好,欢迎来到易行运动网！</li>
            <c:if test="${empty sessionScope.buyer}">
                <li class="dev"><a href="javascript:void(0)" onclick="login()" title="登陆">[登陆]</a></li>
                <li class="dev"><a href="javascript:void(0)" onclick="register()" title="免费注册">[免费注册]</a></li>
            </c:if>
            <c:if test="${!empty sessionScope.buyer}">
                <li class="dev"><a href="javascript:void(0)" onclick="logout()" title="退出">[退出]</a></li>
                <li class="dev"><a href="javascript:void(0)" onclick="myOrder()" title="我的订单">我的订单</a></li>
            </c:if>
            <li class="dev"><a href="#" title="在线客服">在线客服</a></li>
            <li class="dev after"><a href="#" title="English">English</a></li>
        </ul>
    </div>
</div>