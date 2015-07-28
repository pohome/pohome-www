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
            <div id="title">注册成功</div>
            <div style="height: 200px;padding: 40px">
                <p>恭喜您已完成注册，页面将在5秒后自动跳转到注册前您访问的页面</p>
                <p>您还可以跳转到<a href="/user/center/service-intension">填写志愿者服务意向</a>页面</p>
            </div>
        </div>
            
    </body>
</html>

<script type="text/javascript">
	setTimeout("window.location.href='/'", 5000);
</script>