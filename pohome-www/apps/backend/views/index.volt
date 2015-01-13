<html>
	<head>
		<meta charset="utf-8">
		
		<link href="/css/semantic.min.css" rel="stylesheet">
		<link href="/css/style.css" rel="stylesheet">
		<link href="/css/redactor.css" rel="stylesheet">
		<link href="/css/backend.css" rel="stylesheet">
		

		<script src="/js/jquery-2.1.1.min.js"></script>
		<script src="/js/jquery.form.js"></script>
		<script src="/js/semantic.min.js"></script>
		<script src="/js/redactor.min.js"></script>
		<script src="/js/zh_cn.js"></script>
		<script src="/js/backend.js"></script>
		
		<title>{{ title }}</title>
	</head>
	
	<body>
		<!-- 顶部导航菜单 -->
		<header class="ui main menu">
			<a href="/" class="item"><i class="home icon"></i>汪汪喵呜孤儿院</a>
			<div class="right menu">
				<div class="item">
					<!-- <div class="ui transparent input"><input type="text" placeholder="搜索..."></div> -->
					<?php echo $this->session->get('username'); ?>
				</div>
				<div class="item"><a href="admin/auth/logout">退出</a></div>
			</div>
		</header>
		
		<div class="ui grid">	
			<!-- 左侧主菜单 -->
			<div class="four wide column">
				<div class="ui vertical menu">
					<div class="item">
						<i class="home icon"></i>动物
						<div class="menu">
							<a class="item" href="/admin/pet">全部列表</a>
							<a class="item" href="/admin/pet/new">添加新动物</a>
							<!-- <a class="item" href="/admin/pet/donator">长期助养人</a> -->
							<a class="item" href="/admin/pet/statistics">统计</a>
						</div>
					</div>
					
					<div class="item">
						<i class="home icon"></i>领养申请
						<div class="menu">
							<a class="item" href="/admin/adoption/processing"/>待处理领养申请</a>
							<a class="item" href="/admin/adoption/archived"/>已存档领养申请</a>
						</div>
					</div>
					
					<div class="item">
						<i class="home icon"></i>博客
						<div class="menu">
							<a class="item" href="/admin/blog">博文列表</a>
							<a class="item" href="/admin/blog/new">添加新博文</a>
							<a class="item" href="/admin/blog/catelog">编辑博文分类</a>
						</div>
					</div>
					
					<div class="item">
						<i class="home icon"></i>活动
						<div class="menu">
							<a class="item" href="/admin/event">活动列表</a>
							<a class="item" href="/admin/event/new">添加新活动</a>
						</div>
					</div>
					
					<div class="item">
						<i class="home icon"></i>用户
						<div class="menu">
							<a class="item" href="/admin/user/list">用户列表</a>
							<a class="item" href="/admin/user/volunteer">志愿者统计</a>
						</div>
					</div>
					
					<div class="item">
						<i class="home icon"></i>设置
						<div class="menu">
							<a class="item" href="/admin/setting">网站设置</a>
						</div>
					</div>
					
				</div>
						
			</div>
			
			<div class="twelve wide column">
				{{ content() }}
			</div>
		</div>
	</body>
</html>