<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <title>易行运动网_用户中心</title>
    <link rel="stylesheet" href="/res/css/style.css"/>
    <script src="/res/assets/js/jquery-1.11.3.min.js"></script>
    <script type="text/javascript">
        $(function () {
            var $province = $('#province');
            var $city = $('#city');
            var $town = $('#town');
            //给省份回显
            $province.val('${sessionScope.buyer.province}');

            $province.change(function () {
                //当前选中的省code
                var provinceCode = $province.val();
                //清空上次的市
                $city.empty();
                $.post('/buyer/getCityByProvince', {proviceCode: provinceCode}, function (cities) {
                    for (var i = 0; i < cities.length; i++) {
                        var op;
                        if ('${sessionScope.buyer.city}' == cities[i].code) {
                            op = '<option selected value="' + cities[i].code + '">' + cities[i].name + '</option>';
                        } else {
                            op = '<option  value="' + cities[i].code + '">' + cities[i].name + '</option>';
                        }
                        $city.append(op);
                    }
                    //难理解
                    $city.trigger('change');
                });
            });

            $province.trigger('change');


            $city.change(function () {
                var cityCode = $city.val();
                $town.empty();
                $.post('/buyer/getTownsByCity', {cityCode: cityCode}, function (towns) {
                    for (var i = 0; i < towns.length; i++) {
                        var op;
                        if ('${sessionScope.buyer.town}' == towns[i].code) {
                            op = '<option selected  value="' + towns[i].code + '">' + towns[i].name + '</option>';
                        } else {
                            op = '<option value="' + towns[i].code + '">' + towns[i].name + '</option>';
                        }

                        $town.append(op);
                    }
                });
            });
        })
    </script>
</head>
<body>
<%@include file="../header.jsp" %>
<div class="w loc">
    <div class="h-title">
        <div class="h-logo"><a href="http://localhost:8080"><img src="/res/img/pic/logo-1.png"/></a></div>
        <div class="h-search">
            <input type="text"/>
            <div class="h-se-btn"><a href="#">搜索</a></div>
        </div>
    </div>
    <%@include file="../minicart.jsp" %>
</div>

<div class="w mt ofc">
    <div class="l wl">
        <h2 class="h2 h2_l"><em title="交易管理">交易管理</em><cite>&nbsp;</cite></h2>
        <div class="box bg_gray">
            <ul class="ul left_nav">
                <li><a href="../buyer/orders.jsp" title="我的订单">我的订单</a></li>
                <li><a href="../buyer/orders.jsp" title="退换货订单">退换货订单</a></li>
                <li><a href="../buyer/orders.jsp" title="我的收藏">我的收藏</a></li>
            </ul>
        </div>
        <h2 class="h2 h2_l mt"><em title="账户管理">账户管理</em><cite>&nbsp;</cite></h2>
        <div class="box bg_gray">
            <ul class="ul left_nav">
                <li><a href="../buyer/profile.jsp" title="个人资料">个人资料</a></li>
                <li><a href="../buyer/deliver_address.jsp" title="收货地址">收货地址</a></li>
                <li><a href="../buyer/change_password.jsp" title="修改密码">修改密码</a></li>
            </ul>
        </div>
    </div>
    <div class="r wr profile">

        <div class="confirm">
            <div class="tl"></div>
            <div class="tr"></div>
            <div class="ofc">
                <h2 class="h2 h2_r2"><em title="个人资料">个人资料</em></h2>
                <form id="jvForm" action="profile.do" method="post">
                    <input type="hidden" name="returnUrl" value="${returnUrl}"/>
                    <input type="hidden" name="processUrl" value="${processUrl}"/>
                    <ul class="uls form">
                        <li id="errorName" class="errorTip" style="display:none">${error}</li>
                        <li>
                            <label for="username">用户名：</label>
                            <span class="word">${sessionScope.buyer.username}</span>
                        </li>
                        <li>
                            <label for="username">邮箱：</label>
                            <span class="word">${sessionScope.buyer.email}</span>
                        </li>
                        <li>

                            <label for="realName">真实姓名：</label>
                            <span class="bg_text"><input type="text" id="realName" name="realName" maxLength="32"
                                                         value="${sessionScope.buyer.realName}"/></span>
                            <span class="pos"><span class="tip okTip" style="display: none">&nbsp;</span></span>
                        </li>
                        <li>
                            <label for="gender">性别：</label>

                            <span class="word"><input type="radio" name="gender"/>保密<input
                                    type="radio" name="gender"
                                    <c:if test="${sessionScope.buyer.gender=='男'}">checked</c:if> />男
                                <input type="radio" name="gender"
                                       <c:if test="${sessionScope.buyer.gender=='女'}">checked</c:if>/>女</span>
                        </li>
                        <li>
                            <label for="residence">居住地：</label>
                            <span class="word">
							<select name="province" id="province">
                                <c:forEach items="${provinces}" var="province">
                                    <option value="${province.code}">${province.name}</option>
                                </c:forEach>
							</select>
							<select name="" id="city">
								<option value=""></option>
							</select>
							<select name="" id="town">
								<option value=""></option>
							</select>
						</span>
                        </li>
                        <li><label for="address">详细地址：</label>
                            <span class="bg_text"><input type="text" id="address" name="address" maxLength="32"
                                                         value="${sessionScope.buyer.addr}"/></span>
                            <span class="pos"><span class="tip errorTip" style="display: none">用户名为4-20位字母、数字或中文组成，字母区分大小写。</span></span>
                        </li>
                        <li><label for="">&nbsp;</label><input type="submit" value="保存" class="hand btn66x23"/></li>
                    </ul>
                </form>
            </div>
        </div>
    </div>
</div>
<div class="mode">
    <div class="tl"></div>
    <div class="tr"></div>
    <ul class="uls">
        <li class="first">
            <span class="guide"></span>
            <dl>
                <dt title="购物指南">购物指南</dt>
                <dd><a href="#" title="购物流程">购物流程</a></dd>
                <dd><a href="#" title="购物流程">购物流程</a></dd>
                <dd><a href="#" target="_blank" title="联系客服">联系客服</a></dd>
                <dd><a href="#" target="_blank" title="联系客服">联系客服</a></dd>
            </dl>
        </li>
        <li>
            <span class="way"></span>
            <dl>
                <dt title="支付方式">支付方式</dt>
                <dd><a href="#" title="货到付款">货到付款</a></dd>
                <dd><a href="#" title="在线支付">在线支付</a></dd>
                <dd><a href="#" title="分期付款">分期付款</a></dd>
                <dd><a href="#" title="分期付款">分期付款</a></dd>
            </dl>
        </li>
        <li>
            <span class="help"></span>
            <dl>
                <dt title="配送方式">配送方式</dt>
                <dd><a href="#" title="上门自提">上门自提</a></dd>
                <dd><a href="#" title="上门自提">上门自提</a></dd>
                <dd><a href="#" title="上门自提">上门自提</a></dd>
                <dd><a href="#" title="上门自提">上门自提</a></dd>
            </dl>
        </li>
        <li>
            <span class="service"></span>
            <dl>
                <dt title="售后服务">售后服务</dt>
                <dd><a href="#" target="_blank" title="售后策略">售后策略</a></dd>
                <dd><a href="#" target="_blank" title="售后策略">售后策略</a></dd>
                <dd><a href="#" target="_blank" title="售后策略">售后策略</a></dd>
                <dd><a href="#" target="_blank" title="售后策略">售后策略</a></dd>
            </dl>
        </li>
        <li>
            <span class="problem"></span>
            <dl>
                <dt title="特色服务">特色服务</dt>
                <dd><a href="#" target="_blank" title="夺宝岛">夺宝岛</a></dd>
                <dd><a href="#" target="_blank" title="夺宝岛">夺宝岛</a></dd>
                <dd><a href="#" target="_blank" title="夺宝岛">夺宝岛</a></dd>
                <dd><a href="#" target="_blank" title="夺宝岛">夺宝岛</a></dd>
            </dl>
        </li>
    </ul>
</div>
</body>
</html>