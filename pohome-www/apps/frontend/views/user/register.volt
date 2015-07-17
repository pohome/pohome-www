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
            <div id="title">用户注册</div>
            <form class="ui form{% if error is defined %} error{% endif %}" method="post">
                {% if error is defined %}
                <div class="ui error message">
                    <div class="header">账户信息错误</div>
                    <ul>
                    {% if error['空用户名'] is defined %}<li>用户名不能为空</li>{% endif %}
                    {% if error['用户名已存在'] is defined %}<li>用户名已存在</li>{% endif %}
                    {% if error['密码为空'] is defined %}<li>密码不能为空</li>{% endif %}
                	{% if error['密码格式错误'] is defined %}<li>密码由字母与数字组成</li>{% endif %}
                	{% if error['两次输入的密码不一致'] is defined %}<li>两次输入的密码不一致</li>{% endif %}
                	{% if error['Email为空'] is defined %}<li>Email地址不能为空</li>{% endif %}
                	{% if error['Email格式错误'] is defined %}<p>Email地址格式错误</p>{% endif %}
                	{% if error['Email已存在'] is defined %}<li>Email地址已存在</li>{% endif %}
                    </ul>
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
                    <div class="ui icon input">
                        <input type="password" name="password_retype" placeholder="密码" />
                        <i class="lock icon"></i>
                    </div>
                </div>
                
                <div class="field">
                    <div class="ui icon input">
                        <input type="text" name="email" placeholder="Email" />
                        <i class="mail icon"></i>
                    </div>
                </div>
                
                <div>
                    <input type="submit" class="ui green button" value="提交" style="float:left;">
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