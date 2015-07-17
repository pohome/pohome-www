<!DOCTYPE html>
<html lang="zh-cn">
    <head>
		<meta charset="utf-8">
		<title>汪汪喵呜孤儿院 - 登录</title>
		
		<link rel="stylesheet" type="text/css" href="/semantic/semantic.min.css">

		<script type="text/javascript" src="/js/jquery-2.1.4.min.js"></script>
		<script type="text/javascript" src="/semantic/semantic.min.js"></script>
		
		<style>
    		body {
        		background-image: url(/image/login-background.jpg);
        		background-position: center center;
        		background-size: cover;
        		width: 960px;
        		margin: 0 auto;
    		}
    		
    		#logo {
        		height: 53px;
        		margin: 8px;
        		display: inline-block;
    		}
    		
    		#login_wrap {
        		width: 400px;
        		background-color: rgba(255, 255, 255, 0.8);
        		outline: 20px rgba(255, 255, 255, 0.1) solid;
        		margin-left: 520px;
        		margin-top: 200px;
    		}
    		
    		.ui.form {
        		padding: 20px;
    		}
    		
    		#title {
        		font-size: 18px;
        		height: 60px;
        		color: white;
        		text-align: center;
        		line-height: 60px;
        		background-color: #21ba45;
    		}
		</style>
    </head>
    <body>
        <header><a href="/"><img src="/image/logo.png" id="logo"></a></header>
        <div id="login_wrap">
            <div id="title">登 录</div>
            <form class="ui form{% if error is defined %} error{% endif %}" method="post">
                {% if error is defined %}
                <div class="ui error message">
                    <div class="header">账户信息错误</div>
                    {% if error['用户名不存在'] is defined %}
                    <p>您输入的账户名不存在</p>
                    {% endif %}
                    {% if error['密码错误'] is defined %}
                    <p>您输入的密码错误</p>
                    {% endif %}
                </div>
                {% endif %}
                
                <div class="field">
                    <div class="ui icon input">
                        <input type="text" name="username" placeholder="用户名" />
                        <i class="user icon"></i>
                    </div>
                </div>
                
                <div class="field">
                    <div class="ui icon input">
                        <input type="password" name="password" placeholder="密码" />
                        <i class="lock icon"></i>
                    </div>
                </div>
                
                <div class="field">
                    <div class="ui checkbox">
                        <input type="checkbox" name="remember_me">
                        <label>7天之内免登录</label>
                    </div>
                </div>
                <div>
                    <input type="submit" class="ui green button" value="登录" style="float:left;">
<!--                     <a href="/user/forgot" style="float: left;line-height: 36px;margin-left: 1em;">忘记密码</a> -->
                    <a href="/user/register" style="float: right;line-height: 36px;">注册</a>
                </div>
                <div style="clear: both"></div>
            </form>
                    
        </div>
            
    </body>
</html>

<script type="text/javascript">
    $(document).ready(function() {
        $('.ui.checkbox').checkbox();
    });