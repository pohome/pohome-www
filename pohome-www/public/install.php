<html>
	<head>
		<meta charset="utf-8">
		
		<link href="/css/semantic.min.css" rel="stylesheet">
		

		<script src="/js/jquery-2.1.1.min.js"></script>
		<script src="/js/jquery.form.js"></script>
		<script src="/js/semantic.min.js"></script>
		
		<style>
			body {
				margin: 300px auto;
				width: 400px;
			}
		</style>
		
		<title>汪汪喵呜孤儿院管理系统安装程序</title>
	</head>
	
	<body>
		<?php
		if(empty($_POST)) {
			$uploadCanWrite = is_writeable('upload');
			$frontendCompiledCanWrite = is_writeable('../apps/frontend/views/compiled');
			$backendCompiledCanWrite = is_writeable('../apps/backend/views/compiled');
			
			if(!$uploadCanWrite || !$frontendCompiledCanWrite || !$backendCompiledCanWrite) {
		?>
		<div class="ui error message">
			<div class="header">
				文件目录权限有误
			</div>
			<div class="list">
		<?php
				if(!$uploadCanWrite) {
					echo '<li>./upload目录不可写';
				}
				if(!$frontendCompiledCanWrite) {
					echo '<li>../apps/frontend/views/compiled目录不存在或不可写';
				}
				if(!$backendCompiledCanWrite) {
					echo '<li>../apps/backend/views/compiled目录不存在或不可写';
				}
			echo '</div></div>';
			}
		?>
		<form class="ui segment form" method="post">
			<div class="field">
				<label>账户名</label>
				<input name="username" type="text">
			</div>
			<div class="field">
				<label>密码</label>
				<input name="password" type="password">
			</div>
			<div class="field">
				<label>Email</label>
				<input name="email" type="email">
			</div>
			<input class="ui teal button" type="submit" value="保存">
		</form>
		<?php
		}
		else {
			$config = new \Phalcon\Config\Adapter\Ini('../apps/config/config.ini');
			$di = new \Phalcon\DI\FactoryDefault();
			
			$di->set('db', function() use ($config) {
				return new \Phalcon\Db\Adapter\Pdo\Mysql(array(
					'host' => getenv('DB_HOST')? getenv('DB_HOST') : $config->database->host,
					'username' => getenv('DB_USER')? getenv('DB_USER') : $config->database->username,
					'password' => getenv('DB_PASSWORD')? getenv('DB_PASSWORD') : $config->database->password,
					'dbname' => $config->database->dbname
				));
			});
			
			$app = new \Phalcon\Mvc\Application($di);
			
			$id = uniqid();
			$username = $_POST['username'];
			$password = $app->security->hash($_POST['password']);
			$email = $_POST['email'];
			$created_at = date('Y-m-d H:i:s');
			$last_visit_at = date('Y-m-d H:i:s');
			$last_visit_ip = ip2long($_SERVER['REMOTE_ADDR']);
			
			$sql = "INSERT INTO user (id, username, password, email, created_at, last_visit_at, last_visit_ip) VALUES ('$id', '$username', '$password', '$email', '$created_at', '$last_visit_at', '$last_visit_ip')";
			if($app->db->execute($sql)) {
				echo '<div class="ui positive message">';
				echo '<div class="header">';
				echo '安装完成';
				echo '</div>';
				echo '<a href="/">点击跳转至网站首页</a>';
				echo '</div>';
			} else {
				echo '<div class="ui error message">';
				echo '<div class="header">';
				echo '安装错误';
				echo '</div>';
				echo '<a href="/">请检查管理员信息</a>';
				echo '</div>';
			}
		}
		?>
	</body>
</html>