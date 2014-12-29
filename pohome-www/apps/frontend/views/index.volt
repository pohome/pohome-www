<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		
		<title>{{ title }}</title>
		
		<link href="css/frontend.css" rel="stylesheet" type="text/css" />
		
		<script type="text/javascript" src="js/jquery-2.1.1.min.js"></script>
		<script type="text/javascript" src="js/common.js"></script>
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
		            	<a href="login.html">登录</a>|<a href="register.html">注册</a>|<a>关注我们</a>
		            </div> 
		        </div>
		        <div class="header_wrap">
		            <div class="w_common header">
		                <div class="logo"><a href="./index.html"><img src="img/logo.png" width="266" height="76" /></a></div>
		                <div class="top_menu">
		                    <ul>
		                        <li class="active"><a href="./index.html">首 页</a></li>
		                        <li><a href="./about.html">关于我们</a></li>
		                        <!-- <li><a href="./news.html">汪喵新闻</a></li> -->
		                        <li><a href="./adopt.html">领养平台</a></li>
		                        <li><a href="./blog.html">博 客</a></li>
		                        <li><a href="./join.html">加入我们</a></li>
		                        <li><a href="./contact.html">联系我们</a></li>
		                        <li><a href="./">公益淘宝</a></li>
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
		    	<div style="position:relative; width:100%; height:559px; overflow:hidden;">
		            <div style="position:absolute; left:50%; margin-left:-951px;">
		                <img src="img/demo/ad_home.jpg" width="1903" />
		            </div>
		        </div>
		    	<div class="w_common main">
		            <div class="mode">
		            	<ul>
		                	<li class="sponsor">
		                    	<h3>助养</h3>
		                        <p>蓝天白云，绿水青山，阳光普照，微风蓝天白云，绿水青山，阳光普照蓝天白云，绿水青山，阳光普照轻享受不到蓝动物享受不享受不到蓝动物享受不享......</p>
		                        <a href="sponsor.html">点击查看 ></a>
		                    </li>
		                    <li class="donate">
		                    	<h3>捐赠</h3>
		                        <p>蓝天白云，绿水青山，阳光普照，微风蓝天白云，绿水青山，阳光普照蓝天白云，绿水青山，阳光普照轻享受不到蓝动物享受不享受不到蓝动物享受不享......</p>
		                        <a href="donate.html">点击查看 ></a>
		                    </li>
		                    <li class="volunteer">
		                    	<h3>志愿者</h3>
		                        <p>蓝天白云，绿水青山，阳光普照，微风蓝天白云，绿水青山，阳光普照蓝天白云，绿水青山，阳光普照轻享受不到蓝动物享受不享受不到蓝动物享受不享......</p>
		                        <a href="volunteer.html">点击查看 ></a>
		                    </li>
		                </ul>
		                <div class="clear"></div>
		            </div>
		            
		            <div class="adopt_recommond">
		            	<div class="title"><h3>领养推荐</h3> <span class="num">23new</span> <span class="more"><a href="#">■more</a></span></div>
		                <div class="content">
		                	<ul>
		                    	<li>
		                        	<div class="pet_image">
		                            	<a href="view.html"><img src="statics/images/demo/example_home_01.jpg" width="210" height="210" /></a>
		                                <a href="view.html" class="view"></a>
		                            </div>
		                            <a href="view.html" title="帅帅和小乖" class="pet_name">帅帅和小乖</a>
		                        </li>
		                        <li>
		                        	<div class="pet_image">
		                            	<a href="view.html"><img src="statics/images/demo/example_home_01.jpg" width="210" height="210" /></a>
		                                <a href="view.html" class="view"></a>
		                            </div>
		                            <a href="view.html" title="帅帅和小乖" class="pet_name">帅帅和小乖</a>
		                        </li>
		                        <li>
		                        	<div class="pet_image">
		                            	<a href="view.html"><img src="statics/images/demo/example_home_01.jpg" width="210" height="210" /></a>
		                                <a href="view.html" class="view"></a>
		                            </div>
		                            <a href="view.html" title="帅帅和小乖" class="pet_name">帅帅和小乖</a>
		                        </li>
		                        <li>
		                        	<div class="pet_image">
		                            	<a href="view.html"><img src="statics/images/demo/example_home_01.jpg" width="210" height="210" /></a>
		                                <a href="view.html" class="view"></a>
		                            </div>
		                            <a href="view.html" title="帅帅和小乖" class="pet_name">帅帅和小乖</a>
		                        </li>
		                        <li>
		                        	<div class="pet_image">
		                            	<a href="view.html"><img src="statics/images/demo/example_home_01.jpg" width="210" height="210" /></a>
		                                <a href="view.html" class="view"></a>
		                            </div>
		                            <a href="view.html" title="帅帅和小乖" class="pet_name">帅帅和小乖</a>
		                        </li>
		                        <li>
		                        	<div class="pet_image">
		                            	<a href="view.html"><img src="statics/images/demo/example_home_01.jpg" width="210" height="210" /></a>
		                                <a href="view.html" class="view"></a>
		                            </div>
		                            <a href="view.html" title="帅帅和小乖" class="pet_name">帅帅和小乖</a>
		                        </li>
		                        <li>
		                        	<div class="pet_image">
		                            	<a href="view.html"><img src="statics/images/demo/example_home_01.jpg" width="210" height="210" /></a>
		                                <a href="view.html" class="view"></a>
		                            </div>
		                            <a href="view.html" title="帅帅和小乖" class="pet_name">帅帅和小乖</a>
		                        </li>
		                        <li>
		                        	<div class="pet_image">
		                            	<a href="view.html"><img src="statics/images/demo/example_home_01.jpg" width="210" height="210" /></a>
		                                <a href="view.html" class="view"></a>
		                            </div>
		                            <a href="view.html" title="帅帅和小乖" class="pet_name">帅帅和小乖</a>
		                        </li>
		                        <li>
		                        	<div class="pet_image">
		                            	<a href="view.html"><img src="statics/images/demo/example_home_01.jpg" width="210" height="210" /></a>
		                                <a href="view.html" class="view"></a>
		                            </div>
		                            <a href="view.html" title="帅帅和小乖" class="pet_name">帅帅和小乖</a>
		                        </li>
		                        <li>
		                        	<div class="pet_image">
		                            	<a href="view.html"><img src="statics/images/demo/example_home_01.jpg" width="210" height="210" /></a>
		                                <a href="view.html" class="view"></a>
		                            </div>
		                            <a href="view.html" title="帅帅和小乖" class="pet_name">帅帅和小乖</a>
		                        </li>
		                    </ul>
		                    <div class="clear"></div>
		                </div>
		            </div>
		            
		            <div class="m_30 row">
		            	<div class="f_l box index_blog">
		                	<div class="title"><h3>最新博客</h3> <span class="more"><a href="#">■more</a></span></div>
		                    <div class="content">
		                    	<ul>
		                        	<li>
		                            	<div class="l_image"><a href="blog_view.html"><img src="statics/images/demo/example_home_weibo.jpg" width="265" /></a></div>
		                                <div class="l_info">
		                                	<h2><a href="blog_view.html">上演现实版《我和狗狗的约定》</a></h2>
		                                    <p class="descr">14日中午，在张远位于乌鲁木齐市米东区一处偏僻的农家大院的流浪狗救助站里，14日中午，在张远位于乌鲁木齐市米东区一处偏僻的农家大院的流浪狗救农家大院的流里，张远挨个和狗狗们打着招呼——"欢欢、点点、揪片子、心肝儿、宝宝……"</p>
		                                    <p class="tag">标签：<a>流浪求</a><a>爱情</a><a>狗狗</a> </p>
		                                </div>
		                                <div class="clear"></div>
		                            </li>
		                            <li class="last">
		                            	<div class="l_image"><a href="blog_view.html"><img src="statics/images/demo/example_home_weibo.jpg" /></a></div>
		                                <div class="l_info">
		                                	<h2><a href="blog_view.html">上演现实版《我和狗狗的约定》</a></h2>
		                                    <p class="descr">14日中午，在张远位于乌鲁木齐市米东区一处偏僻的农家大院的流浪狗救助站里，14日中午，在张远位于乌鲁木齐市米东区一处偏僻的农家大院的流浪狗救农家大院的流里，张远挨个和狗狗们打着招呼——"欢欢、点点、揪片子、心肝儿、宝宝……"</p>
		                                    <p class="tag">标签：<a>流浪求</a><a>爱情</a><a>狗狗</a> </p>
		                                </div>
		                                <div class="clear"></div>
		                            </li>
		                        </ul>
		                    </div>
		                </div>
		                
		                <div class="f_r box index_story">
		                	<div class="title"><h3>领养故事</h3> <span class="more"><a href="#">■more</a></span></div>
		                    <div class="content">
		                    	<img src="statics/images/demo/example_home_lingyang.jpg" width="353"/>
		                    	<span class="date">2014年07月11日</span>
		                    	<p class="descr">05年我跟我的兄妹出生在小区的绿化带，零下三度冻死了一个兄弟，当晚嘛嘛把我们四个和狗妈妈带进了家里，坐生第五天狗妈妈出去尿尿再也没回来，从来没养过狗的嘛嘛担当起了奶妈，我们四个活下来了，我的兄弟姐妹被嘛嘛分别安排在朋友家里，我们现被留在了嘛嘛身边......<a href="#">[详细]</a></p>
		                    </div>
		                </div>
		                <div class="clear"></div>
		            </div>
		            <div class="clear"></div>
		    	</div>
		    </div>
		    
		    
		    
		    <div id="footer_wrap">
		    	<div class="footer">
		        	<div class="w_common">
		            	<div class="qrcode">
		                	<ul>
		                    	<li><img src="statics/images/qrcode_01.jpg" /><br />微信公众号</li>
		                        <li><img src="statics/images/logo_f_02.jpg" /><br />官方新浪微博</li>
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
