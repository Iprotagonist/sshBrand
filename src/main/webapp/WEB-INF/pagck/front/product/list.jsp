<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<html>
<head>
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <meta http-equiv="description" content="This is my page">

    <title>易行运动网-电子商城</title>
    <link rel="stylesheet" href="/res/css/style.css"/>
    <link rel="stylesheet" href="/res/kkpager/kkpager_orange.css"/>
    <script src="/res/assets/js/jquery-1.11.3.min.js"></script>
    <script src="/res/kkpager/kkpager.js"></script>
    <script src="/res/js/com.js"></script>
    <script type="text/javascript">

        function AjaxData(currpage) {
            //从表单中取查询条件
            var brandId = $('#brandId').val();
            var typeId = $('#typeId').val();
            var data = {
                pageNo: currpage,
                brandId: brandId,
                typeId: typeId
            }
            $.post('/front/product/getProducts', data, function (data) {
                //清空上一次的数据
                $('#products').empty();

                for (var i = 0; i < data.rows.length; i++) {
                    var product = data.rows[i];
                    var li = $('<li></li>');

                    var a = $('<a></a>');
                    a.attr('href', 'productDetail.jsp');
                    a.attr('title', product.name);
                    a.attr('target', '_blank');
                    a.attr('class', 'pic');

                    var aimg = $('<img alt="瑜伽服"/>');
                    aimg.attr('src', '/upload/' + product.imgUrl);
                    a.append(aimg);

                    var dl = $('<dl></dl>');

                    var dt = $('<dt></dt>');
                    var dta = $('<a></a>');
                    dta.attr('href', '/front/product/toProductDetail/' + product.id);
                    dta.attr('title', product.name);
                    dta.attr('target', '_blank');
                    dta.text(product.name);
                    dt.append(dta);

                    var dd0 = $('<dd class="h40"></dd>');
                    dd0.text(product.name);
                    var dd1 = $('<dd class="orange"></dd>');
                    dd1.text('￥' + product.price);
                    var dd2 = $('<dd>北京有货</dd>');
                    var dd3 = $('<dd><a href="#" title="加入购物车" class="inb btn70x21 mr">加入购物车</a></dd>');
                    dl.append(dt);
                    dl.append(dd0);
                    dl.append(dd1);
                    dl.append(dd2);
                    dl.append(dd3);

                    var img = $('<img src="/res/img/pic/hot.gif" alt="热门" class="type"/>');
                    li.append(a);
                    li.append(dl);
                    li.append(img);

                    $('#products').append(li);
                }


                kkpager.generPageHtml({
                    //当前页码
                    pno: data.pageNo,
                    //总页码
                    total: data.pages,
                    //总数据条数
                    totalRecords: data.total,

                    mode: 'click',
                    click: function (n) {
                        AjaxData(n);
                        //手动选中按钮
                        this.selectPage(n);
                        return false;
                    }
                }, true);

            });
        }


        //kkpager分页插件
        //init
        $(function () {
            //不带条件分页
            AjaxData(1);


            //查询条件
            //1.给品牌加单击事件
            $('#brand p a:gt(0)').click(function () {
                var p = $('.sel');
                var $options = $('#options');
                //a.获取当前点击的品牌的Id和name
                var name = $(this).attr('title');
                var brandId = $(this).attr('id');
                //给查询表单设置要查询的类型ID
                $('#brandId').val(brandId);

                //c.查询条件要显示
                $('#options').show();

                var a = $('<a></a>');
                a.attr('href', 'javascript:;');
                var em = $('<em>品牌: </em>');
                a.append(em);
                a.append(name);
                var cite = $('<cite title="关闭此筛选条件">X</cite>');
                a.append(cite);

                p.append(a);
                a.click(function () {
                    $(this).remove();
                    $('#brand').show();
                    $('#brandId').val('');
                    //若所有查询条件都去掉了，options隐藏
                    if (p.children().length == 0) {
                        $options.hide();
                    } else {
                        console.log(options);
                    }
                    AjaxData(1);
                });

                //b.品牌要隐藏
                $('#brand').hide();

                AjaxData(1);
            });

            //2.给关键字加单击事件

            $('#keywords p a:gt(0)').click(function () {
                var p = $('.sel');
                var $options = $('#options');
                //a.获取当前点击的品牌的Id和name
                var name = $(this).attr('title');
                var keywordsId = $(this).attr('id');
                //给查询表单设置要查询的类型ID
                $('#keywordsId').val(keywordsId);

                //c.查询条件要显示
                $('#options').show();

                var a = $('<a></a>');
                a.attr('href', 'javascript:;');
                var em = $('<em>关键字: </em>');
                a.append(em);
                a.append(name);
                var cite = $('<cite title="关闭此筛选条件">X</cite>');
                a.append(cite);

                p.append(a);
                a.click(function () {
                    $(this).remove();
                    $('#keywords').show();
                    $('#keywordsId').val('');
                    //若所有查询条件都去掉了，options隐藏
                    if (p.children().length == 0) {
                        $options.hide();
                    } else {
                        console.log(options);
                    }
                    AjaxData(1);
                });

                //b.关键字要隐藏
                $('#keywords').hide();

                AjaxData(1);
            });


            //3.给价格加单击事件
            $('#price p a:gt(0)').click(function () {
                var p = $('.sel');
                var $options = $('#options');
                //a.获取当前点击的品牌的Id和name
                var name = $(this).attr('title');
                var priceId = $(this).attr('id');
                //给查询表单设置要查询的类型ID
                $('#priceId').val(priceId);

                //c.查询条件要显示
                $('#options').show();

                var a = $('<a></a>');
                a.attr('href', 'javascript:;');
                var em = $('<em>价格: </em>');
                a.append(em);
                a.append(name);
                var cite = $('<cite title="关闭此筛选条件">X</cite>');
                a.append(cite);

                p.append(a);
                a.click(function () {
                    $(this).remove();
                    $('#price').show();
                    $('#priceId').val('');
                    //若所有查询条件都去掉了，options隐藏
                    if (p.children().length == 0) {
                        $options.hide();
                    } else {
                        console.log(options);
                    }
                    AjaxData(1);
                });

                //b.价格要隐藏
                $('#price').hide();
                AjaxData(1);
            });


            //4.给材质加单击事件
            $('#feature p a:gt(0)').click(function () {
                var p = $('.sel');
                var $options = $('#options');
                //a.获取当前点击的材质的Id和name
                var name = $(this).attr('title');
                var featureId = $(this).attr('id');
                //给查询表单设置要查询的类型ID
                $('#featureId').val(featureId);

                //c.查询条件要显示
                $('#options').show();

                var a = $('<a></a>');
                a.attr('href', 'javascript:;');
                var em = $('<em>材质: </em>');
                a.append(em);
                a.append(name);
                var cite = $('<cite title="关闭此筛选条件">X</cite>');
                a.append(cite);

                p.append(a);
                a.click(function () {
                    $(this).remove();
                    $('#feature').show();
                    $('#featureId').val('');
                    //若所有查询条件都去掉了，options隐藏
                    if (p.children().length == 0) {
                        $options.hide();
                    }
                    AjaxData(1);
                });

                //b.材质要隐藏
                $('#feature').hide();

                AjaxData(1);
            });

            //清除全部已选的选项
            $('#filterRest').click(function () {
                var $options = $('#options');
                // var $feature = $('#feature');
                // $feature.remove();
                $options.hide();

                $('#brand').show();
                $('#keywords').show();
                $('#price').show();
                $('#feature').show();
                $('#featureId').val('');
                $('#priceId').val('');
                $('#keywordsId').val('');
                $('#brandId').val('');
                // //若所有查询条件都去掉了，options隐藏
                // if (p.children().length == 0) {
                //     $options.hide();
                // } else {
                //     console.log(options);
                // }
                // AjaxData(1);
            })

        });


        //登陆
        function login() {
            //window.location.href值是 :http://localhost:8080/front/product/toList
            window.location.href = "/buyer/toLogin?returnUrl=" + window.location.href;
        }

        function logout() {
            window.location.href = "/buyer/logout";
        }

        function delItem(id) {
            window.location.href = "/item/del/" + id;
        }

        function toCart() {
            window.location.href = "/buyer/toCart";
        }




        // kkpager
        //init
        $(function () {
            var totalPage = ${data.totalPages};
            var totalRecords = ${data.totalElements};
            var pageNo = ${page};//当前第几页
            if (!pageNo) {
                pageNo = 1;
            }
            //生成分页
            //有些参数是可选的，比如lang，若不传有默认值
            kkpager.generPageHtml({
                pno: pageNo,
                //总页码
                total: totalPage,
                //总数据条数
                totalRecords: totalRecords,
                //链接前部
                hrefFormer: '/mainindex',
                //链接尾部
                // hrefLatter: '.html',
                getLink: function (n) {
                    return this.hrefFormer + this.hrefLatter + "?page=" + n;
                }
                /*
                ,lang				: {
                    firstPageText			: '首页',
                    firstPageTipText		: '首页',
                    lastPageText			: '尾页',
                    lastPageTipText			: '尾页',
                    prePageText				: '上一页',
                    prePageTipText			: '上一页',
                    nextPageText			: '下一页',
                    nextPageTipText			: '下一页',
                    totalPageBeforeText		: '共',
                    totalPageAfterText		: '页',
                    currPageBeforeText		: '当前第',
                    currPageAfterText		: '页',
                    totalInfoSplitStr		: '/',
                    totalRecordsBeforeText	: '共',
                    totalRecordsAfterText	: '条数据',
                    gopageBeforeText		: '&nbsp;转到',
                    gopageButtonOkText		: '确定',
                    gopageAfterText			: '页',
                    buttonTipBeforeText		: '第',
                    buttonTipAfterText		: '页'
                }*/

                //,
                //mode : 'click',//默认值是link，可选link或者click
                //click : function(n){
                //	this.selectPage(n);
                //  return false;
                //}
            });
        });
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

<div class="w ofc">
    <div class="l wl">
        <h2 class="h2 h2_l"><em title="销量排行榜">销量排行榜</em><cite></cite></h2>
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
        <h2 class="h2 h2_r rel"><samp></samp><em title="热卖推荐">&nbsp;&nbsp;&nbsp;热卖推荐</em></h2>
        <div class="box bg_white">
            <ul class="uls i_150x150 x4_150x150">
                <li>
                    <a href="productDetail.jsp" title="富一代" target="_blank" class="pic"><img
                            src="	/res/img/pic/ppp.jpg" alt="依琦莲2014瑜伽服套装新"/></a>
                    <dl>
                        <dt><a href="productDetail.jsp" title="依琦莲2014瑜伽服套装新" target="_blank">依琦莲2014瑜伽服套装新</a></dt>
                        <dd class="h40">依琦莲2014瑜伽服套装新！</dd>
                        <dd class="orange">￥120 ~ ￥150</dd>
                        <dd><a href="productDetail.jsp" title="立即抢购" class="inb btn70x21 mr">立即抢购</a></dd>
                    </dl>
                </li>
                <li>
                    <a href="productDetail.jsp" title="富一代" target="_blank" class="pic"><img
                            src="	/res/img/pic/ppp.jpg" alt="依琦莲2014瑜伽服套装新"/></a>
                    <dl>
                        <dt><a href="productDetail.jsp" title="依琦莲2014瑜伽服套装新" target="_blank">依琦莲2014瑜伽服套装新</a></dt>
                        <dd class="h40">依琦莲2014瑜伽服套装新！</dd>
                        <dd class="orange">￥120 ~ ￥150</dd>
                        <dd><a href="productDetail.jsp" title="立即抢购" class="inb btn70x21 mr">立即抢购</a></dd>
                    </dl>
                </li>
                <li>
                    <a href="productDetail.jsp" title="富一代" target="_blank" class="pic"><img
                            src="	/res/img/pic/ppp.jpg" alt="依琦莲2014瑜伽服套装新"/></a>
                    <dl>
                        <dt><a href="productDetail.jsp" title="依琦莲2014瑜伽服套装新" target="_blank">依琦莲2014瑜伽服套装新</a></dt>
                        <dd class="h40">依琦莲2014瑜伽服套装新！</dd>
                        <dd class="orange">￥120 ~ ￥150</dd>
                        <dd><a href="productDetail.jsp" title="立即抢购" class="inb btn70x21 mr">立即抢购</a></dd>
                    </dl>
                </li>
                <li>
                    <a href="productDetail.jsp" title="富一代" target="_blank" class="pic"><img
                            src="	/res/img/pic/ppp.jpg" alt="依琦莲2014瑜伽服套装新"/></a>
                    <dl>
                        <dt><a href="productDetail.jsp" title="依琦莲2014瑜伽服套装新" target="_blank">依琦莲2014瑜伽服套装新</a></dt>
                        <dd class="h40">依琦莲2014瑜伽服套装新！</dd>
                        <dd class="orange">￥120 ~ ￥150</dd>
                        <dd><a href="productDetail.jsp" title="立即抢购" class="inb btn70x21 mr">立即抢购</a></dd>
                    </dl>
                </li>
            </ul>
        </div>

        <h2 class="h2 h2_filter mt"><em title="商品筛选">商品筛选</em><cite><a href="javascript:void(0);" id="filterRest"
                                                                       title="重置筛选条件">重置筛选条件</a></cite></h2>
        <ul class="uls filter">
            <!--查询表单-->
            <form id="myform" method="post">
                <input name="brandId" id="brandId" type="hidden">
                <input name="priceId" id="priceId" type="hidden">
                <input name="keywordsId" id="keywordsId" type="hidden">
                <input name="featureId" id="featureId" type="hidden">
            </form>

            <li style="display: none" id="options"><label>已选条件：</label>
                <p class="sel">

                </p>
            </li>
            <li id="brand"><b>品牌：</b>
                <p>
                    <a href="javascript:void(0);" title="不限" class="here">不限</a>
                    <c:forEach items="${brandList}" var="brand">
                        <a href="javascript:void(0);" title="${brand.name}" id="${brand.brand_id}">${brand.name}</a>
                    </c:forEach>
                </p></li>
            <li id="price"><b>价格：</b>
                <p>
                    <a href="javascript:void(0);" title="不限" class="here">不限</a>
                    <a href="javascript:void(0);" title="1-99">0-79</a>
                    <a href="javascript:void(0);" title="100-199">80-199</a>
                    <a href="javascript:void(0);" title="200-499">200-299</a>
                    <a href="javascript:void(0);" title="200-499">300-499</a>
                    <a href="javascript:void(0);" title="200-499">500-599</a>
                    <a href="javascript:void(0);" title="200-499">600以上</a>
                </p></li>
            <li id="keywords"><b>关键字：</b>
                <p>
                    <a href="javascript:void(0);" title="不限" class="here">不限</a>
                    <c:forEach items="${data.content}" var="productList">
                        <a href="javascript:void(0);" title="${productList.keywords}"
                           id="${productList.product_id}">${productList.keywords}</a>
                    </c:forEach>
                </p></li>
            <li id="feature"><b>材质：</b>
                <p>
                    <span><a href="javascript:void(0);" title="不限" class="here">不限</a></span>
                    <c:forEach items="${featureE}" var="featureE">
                        <span><a href="javascript:void(0);" title="${featureE.massage}"
                                 id="${featureE.code}">${featureE.massage}</a></span>
                    </c:forEach>
                </p></li>
        </ul>
        <div class="sort_type">
            <a href="javascript:void(0);" title="销量" class="sales">销量</a>
            <a href="javascript:void(0);" title="价格" class="price">价格</a>
            <a href="javascript:void(0);" title="上架时间" class="time">上架时间</a>
        </div>
        <div class="mt ofc">
            <%--添加内容--%>
            <ul class="uls i_150x150 x4_150x150b" id="products">
                <c:forEach items="${data.content}" var="productList">
                    <li>
                        <a href="magnifyingGlass/${productList.product_id}" title="${productList.name}" target="_blank" class="pic">
                            <img
                                <%--src="/upload/${productList.imgUrl}"--%>
                                src="/upload/${productList.imgUrl}"
                                alt="${productList.name}"/></a>
                        <dl>
                            <!-- dt 10个文字+... -->
                            <dt><a href="magnifyingGlass/${productList.product_id}" title="${productList.name}"
                                   target="_blank">${productList.name}</a>
                            </dt>
                            <!-- dt 25个文字+... -->
                            <dd class="h40">${productList.my_desc}</dd>
                            <dd class="orange">￥${productList.price}</dd>
                            <dd>北京有货</dd>
                            <dd><a href="#" title="加入购物车" class="inb btn70x21 mr">加入购物车</a></dd>
                        </dl>
                        <c:set var="isHot" value="${productList.isHot}"></c:set>
                        <c:if test="${isHot.equals('是')}"><img src="/res/img/pic/hot.gif" alt="热门" class="type"/></c:if>
                    </li>
                </c:forEach>
            </ul>
            <div class="page pb15">
                <div style="width:800px;margin:0 auto;">
                    <div id="kkpager"></div>
                </div>
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