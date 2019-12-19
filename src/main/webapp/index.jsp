<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE HTML>
<html>
<head>
	<link rel="icon" href="img/logo.jpg" type="image/x-icon"> 
	<link rel="shortcut icon" href="img/logo.jpg" type="image/x-icon">
    <title>读心术小游戏</title>
    <meta charset="utf-8">
    <meta name="Author" content="魔术师大鹏">
    <link rel="stylesheet" type="text/css" href="css/reset.css"/>
    <style type='text/css'>
        * { margin: 0; padding: 0; }

        body { background-color: rgba(52, 52, 53, 0.82); }

        .cont { width: 880px; height: auto; margin: 20px auto; background-color: rgba(255, 205, 156, 0.64); overflow: hidden; border-radius: 30px }

        .wrap { width: 480px; margin: 20px; overflow: hidden; float: left; box-shadow: 0 0 4px rgba(59, 44, 49, 0.8); padding: 10px 0 10px 10px; border-radius: 20px; }

        .wrap div { width: 30px; height: 30px; float: left; margin: 0 10px 30px 0; text-align: center; box-shadow: 0 0 1px #aa64c8; border-radius: 100% }

        .wrap div img { display: block; overflow: hidden; border-radius: 100% }

        .wrap div span { font-size: 20px; font-family: Andalus; color: #000000; text-shadow: 0 1px 0px #000000; line-height: 10px }

        .box { width: 310px; margin: 0 auto; float: left; }

        .box .explain { padding: 10px; margin: 0 auto; width: 300px; font-size: 16px; line-height: 25px; color: #000000; font-family: 'Microsoft JhengHei'; font-weight: bold; }

        .box .btnRe { width: 100px; margin: 20px auto; text-align: center; line-height: 40px; background-color: rgba(255, 205, 156, 0.64); font-size: 16px; color: #000000; cursor: pointer; padding: 3px; border-radius: 10px; font-weight: 300; }

        .box .btnRe:hover { border: 3px solid rgba(255, 205, 156, 0.64); background-color: #6c85c8; color: rgba(255, 205, 156, 0.64); padding: 0; }

        .box .showbox { width: 120px; height: 120px; background-color: rgba(255, 230, 207, 0.64); margin: 10px auto; border-radius: 50%; overflow: hidden; box-shadow: 0 0 10px #aa64c8; }

        .box .showbox img { opacity: 0.3; }

        .cont .box .on { animation: active 2s; -webkit-animation: active 2s; }

        @keyframes acitve {
            0% { box-shadow: 0 0 50px #c789c8; }
            50% { box-shadow: 0 0 30px #aa64c8; }
            100% { box-shadow: 0 0 10px #aa64c8; }
        }

        @-webkit-keyframes active {
            0% { box-shadow: 0 0 50px #c789c8; }
            50% { box-shadow: 0 0 30px #aa64c8; }
            100% { box-shadow: 0 0 10px #aa64c8; }
        }

    </style>
    <script type="text/javascript" src="js/jquery-2.2.0.min.js"></script>

</head>
<body>
<div class="cont">
    <div class="wrap"></div>
    <div class="box">
        <div class="explain">
            <strong>游戏规则:</strong><br>任意选择一个两位数（或者说，从10~99之间任意选择一个数），把这个数的十位与个位相加，再把任意选择的数减去这个和。并把这个图形牢记心中，然后点击水晶球。<br>你会发现，水晶球所显示出来的图形就是你刚刚心里记下的那个图形。<br>例如：你选的数是23，然后2+3=5，然后23-5=18,在图表中找出与最后得出的数所相应的图形
        </div>
        <div class="showbox"><img src="" alt=""></div>
        <div class="btnRe">刷 新</div>
    </div>
</div>


<script>
    /*公式: ab 10a+b-a-b=9a OR 10a-a=9a */
    (function () {
        var $wrap = $('.wrap'), $show = $('.showbox');
        var str = '';
        var timer = null;
        var timerout = null;
        for (var i = 1; i <= 96; i++) {
            str += '<div><img src="" alt="" width="30" height="30" autocomplete="off"><span>' + i + '</span></div>'
        }
        $wrap.append(str);
        init();
        $('.btnRe').click(function () {
            reset();
            $show.removeClass('on').find('img').attr('src', '').stop().animate({opacity: 0.3,}, 1000);
            timer = setInterval(init, 10);
            timerout = setTimeout(function () {
                clearInterval(timer)
            }, 1000);
        })
        $('.showbox').click(function () {
            reset();
            timer = setInterval(start, 10);
            timerout = setTimeout(end, 1000);
        })
        function init() {
            var ran = Math.floor(Math.random() * 99) + 1;
            $('.wrap').find('div').each(function (i) {
                var ran1 = Math.floor(Math.random() * 99) + 1;
                if (i % 9 == 0) {
                    $('.wrap').find('div').eq(i - 1).find('img').attr('src', 'img/' + (ran) + '.png');
                } else {
                    $('.wrap').find('div').eq(i - 1).find('img').attr('src', 'img/' + (ran1) + '.png');
                };
            });
        };
        function reset() {
            clearTimeout(timerout);
            clearInterval(timer);
        };

        function start() {
            var x = Math.floor(Math.random() * 99) + 1;
            $show.addClass('on').find('img').attr('src', 'img/' + x + '.png').css({opacity: 0.3})
        };

        function end() {
            clearInterval(timer)
            clearTimeout(timerout)
            var img = $wrap.find('div').eq(8).find('img').attr('src');
            $show.addClass('on').find('img').attr('src', img).stop().animate({opacity: 1,}, 3000);
        };
    })()
</script>
</body>
</html>