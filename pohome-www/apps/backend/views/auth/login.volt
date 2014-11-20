<html>

	<head>
		<meta charset="utf-8">
		
		<link href="/css/semantic.css" rel="stylesheet">
		<link href="/css/backend.css" rel="stylesheet">
		
		<script src="/js/jquery-2.1.1.min.js"></script>
		<script src="/js/jquery.form.js"></script>
		<script src="/js/semantic.min.js"></script>
		<script src="/js/backend.js"></script>
		
		<title>{{ title }}</title>
		
		<style type="text/css">
			#parent {
				position: relative;
				width: 100%;
				height: 100%;
			}
			
			#child {
				position: absolute;
				top: 35%;
				left: 50%;
				-ms-transform: translate(-50%,-50%); /* IE 9 */
				-webkit-transform: translate(-50%,-50%);	/* Safari and Chrome */
				-o-transform: translate(-50%,-50%); /* Opera */
				-moz-transform: translate(-50%,-50%);	/* Firefox */
				transform: translate(-50%,-50%);
			}
		</style>
	</head>
	
	<body>
		<div id="parent">
			<div id="child">
				<form name="backendLoginForm" class="ui form segment" method="post">
					
					<div class="ui small error message" id="fid_error_message" style="margin: 1em; width: 320px;">
						<ul id="error_list">
						</ul>
					</div>
					<div class="inline field" id="fid_username">
						<div class="ui left icon input">
							<input type="text" name="username" placeholder="用户名" />
							<i class="user icon"></i>
						</div>
					</div>
					
					<div class="inline field" id="fid_password">
						<div class="ui left icon input">
							<input type="password" name="password" placeholder="密码" />
							<i class="lock icon"></i>
						</div>
					</div>
					
					<input type="hidden" name="{{ tokenKey }}" value="{{ token }}" />
					<div style="text-align: center; margin: 2em 1em 1em 1em">
						<input type="submit" value="登录" class="ui teal submit button" style="width: 100%" />
					</div>
				</form>
			</div>
		</div>
	</body>
</html>

<script type="text/javascript">
	$(document).ready(function() {
		
		$('form').on('submit', function(e) {
			e.preventDefault();
			$(this).toggleClass("loading");
			
			$(this).ajaxSubmit({
				dataType : "json",
				success : function(result) {
					console.log(result);
					
					var form = $("form");
					
					if(result.hasError) {
						if(!form.hasClass("error")) {
							form.toggleClass("error");
						}
						
						// TODO: 优化对错误信息的处理
						$("#error_list").empty(); // 清空错误信息列表
						form.children().removeClass("error");
						$("#fid_error_message").addClass("error");
						
						for(i in result.errorMsg) {
							$("#error_list").append("<li>" + result.errorMsg[i] + "</li>");
							if(!$("#fid_" + result.errorField[i]).hasClass("error")) {
								$("#fid_" + result.errorField[i]).toggleClass("error");
							}
						}
					} else {
						// 登录成功，跳转到登录前的页面或者后台管理首页
						window.location.href = result.url;
					}
					
					form.toggleClass("loading");
				}
			});
		});
	});
</script>