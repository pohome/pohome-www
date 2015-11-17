<!DOCTYPE html>
<html lang="zh-cn">
	<head>
		<meta charset="utf-8">
		<title>汪汪喵呜孤儿院</title>
		
		<link rel="stylesheet" type="text/css" href="/semantic/semantic.min.css">
		<link rel="stylesheet" type="text/css" href="/css/frontend.css">

		<script type="text/javascript" src="/js/jquery-2.1.4.min.js"></script>
		<script type="text/javascript" src="/semantic/semantic.min.js"></script>
		<script  type="text/javascript" src="/js/jquery.bgswitcher.js"></script>		
		<script type="text/javascript" src="/js/frontend.js"></script>
		
		{% if addition is defined %}
		{{ addition }}
		{% endif %}
		
		<script>
            var _hmt = _hmt || [];
            (function() {
              var hm = document.createElement("script");
              hm.src = "//hm.baidu.com/hm.js?49040a029edd7f8e74a44e15b2871891";
              var s = document.getElementsByTagName("script")[0]; 
              s.parentNode.insertBefore(hm, s);
            })();
        </script>

	</head>
	
	<body>		
    	<header>
        	<div id="top-bar">
        		<div class="wrap">
    				<div id="logo"><a href="/"><img src="/image/logo.png" alt="汪汪喵呜孤儿院LOGO"></a></div>
    				<div id="user-panel">
        				{% if username is not defined %}
        				<span><a href="/user/login">登录</a></span>
        				<span><a href="/user/register">注册</a></span>
        				{% else %}
        				    {% if userHasAvatar %}
                            <img class="ui avatar image" src="/upload/img/user/avatar/small/{{ userId }}.jpg">
                            {% else %}
                            <img class="ui avatar image" src="/image/user-default-avatar-small.png">
                            {% endif %}
        				<span><a href="/user/center/{{ userId }}">{{ username }}</a></span>
        				<span><a href="/admin">后台管理</a></span>
        				<span><a href="/user/logout">退出</a></span>
        				{% endif %}
    				</div>
<!--
    				<div class="ui search" id="search-field">
        				<div class="ui icon input">
            				<input class="prompt" name="global-search" type="text" placeholder="搜索...">
                            <i class="search icon"></i>
        				</div>
    				</div>
-->
    				<div class="results"></div>
    		    </div>
        	</div>
        	<div class="wrap center">
            	<ul id="menu">
                	<li><a href="/"><div>HOME</div><div>首页</div></a></li>
                	<li><a href="/about"><div>ABOUT</div><div>关于我们</div></a></li>
                	<li><a href="/pet"><div>DOGS & CATS</div><div>汪星人 & 喵星人</div></a></li>
                	<li><a href="/event"><div>EVENTS</div><div>活动</div></a></li>
                	<li><a href="/blog"><div>BLOG</div><div>博客</div></a></li>
                	<li><a href="/user/center"><div>INDIVIDUAL CENTER</div><div>个人中心</div></a></li>
                	<li><a href="http://pohome.taobao.com" target="_blank"><div>SHOP</div><div>公益淘宝店</div></a></li>
            	</ul>
        	</div>
    	</header>
    	
    	{{ content() }}
	    
    	<footer>
        	<div>扫一扫，关注汪汪喵呜孤儿院</div>
        	<div>
            	<div style="display: inline-block;text-align: center">
                	<img src="/image/qrcode-wechat.png" width="85">
                	<div>微信公众号</div>
            	</div>
            	<div style="display: inline-block;text-align: center">
                	<img src="/image/qrcode-weibo.png" width="85">
                	<div>微博</div>
            	</div>
        	</div>
            <div>Copyright © 2007 - <?php echo date('Y');?> 汪汪喵呜孤儿院.All right reserved</div>
            <div>京ICP备13030860号-2</div>
    	</footer>
	</body>
</html>