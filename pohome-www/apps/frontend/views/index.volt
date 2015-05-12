<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />		
		<title>{% if title is defined %}{{ title }}{% endif %}</title>
		
		<link href="/css/frontend.css" rel="stylesheet" type="text/css" />
<!-- 		<link href="/css/flexslider.css" rel="stylesheet" type="text/css" /> -->
		
		<script type="text/javascript" src="/js/jquery-2.1.1.min.js"></script>
		<script type="text/javascript" src="/js/common.js"></script>
		<script type="text/javascript" src="/js/jquery.flexslider.js"></script>
		<script type="text/javascript">
			jQuery(document).ready(function($) {				
				$(".adopt_recommond li").hover(
					function(){
						$(this).addClass('active');	
					},
					function(){
						$(this).removeClass('active');	
					}
				);
			});
		</script>
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
				{{ content() }}
		    </div>
		    
		    
		    
		    <div id="footer_wrap">
		    	<div class="footer">
		        	<div class="w_common">
		            	<div class="qrcode">
		                	<ul>
		                    	<li><img src="/img//qrcode_weixin.jpg" /><br />微信公众号</li>
		                        <li><img src="/img//qrcode_weibo.png" /><br />官方新浪微博</li>
		                    </ul>
		                </div>
		                <div class="text" style="margin-top: 40px;">
<!-- 		                    <p>电话：010-88800999 15011293294</p> -->
		                    <p>邮箱：contact@pohome.cn</p>
<!--
		                    <p>传真：010-88800999</p>
		                    <p>地址：北京市广渠门外大街名敦道11号楼1112</p>
-->                         <p>技术支持：逸品广告</p>
		                    <p>Copyright © 2007-2015 <a href="/admin/index/index" style="text-decoration: none;color: white">汪</a>汪喵呜孤儿院.All right reserved  京ICP备13030860号-2</p>
		                </div>
<!--
		                <div class="subscribe">
		                	<h3>加入邮件列表</h3>
		                    <div>
		                    <form>
		                    	<input class="input" type="text" name="email" value="" /> <input class="btn_submit" type="submit" name="submit" value="提 交" />
		                    </form>
		                    </div>
		                    <p>我们会通过电子邮件将最新的活动信息发到您的邮箱。</p>
		                </div>
-->
		                <div class="clear"></div>
		            </div>
		        </div>
		    </div>
		</div>
	</body>
</html>
