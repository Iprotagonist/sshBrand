<%@ page language="java" import="java.util.*" pageEncoding="utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <meta http-equiv="description" content="This is my page">


    <title>易行运动网-商品详情页</title>
    <link rel="stylesheet" href="/res/css/style.css"/>
    <link rel="stylesheet" href="/res/imagezoom/zoom.css"/>
    <link rel="stylesheet" href="/res/css/jquery-ui.css">
    <link rel="stylesheet" href="/res/layer/theme/default/layer.css">
    <script src="/res/assets/js/jquery-1.11.3.min.js"></script>
    <script type="text/javascript" src="/res/layer/layer.js"></script>
    <script type="text/javascript" src="/res/imagezoom/jquery.imagezoom.min.js"></script>
    <script src="/res/assets/js/jquery-ui.min.js"></script>
    <script type="text/javascript" src="/res/js/com.js"></script>
    <%--<script type="text/javascript" src="/js/jquery.imagezoom.js"></script>--%>
    <style type="text/css">
        .changToRed {
            border: 2px solid #e4393c;
            padding: 2px 4px;
            float: left;
            margin-right: 4px;
            text-decoration: none;
        }

        .changToWhite {
            border: 1px solid #ccc;
            padding: 2px 4px;
            float: left;
            margin-right: 4px;
            text-decoration: none;
        }

        .not-allow {
            cursor: not-allowed;
            color: #999;
            border: 1px dashed #ccc;
            padding: 2px 4px;
            float: left;
            margin-right: 4px;
            text-decoration: none;
        }

        html{overflow-y:scroll;}
        body{margin:0; font:12px "\5B8B\4F53",san-serif;background:#ffffff;}
        div,ul,li{padding:0; margin:0;}
        li{list-style-type:none;}
        img{vertical-align:top;border:0;}

        /* box */
        .box{width:610px;margin:100px auto;}
        .tb-pic a{display:table-cell;text-align:center;vertical-align:middle;}
        .tb-pic a img{vertical-align:middle;}
        .tb-pic a{*display:block;*font-family:Arial;*line-height:1;}
        .tb-thumb{margin:10px 0 0;overflow:hidden;}
        .tb-thumb li{background:none repeat scroll 0 0 transparent;float:left;height:42px;margin:0 6px 0 0;overflow:hidden;padding:1px;}
        .tb-s310, .tb-s310 a{height:310px;width:310px;}
        .tb-s310, .tb-s310 img{max-height:310px;max-width:310px;}
        .tb-s310 a{*font-size:271px;}
        .tb-s40 a{*font-size:35px;}
        .tb-s40, .tb-s40 a{height:40px;width:40px;}
        .tb-booth{border:1px solid #CDCDCD;position:relative;z-index:1;}
        .tb-thumb .tb-selected{background:none repeat scroll 0 0 #C30008;height:40px;padding:2px;}
        .tb-thumb .tb-selected div{background-color:#FFFFFF;border:medium none;}
        .tb-thumb li div{border:1px solid #CDCDCD;}
        .zoomDiv{z-index:999;position:absolute;top:0px;left:0px;width:200px;height:200px;background:#ffffff;border:1px solid #CCCCCC;display:none;text-align:center;overflow:hidden;}
        .zoomMask{position:absolute;background:url("/upload/mask.png") repeat scroll 0 0 transparent;cursor:move;z-index:1;}

    </style>
</head>
<script type="text/javascript">
    //全局变量
    var color_massage;
    var sku_id;

    function isEmpty(s) {
        return (s == undefined || s == null || s == "");
    }

    //加入购物车
    function addCart() {
        var buyer = '${sessionScope.buyer}';
        var f = isEmpty(buyer);
        if (f) {
            //没有登录，弹出一个小窗口登录
            layer.open({
                type: 2,
                title: '账号登录',
                skin: 'layui-layer-rim', //加上边框
                area: ['420px', '240px'], //宽高
                content: '/buyer/miniLogin?skuId=' + sku_id + "&amount=" + $("#spinner").val(),
                anim: 5
            });
        }else{
            var url = '/buyer/addItem?skuId=' + sku_id + "&amount=" + $("#spinner").val();
            window.location.href = url;
        }
    }


    //立即购买
    function buy(cart,size) {
        console.log(size);
        window.location.href = 'cart/';
    }

    $(document).ready(function () {
        //放大镜
        $(".jqzoom").imagezoom();
        $("#thumblist li a").click(function () {
            //增加点击的li的class:tb-selected，去掉其他的tb-selecte
            $(this).parents("li").addClass("tb-selected").siblings().removeClass("tb-selected");
            //赋值属性
            $(".jqzoom").attr('src', $(this).find("img").attr("mid"));
            $(".jqzoom").attr('rel', $(this).find("img").attr("big"));
        });

        //给放大镜的第一张小图加默认选中
        $('#thumblist li:eq(0)').addClass('tb-selected');


        //刚进产品详情页触发一次点击事件，目的是选中第一个sku
        $("#colors a:first").trigger('click');

        //spinner
        $("#spinner").spinner({
            step: 1,
            min: 1
        });
    });

    //点击颜色切换尺码
    function colorToRed(target, colorId) {
        color_massage = colorId;
        //把所有颜色变白
        $("#colors a").each(function () {
            $(this).attr("class", "changToWhite");
        })
        //当前被点击的变红
        $(target).attr("class", "changToRed");

        //复位购买数量
        $("#spinner").val(1);

        var flag = 0;
        <c:forEach items="${skus}" var="sku">
        if ('${sku.color}' == color_massage) {
            if (flag == 0) {
                $("#" + '${sku.size}').attr("class", "changToRed");
                $('#skuPrice').html("￥" + '${sku.skuPrice}');
                $('#marketPrice').html("￥" + '${sku.marketPrice}');
                $('#deliveFee').html('${sku.deliveFee}' + '元');
                $('#stockInventory').html('${sku.stockInventory}');

                sku_id =${sku.id};
                flag = 1;//让相同颜色非第一款尺寸不选中
            } else {
                $("#" + '${sku.size}').attr("class", "changToWhite");
            }
        }
        </c:forEach>
    }

    function sizeToRed(target, size) {
        var cc = $(target).attr("class");

        //若点击的是没有的尺码,则返回
        if (cc == 'not-allow') {
            // var idsize = $(target).attr("id");
            // console.log(sizes.indexOf(idsize));
            // if(sizes.indexOf(idsize) == (-1)){
            //     console.log(没查到);
            // }else {
            //     console.log(查到了);
            // }
            return;
        }

        //复位尺码
        $("#sizes a").each(function () {
            var c = $(this).attr("class");
            if (c != 'not-allow') {
                $(this).attr("class", "changToWhite");
            }
        })

        //当前点击的变红
        $(target).attr("class", "changToRed");

        //复位购买数量
        $("#spinner").val(1);

        <c:forEach items="${skus}" var="sku">
        if ('${sku.color}' == color_massage && size == '${sku.size}') {
            $('#skuPrice').html("￥" + '${sku.skuPrice}');
            $('#marketPrice').html("￥" + '${sku.marketPrice}');
            $('#deliveFee').html('${sku.deliveFee}' + '元');
            $('#stockInventory').html('${sku.stockInventory}');
            sku_id =${sku.id};
        }
        </c:forEach>
    }

        $(document).ready(function(){
            $(".jqzoom").imagezoom();
            $("#thumblist li a").click(function(){
                //增加点击的li的class:tb-selected，去掉其他的tb-selecte
                $(this).parents("li").addClass("tb-selected").siblings().removeClass("tb-selected");
                //赋值属性
                $(".jqzoom").attr('src',$(this).find("img").attr("mid"));
                $(".jqzoom").attr('rel',$(this).find("img").attr("big"));
            });
        });
</script>
</head>
<body>
<%@include file="../header.jsp"%>
<div class="w loc">
    <div class="h-title">
        <div class="h-logo"><a href="http://localhost:8080"><img src="/res/img/pic/logo-1.png"/></a></div>
        <div class="h-search">
            <input type="text"/>
            <div class="h-se-btn"><a href="#">搜索</a></div>
        </div>
    </div>
    <%@include file="../minicart.jsp"%>
</div>

<div class="w ofc mt">

    <div class="1">
        <div class="showPro">
        <div class="tb-booth tb-pic tb-s310">
            <a href="/upload/${firstImage.name}.${firstImage.type}">
                <img src="/upload/${firstImage.name}_mid.${firstImage.type}" alt="美女" rel="/upload/${firstImage.name}.${firstImage.type}"
                                                                    class="jqzoom" /></a>
        </div>
        <ul class="tb-thumb" id="thumblist">

            <c:forEach items="${images}" var="img">
                <li>
                    <div class="tb-pic tb-s40">
                        <a href="#"><img src="/upload/${img.name}_small.${img.type}"
                                         mid="/upload/${img.name}_mid.${img.type}"
                                         big="/upload/${img.name}.${img.type}">
                        </a>
                    </div>
                </li>
            </c:forEach>
        </ul>
        </div>
    </div>


    <div class="r" style="width: 600px">
        <ul class="uls form">
            <li><h2>${product.name}</h2></li>
            <li><label>巴 巴 价：</label><span class="word"><b class="f14 red mr" id="skuPrice">￥${product.price}</b>(市场价:<del
                    id="marketPrice">￥${product.price}</del>)</span>
            </li>
            <li><label>商品评价：</label><span class="word"><span class="val_no val3d4" title="4分">4分</span><var
                    class="blue">(已有888人评价)</var></span></li>
            <li><label>运　　费：</label><span class="word" id="deliveFee">10元</span></li>
            <li><label>库　　存：</label><span class="word" id="stockInventory">100</span><span class="word">件</span></li>
            <li><label>选择颜色：</label>
                <div id="colors" class="pre spec">
                    <c:forEach items="${colors}" var="color">
                        <a onclick="colorToRed(this,'${color.massage}')" href="javascript:void(0)" title="${color.massage}"
                           class="not-allow">
                            <%--颜色分类图片--%>
                            <img src="/res/img/pic/ppp00.jpg" width="25" height="25" data-img="1" alt="${color.massage}">
                            <i>${color.massage}</i></a>
                    </c:forEach>
                </div>
            </li>
            <li id="sizes"><label>尺　　码：</label>
                <%--<c:forEach items="${allSize}" var="allsize">--%>
                <%--<a href="javascript:void(0)" class="not-allow"--%>
                <%--id="${allsize.massage}" onclick="sizeToRed(this,'${allsize.massage}')" >${allsize.massage}</a>--%>
                <%--</c:forEach>--%>
                <a href="javascript:void(0)" class="not-allow"  id="M" onclick="sizeToRed(this,'M')" >M</a>
                <a href="javascript:void(0)" class="not-allow"  id="L" onclick="sizeToRed(this,'L')">L</a>
                <a href="javascript:void(0)" class="not-allow"  id="XL" onclick="sizeToRed(this,'XL')">XL</a>
                <a href="javascript:void(0)" class="not-allow"  id="XXL" onclick="sizeToRed(this,'XXL')">XXL</a>
            </li>
            <li><label>我 要 买：</label>
                <input id="spinner" name="spinner" value="1" size="8">
            <li class="submit"><input type="button" value="" class="hand btn138x40" onclick="buy(this,$('#spinner').val());"/>
            <input type="button" value="" class="hand btn138x40b" onclick="addCart()"/></li>
        </ul>
    </div>
</div>
<div class="w ofc mt">
    <div class="l wl">
        <h2 class="h2 h2_l mt"><em title="销量排行榜">销量排行榜</em><cite></cite></h2>
        <div class="box bg_white">
            <ul class="uls x_50x50">
                <li>
                    <var class="sfont">1</var>
                    <a href="#" title="富一代" target="_blank" class="pic"><img src="/res/img/pic/ppp.jpg"
                                                                             alt="依琦莲2014瑜伽服套装新"/></a>
                    <dl>
                        <!-- dt 8个文字+... -->
                        <dt><a href="#" title="依琦莲2014瑜伽服套装新" target="_blank">依琦莲2014瑜伽服套装新</a></dt>
                        <dd class="orange">￥120 ~ ￥150</dd>
                    </dl>
                </li>
                <li>
                    <var class="sfont">2</var>
                    <a href="#" title="富一代" target="_blank" class="pic"><img src="/res/img/pic/ppp.jpg"
                                                                             alt="依琦莲2014瑜伽服套装新"/></a>
                    <dl>
                        <!-- dt 8个文字+... -->
                        <dt><a href="#" title="依琦莲2014瑜伽服套装新" target="_blank">依琦莲2014瑜伽服套装新</a></dt>
                        <dd class="orange">￥120 ~ ￥150</dd>
                    </dl>
                </li>
                <li>
                    <var class="sfont">3</var>
                    <a href="#" title="富一代" target="_blank" class="pic"><img src="/res/img/pic/ppp.jpg"
                                                                             alt="依琦莲2014瑜伽服套装新"/></a>
                    <dl>
                        <!-- dt 8个文字+... -->
                        <dt><a href="#" title="依琦莲2014瑜伽服套装新" target="_blank">依琦莲2014瑜伽服套装新</a></dt>
                        <dd class="orange">￥120 ~ ￥150</dd>
                    </dl>
                </li>
                <li>
                    <a href="#" title="富一代" target="_blank" class="pic"><img src="/res/img/pic/ppp.jpg"
                                                                             alt="依琦莲2014瑜伽服套装新"/></a>
                    <dl>
                        <!-- dt 8个文字+... -->
                        <dt><a href="#" title="依琦莲2014瑜伽服套装新" target="_blank">依琦莲2014瑜伽服套装新</a></dt>
                        <dd class="orange">￥120 ~ ￥150</dd>
                    </dl>
                </li>
                <li>
                    <a href="#" title="富一代" target="_blank" class="pic"><img src="/res/img/pic/ppp.jpg"
                                                                             alt="依琦莲2014瑜伽服套装新"/></a>
                    <dl>
                        <!-- dt 8个文字+... -->
                        <dt><a href="#" title="依琦莲2014瑜伽服套装新" target="_blank">依琦莲2014瑜伽服套装新</a></dt>
                        <dd class="orange">￥120 ~ ￥150</dd>
                    </dl>
                </li>
                <li>
                    <a href="#" title="富一代" target="_blank" class="pic"><img src="/res/img/pic/ppp.jpg"
                                                                             alt="依琦莲2014瑜伽服套装新"/></a>
                    <dl>
                        <!-- dt 8个文字+... -->
                        <dt><a href="#" title="依琦莲2014瑜伽服套装新" target="_blank">依琦莲2014瑜伽服套装新</a></dt>
                        <dd class="orange">￥120 ~ ￥150</dd>
                    </dl>
                </li>
                <li>
                    <a href="#" title="富一代" target="_blank" class="pic"><img src="/res/img/pic/ppp.jpg"
                                                                             alt="依琦莲2014瑜伽服套装新"/></a>
                    <dl>
                        <!-- dt 8个文字+... -->
                        <dt><a href="#" title="依琦莲2014瑜伽服套装新" target="_blank">依琦莲2014瑜伽服套装新</a></dt>
                        <dd class="orange">￥120 ~ ￥150</dd>
                    </dl>
                </li>
            </ul>
        </div>
        <h2 class="h2 h2_l mt"><em title="我的浏览记录">我的浏览记录</em><cite></cite></h2>
        <div class="box bg_white">
            <ul class="uls x_50x50">
                <li>
                    <a href="#" title="富一代" target="_blank" class="pic"><img src="/res/img/pic/ppp.jpg"
                                                                             alt="依琦莲2014瑜伽服套装新"/></a>
                    <dl>
                        <!-- dt 8个文字+... -->
                        <dt><a href="#" title="依琦莲2014瑜伽服套装新" target="_blank">依琦莲2014瑜伽服套装新</a></dt>
                        <dd class="orange">￥120 ~ ￥150</dd>
                    </dl>
                </li>
                <li>
                    <a href="#" title="富一代" target="_blank" class="pic"><img src="/res/img/pic/ppp.jpg"
                                                                             alt="依琦莲2014瑜伽服套装新"/></a>
                    <dl>
                        <!-- dt 8个文字+... -->
                        <dt><a href="#" title="依琦莲2014瑜伽服套装新" target="_blank">依琦莲2014瑜伽服套装新</a></dt>
                        <dd class="orange">￥120 ~ ￥150</dd>
                    </dl>
                </li>
                <li>
                    <a href="#" title="富一代" target="_blank" class="pic"><img src="/res/img/pic/ppp.jpg"
                                                                             alt="依琦莲2014瑜伽服套装新"/></a>
                    <dl>
                        <!-- dt 8个文字+... -->
                        <dt><a href="#" title="依琦莲2014瑜伽服套装新" target="_blank">依琦莲2014瑜伽服套装新</a></dt>
                        <dd class="orange">￥120 ~ ￥150</dd>
                    </dl>
                </li>
                <li>
                    <a href="#" title="富一代" target="_blank" class="pic"><img src="/res/img/pic/ppp.jpg"
                                                                             alt="依琦莲2014瑜伽服套装新"/></a>
                    <dl>
                        <!-- dt 8个文字+... -->
                        <dt><a href="#" title="依琦莲2014瑜伽服套装新" target="_blank">依琦莲2014瑜伽服套装新</a></dt>
                        <dd class="orange">￥120 ~ ￥150</dd>
                    </dl>
                </li>
                <li>
                    <a href="#" title="富一代" target="_blank" class="pic"><img src="/res/img/pic/ppp.jpg"
                                                                             alt="依琦莲2014瑜伽服套装新"/></a>
                    <dl>
                        <!-- dt 8个文字+... -->
                        <dt><a href="#" title="依琦莲2014瑜伽服套装新" target="_blank">依琦莲2014瑜伽服套装新</a></dt>
                        <dd class="orange">￥120 ~ ￥150</dd>
                    </dl>
                </li>
                <li>
                    <a href="#" title="富一代" target="_blank" class="pic"><img src="/res/img/pic/ppp.jpg"
                                                                             alt="依琦莲2014瑜伽服套装新"/></a>
                    <dl>
                        <!-- dt 8个文字+... -->
                        <dt><a href="#" title="依琦莲2014瑜伽服套装新" target="_blank">依琦莲2014瑜伽服套装新</a></dt>
                        <dd class="orange">￥120 ~ ￥150</dd>
                    </dl>
                </li>
            </ul>
        </div>

        <h2 class="h2 h2_l mt"><em title="商家精选">商家精选</em><cite></cite></h2>
        <img src="/res/img/pic/ad200x75.jpg" alt=""/>
    </div>
    <div class="r wr">
        <h2 class="h2 h2_ch mt"><em>
            <a href="javascript:void(0);" title="商品介绍" rel="#detailTab1" class="here">商品介绍</a>
            <a href="javascript:void(0);" title="规格参数" rel="#detailTab2">规格参数</a>
            <a href="javascript:void(0);" title="包装清单" rel="#detailTab3">包装清单</a></em><cite></cite></h2>
        <div class="box bg_white ofc">
            <div id="detailTab1" class="detail">
                ${product.my_desc}
            </div>

            <div id="detailTab2" style="display:none">
                <strong>服务承诺：</strong><br>
                京东向您保证所售商品均为正品行货，京东自营商品开具机打发票或电子发票。凭质保证书及京东发票，可享受全国联保服务（奢侈品、钟表除外；奢侈品、钟表由京东联系保修，享受法定三包售后服务），与您亲临商场选购的商品享受相同的质量保证。京东还为您提供具有竞争力的商品价格和<a
                    target="_blank" href="http://www.jd.com/help/kdexpress.aspx">运费政策</a>，请您放心购买！
                <br><br>
                注：因厂家会在没有任何提前通知的情况下更改产品包装、产地或者一些附件，本司不能确保客户收到的货物与商城图片、产地、附件说明完全一致。只能确保为原厂正货！并且保证与当时市场上同样主流新品一致。若本商城没有及时更新，请大家谅解！
                <br/>
                <strong>权利声明：</strong><br>京东上的所有商品信息、客户评价、商品咨询、网友讨论等内容，是京东重要的经营资源，未经许可，禁止非法转载使用。
                <p><b>注：</b>本站商品信息均来自于合作方，其真实性、准确性和合法性由信息拥有者（合作方）负责。本站不提供任何保证，并不承担任何法律责任。</p>

            </div>

            <div id="detailTab3" class="detail" style="display:none">

	<pre class="f14">
        ${product.packageList}
    </pre>

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