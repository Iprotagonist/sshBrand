<%--
  Created by IntelliJ IDEA.
  User: thundersoft
  Date: 2018/1/18
  Time: 14:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <script src="/res/assets/js/jquery-1.11.3.min.js"></script>
    <script type="text/javascript" src="/js/jquery.imagezoom.js"></script>
    <style type="text/css">
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
<body>
<div class="box">
    <div class="tb-booth tb-pic tb-s310">
        <a href="/upload/01.jpg"><img src="/upload/01_mid.jpg" alt="美女" rel="/upload/01.jpg" class="jqzoom" /></a>
    </div>
    <ul class="tb-thumb" id="thumblist">
        <li class="tb-selected"><div class="tb-pic tb-s40"><a href="#"><img src="/upload/01_small.jpg" mid="/upload/01_mid.jpg" big="/upload/01.jpg"></a></div></li>
        <li><div class="tb-pic tb-s40"><a href="#"><img src="/upload/02_small.jpg" mid="/upload/02_mid.jpg" big="/upload/02.jpg"></a></div></li>
        <li><div class="tb-pic tb-s40"><a href="#"><img src="/upload/03_small.jpg" mid="/upload/03_mid.jpg" big="/upload/03.jpg"></a></div></li>
        <li><div class="tb-pic tb-s40"><a href="#"><img src="/upload/04_small.jpg" mid="/upload/04_mid.jpg" big="/upload/04.jpg"></a></div></li>
        <li><div class="tb-pic tb-s40"><a href="#"><img src="/upload/05_small.jpg" mid="/upload/05_mid.jpg" big="/upload/05.jpg"></a></div></li>
    </ul>
</div>
<script type="text/javascript">
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
</body>
</html>
