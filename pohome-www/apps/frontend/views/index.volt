<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		{% if meta is defined %}{{ meta }}{% endif %}
		
		<title>{% if title is defined %}{{ title }}{% endif %}</title>
		
		<link href="/css/frontend.css" rel="stylesheet" type="text/css" />
		
		<script type="text/javascript" src="/js/jquery-2.1.1.min.js"></script>
		<script type="text/javascript" src="/js/common.js"></script>
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
	</head>
	
	<body>
		<div id="wrap">
			<div id="header">
		    	<div id="top_wrap">
					<div class="row w_common">
		            	<a href="/login">登录</a>|<a href="register">注册</a>|<a>关注我们</a>
		            </div> 
		        </div>
		        <div class="header_wrap">
		            <div class="w_common header">
		                <div class="logo"><a href="/"><img src="/img/logo.png" width="266" height="76" /></a></div>
		                <div class="top_menu">
		                    <ul>
		                        <li class="active"><a href="/">首 页</a></li>
		                        <li><a href="/about">关于我们</a></li>
		                        <!-- <li><a href="./news.html">汪喵新闻</a></li> -->
		                        <li><a href="/pet">领养平台</a></li>
		                        <li><a href="/blog">博 客</a></li>
		                        <li><a href="/join">加入我们</a></li>
		                        <li><a href="/contact">联系我们</a></li>
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
		    
		    
		    <div class="main_wrap" id="{{ sectionId }}">
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
		                <div class="text">
		                    <p>电话：010-88800999 15011293294</p>
		                    <p>邮箱：xiaoxingren@163.com</p>
		                    <p>传真：010-88800999</p>
		                    <p>地址：北京市广渠门外大街名敦道11号楼1112</p>
		                    <p>Copyright © 2012-2014 汪汪喵呜孤儿院.All right reserved  ICP京B2-20130762 技术支持：逸品广告</p>
		                </div>
		                <div class="subscribe">
		                	<h3>加入邮件列表</h3>
		                    <div>
		                    <form>
		                    	<input class="input" type="text" name="email" value="" /> <input class="btn_submit" type="submit" name="submit" value="提 交" />
		                    </form>
		                    </div>
		                    <p>我们会通过电子邮件将最新的活动信息发到您的邮箱。</p>
		                </div>
		                <div class="clear"></div>
		            </div>
		        </div>
		    </div>
		</div>
	</body>
</html>
