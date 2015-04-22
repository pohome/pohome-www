<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />		
		<title>{% if title is defined %}{{ title }}{% endif %}</title>
		
		<link href="/css/frontend.css" rel="stylesheet" type="text/css" />

		<script type="text/javascript" src="/js/jquery-2.1.1.min.js"></script>
		<script type="text/javascript" src="/js/common.js"></script>
		
		<style>
    		img.bg {
        		min-height: 100%;
        		min-width: 1024px;
        		width: 100%;
        		height: auto;
        		position: fixed;
        		top: 0;
        		left: 0;
        		z-index: 1;
    		}
    		
    		#intro {
        		z-index: 10;
        		position: absolute;
        		background-color: rgb(255,255,255);
                width: 25em;
                font-size: 1.5em;
                right: 100px;
                top: 250px;
                color: black;
                padding: 2em;
                opacity: 0.75;
    		}
    		
    		#intro p {
        		margin: 1em 0;
    		}
        </style>
	</head>
	
	<body>
    	<div id="wrap">
			<div id="header">
		    	<div id="top_wrap">
					<div class="row w_common">
						{% if username is not defined %}
		            	<a href="/user/login">登录</a>|<a href="/user/register">注册</a>
		            	{% else %}
		            	<a href="/user/center/{{ userId }}">{{ username }}</a>|<a href="/user/logout">退出登录</a>
		            	{% endif %}
		            </div> 
		        </div>
		        <div class="header_wrap">
		            <div class="w_common header">
		                <div class="logo"><a href="/"><img src="/img/logo-origin.png" width="266" height="76" /></a></div>
		                <div class="top_menu">
		                    <ul>
		                        <li {% if menu_frontpage is defined %}class="active"{% endif %}><a href="/">首页</a></li>
		                        <li {% if menu_about is defined %}class="active"{% endif %}><a href="/about">关于我们</a></li>
		                        <li {% if menu_pet is defined %}class="active"{% endif %}><a href="/pet">领养&助养</a></li>
		                        <li {% if menu_blog is defined %}class="active"{% endif %}><a href="/blog">博客</a></li>
		                        <li {% if menu_event is defined %}class="active"{% endif %}><a href="/event">活动</a></li>
<!--
		                        <li {% if menu_volunteer is defined %}class="active"{% endif %}><a href="/volunteer">加入我们</a></li>
		                        <li {% if menu_faq is defined %}class="active"{% endif %}><a href="/faq">常见问题</a></li>
-->
		                        <li><a href="http://pohome.taobao.com">公益淘宝</a></li>
		                    </ul>
		                </div>
<!--
		                <div class="mini_search">
		                    <form>
		                        <input class="input" type="text" name="keyword" value="" placeholder="关键字" /><input class="btn_submit" type="submit" name="submit" value="" />
		                    </form>
		                </div>
-->
		                <div class="clear"></div>                                                           
		            </div>
		        </div>
		    </div>
		    
		    
		    <div class="main_wrap">
				<img src="/img/demo/background.jpg" class="bg">
				<div id="intro">
    				<p>汪汪喵呜孤儿院（Pet Orphans Home）成立于2007年，是由年轻人组成的一家非营利、公益性的动物领养中心。自07年成立至今，在北京地区拥有数百名志愿者和几十家合作伙伴，成功救助了千余只流浪动物并帮助它们重新回归家庭。</p>
                    <p>汪汪喵呜孤儿院在北京良乡和天通苑社区建有两处领养中心，可同时容纳70只动物健康生活、医疗养护、行为养成、领养沟通，还兼顾线上线下活动宣传、志愿者培训等。同时，根据国际通用的动物福利标准，我们一直在不断改善领养中心的设施及管理系统。与许多公益组织一样，汪汪喵呜孤儿院也需要更多义工的帮助和来自社会各界的捐款。</p>
                    <p>汪汪喵呜孤儿院的目标是——做中国最好的领养中心。</p>
                    <p>2015年，汪汪喵呜孤儿院将推出一个全国性的大型网络自助领养平台，用爱终止流浪。</p>
                    <p>汪汪喵呜孤儿院在北京良乡的领养基地，占地1800平方米，2011年按照英国防止虐待动物协会（RSPCA）的指导手册在原有基础上改建完成，同时得到了国际爱护动物基金会（IFAW）和 香港爱护动物协会（SPCA HK）的大力支持。可同时容纳60只动物的健康生活、隔离、免疫、领养沟通、志愿者活动等。每周末有一天为志愿者开放日，志愿者均可关注微博微信，报名参加活动。</p>
				</div>
		    </div>
	</body>
</html>