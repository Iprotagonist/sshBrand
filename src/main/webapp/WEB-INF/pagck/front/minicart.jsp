<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: thundersoft
  Date: 2017/12/13
  Time: 15:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<link rel="stylesheet" href="/res/css/style.css"/>
<script type="text/javascript">
    function delItem(id) {
        window.location.href = "/item/del/"+id;
    }

    function toCart() {
        window.location.href = "/buyer/toCart";
    }
</script>
<dl id="cart" class="cart r">
    <dt><a href="#" title="结算">结算</a>购物车:<b id=""><c:if test="${empty sessionScope.buyer}">0</c:if><c:if
            test="${!empty sessionScope.buyer}">${total}</c:if></b>件
    </dt>
    <dd class="hidden">
        <p class="alg_c hidden">购物车中还没有商品，赶紧选购吧！</p>
        <h3 title="最新加入的商品">最新加入的商品</h3>
        <c:if test="${!empty sessionScope.buyer}">
            <ul class="uls">
                <c:forEach items="${items}" var="item">
                    <li>
                        <a href="#"
                           title="${item.productName}">
                            <img src="/upload/${item.img}"
                                 alt="${item.productName}"/></a>
                        <p class="dt"><a href="#"
                                         title="${item.productName}">${item.productName}</a></p>
                        <p class="dd">
                            <b><var>¥${item.skuprice}</var><span>x${item.amount}</span></b>
                            <a href="javascript:void(0);" title="删除" class="del" onclick="delItem('${item.id}')">删除</a>
                        </p>
                    </li>
                </c:forEach>
            </ul>
            <div>
                <p>共<b>${total}</b>项商品&nbsp;&nbsp;&nbsp;&nbsp;共计<b class="f20">¥${sum}</b></p>
                <a href="javascript:;" title="去购物车结算" class="inb btn120x30c" onclick="toCart()">去购物车结算</a>
            </div>
        </c:if>
        <c:if test="${empty sessionScope.buyer}">
            尚未登录
        </c:if>
    </dd>
</dl>