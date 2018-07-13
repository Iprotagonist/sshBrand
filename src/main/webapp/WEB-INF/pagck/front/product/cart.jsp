<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <title>我的购物车</title>
    <link rel="stylesheet" href="/res/css/style.css"/>
    <link rel="stylesheet" href="/res/css/jquery-ui.css">
    <script src="/res/assets/js/jquery-1.11.3.min.js"></script>
    <script src="/res/assets/js/jquery-ui.min.js"></script>
    <script src="/res/js/com.js"></script>
    <script type="text/javascript">
        //结算
        function trueBuy() {
            window.location.href = "/buyer/productOrder";
        }

        function tolist() {
            window.location.href = "/front/product/toList";
        }

        $(function () {
            <c:forEach items="${items}" var="item">
            $("#spinner${item.id}").spinner({
                step: 1
            });

            $("#spinner${item.id}").val(${item.amount});


            $("#spinner${item.id}").on("spinchange", function (event, ui) {
                var json = {
                    id: '${item.id}',
                    amount: $("#spinner${item.id}").val()
                }
                $.post('/item/updateAmount', json, function (data) {
                    $('#productPrice').html(data.sum);
                    $('#totalPrice').html(data.sum+10);
                })
            });


            </c:forEach>


        })
    </script>
</head>
<body>
<%@include file="../header.jsp"%>
<ul class="ul step st3_1">
    <li title="1.我的购物车" class="here">1.我的购物车</li>
    <li title="2.填写核对订单信息">2.填写核对订单信息</li>
    <li title="3.成功提交订单">3.成功提交订单</li>
</ul>
<div class="w ofc case">
    <div class="confirm">
        <div class="tl"></div>
        <div class="tr"></div>
        <div class="ofc pb40">

            <div class="page">
                <b class="l f14 blue pt48">
                    我挑选的商品：
                </b>
            </div>
            <table cellspacing="0" class="tab tab4" summary="">
                <thead>
                <tr>
                    <th class="wp">商品</th>
                    <th>单价（元）</th>
                    <th>数量</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${items}" var="item">
                    <tr>
                        <td class="nwp pic">
                            <ul class="uls">
                                <li>
                                    <a class="pic"
                                       title=" 喜悦2014秋冬新款瑜伽服三件套装 韩版女士瑜珈舞蹈服 愈加服正品送胸垫 酒红+黑+黑 M 开启年终大促 全场优惠到底 买贵就赔 支持货到付款"
                                       href="javascript:void(0)"><img
                                            alt=" 喜悦2014秋冬新款瑜伽服三件套装 韩版女士瑜珈舞蹈服 愈加服正品送胸垫 酒红+黑+黑 M 开启年终大促 全场优惠到底 买贵就赔 支持货到付款"
                                            src="/upload/${item.img}"></a>
                                    <dl>
                                        <dt>
                                            <a title=" 喜悦2014秋冬新款瑜伽服三件套装 韩版女士瑜珈舞蹈服 愈加服正品送胸垫 酒红+黑+黑 M 开启年终大促 全场优惠到底 买贵就赔 支持货到付款"
                                               href="javascript:void(0)"> ${item.productName}--${item.colorName}--${item.size}</a>
                                        </dt>
                                        <dd><span class="red">【赠品】</span>
                                            <p class="box_d bg_gray2 gray"><a title="瑜伽丝带" href="#">瑜伽丝带</a><br></p>
                                        </dd>
                                    </dl>
                                </li>
                            </ul>
                        </td>
                        <td>￥${item.skuprice}</td>
                        <td><input id="spinner${item.id}" name="spinner" value="1" size="8"></td>
                        <td class="blue"><a onclick="delProduct(492)" title="删除" href="javascript:void(0);">删除</a></td>
                    </tr>
                </c:forEach>


                </tbody>
            </table>
            <div class="page">
				<span class="l">
					<input type="button" onclick="tolist()" class="hand btn100x26c"
                           title="继续购物" value="继续购物">
					<input type="button" onclick="clearCart()" class="hand btn100x26c" title="清空购物车" value="清空购物车">
				</span>
                <span class="r box_gray">
					<dl class="total">
						<dt>购物车金额小计：<cite>(共<var id="productAmount">${total}</var>个商品)</cite></dt>
						<dd><em class="l">商品金额：</em>￥<var id="productPrice">${sum}</var>元</dd>
						<dd><em class="l">运费：</em>￥<var id="fee">10.0</var>元</dd>
						<dd class="orange"><em class="l">应付总额：</em>￥<var id="totalPrice">${sum+10}</var>元</dd>
						<dd class="alg_c"><input type="button" onclick="trueBuy();" class="hand btn136x36a" value="结算"
                                                 id="settleAccountId"></dd>
					</dl>
				</span>
            </div>
        </div>
    </div>
</div>
<div class="w ofc case" style="display: none;">
    <div class="confirm">
        <div class="tl"></div>
        <div class="tr"></div>
        <div class="ofc pb40" style="text-align: center;height: 200px;margin-top: 80px">
            <a href="http://localhost:8080" style="color: red;font-size: 30px;">去首页</a>挑选喜欢的商品
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