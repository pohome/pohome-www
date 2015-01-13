<html>
	<head>
		<meta charset="utf-8">
		
		<link href="/css/semantic.min.css" rel="stylesheet">
		
		<script src="/js/jquery-2.1.1.min.js"></script>
		<script src="/js/jquery.form.js"></script>
		<script src="/js/semantic.min.js"></script>
		
		<title>{{ title }}</title>
		
		<style type="text/css">
			body {
				font-family: "HiraginoSansGB-W3", "Microsoft YaHei", "sans-serif";
				background-color: #eee;
				margin: 0;
				padding: 0;
			}

			#parent {
				position: relative;
				width: 100%;
				height: 100%;
			}
			
			#child {
				position: absolute;
				top: 35%;
				left: 50%;
				width: 400px;
				-ms-transform: translate(-50%,-50%); /* IE 9 */
				-webkit-transform: translate(-50%,-50%);	/* Safari and Chrome */
				-o-transform: translate(-50%,-50%); /* Opera */
				-moz-transform: translate(-50%,-50%);	/* Firefox */
				transform: translate(-50%,-50%);
			}
			
			form {
				padding: 40px 20px !important;
			}
			
			#error_list {
				padding-left: 1em !important;
			}
		</style>
	</head>
	
	<body>
		<div id="parent">
			<div id="child">
				<form name="backendLoginForm" class="ui {% if result.hasErr %} error {% endif %} form segment" method="post">
					
					{% if result.hasErr %}
					<div class="ui small error message" id="fid_error_message">
						<ul id="error_list">
							{% for msg in result.errMsg %}
							<li>{{ msg }}</li>
							{% endfor %}
						</ul>
					</div>
					{% endif %}
					
					<div class="inline <?php if(in_array('username', $result->errField)) {?> error <?php }?> field" id="fid_username">
						<div class="ui left icon input">
							<input type="text" name="username" placeholder="用户名" />
							<i class="user icon"></i>
						</div>
					</div>
					
					<div class="inline <?php if(in_array('password', $result->errField)) {?> error <?php }?> field" id="fid_password">
						<div class="ui left icon input">
							<input type="password" name="password" placeholder="密码" />
							<i class="lock icon"></i>
						</div>
					</div>
					
					<input type="hidden" name="{{ tokenKey }}" value="{{ token }}" />
					
					<div style="text-align: center; margin-top: 2em">
						<input type="submit" value="登录" class="ui teal submit button" style="width: 100%" />
					</div>
					
				</form>
			</div>
		</div>
	</body>
</html>