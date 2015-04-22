<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>登录</title>
	<link href="/css/frontend.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="/js/jquery-2.1.1.min.js"></script>
	<script type="text/javascript" src="/js/common.js"></script>
</head>

<body>
	<div id="wrap">
		<div class="w_common login_wrap">
	    	<div class="logo"><a href="/"><img src="/img/logo.png" width="266" height="76" /></a></div>
	    	<div class="b">
	        	<div class="f_l">
	            	<img src="/img/login_img.png" width="369" height="369" />
	            </div>
	            <form class="f_r radius_2 login_form" method="post">
	                <h2>登录</h2>
	                <div class="c">
	                    <div class="row"><input class="inp_user" type="text" name="username" value="" /></div>
	                    <div class="row"><input class="inp_password" type="password" name="password" value="" /></div>
	                    {% if error['用户名不存在'] is defined %}
	                    <div>用户名不存在</div>
	                    {% endif %}
	                    {% if error['密码错误'] is defined %}
	                    <div>密码错误</div>
	                    {% endif %}
	                    <p><input type="checkbox" name="remember_me" /> 7天内免登录 <a class="f_r" href="/user/forgot">忘记登录密码？</a></p>
	                    <div class="row"><input class="radius_2 btn_submit" type="submit" name="submit" value="登 陆" /></div>
	                    <p><a class="f_r" href="/user/register">注册</a></p>
	                </div>
	            </form>
	            <div class="clear"></div>
	        </div>
	    </div>
	    <div id="footer_wrap">
	    	<div class="footer">
	        	<div class="w_common">
	            	<div class="qrcode">
	                	<ul>
	                    	<li><img src="/img/qrcode_weixin.jpg" /><br />微信公众号</li>
	                        <li><img src="/img/qrcode_weibo.png" /><br />官方新浪微博</li>
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
