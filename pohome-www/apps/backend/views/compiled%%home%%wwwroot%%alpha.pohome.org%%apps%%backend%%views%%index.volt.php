<html>

	<head>
		<meta charset="utf-8">
		
		<link href="/css/semantic.css" rel="stylesheet">
		<link href="/css/backend.css" rel="stylesheet">
		
		<script src="/js/jquery-2.1.1.min.js"></script>
		<script src="/js/semantic.min.js"></script>
		<script src="/js/backend.js"></script>
		
		<title><?php echo $title; ?></title>
	</head>
	
	<body>
		<!-- 顶部导航菜单 -->
		<div class="ui inverted main menu">
			<a href="/" class="item"><i class="home icon"></i>汪汪喵呜孤儿院</a>
		</div>
		
		<div class="ui grid">	
			<!-- 左侧主菜单 -->
			<div class="four wide column">
				<div class="ui vertical menu">
					<div class="item">
						<div class="ui input"><input type="text" placeholder="搜索中..."></div>
					</div>
					<!-- <div class="header item"><i class="github alternate icon"></i>动物</div> -->
					<div class="item">
						<span>汪汪喵呜孤儿院</span>
						<div class="menu">
							<a class="item" href="/admin/pet">全部动物列表</a>
						</div>
						<div class="menu">
							<a class="item" href="/admin/pet">全部动物列表</a>
						</div>
					</div>
					<!-- <div class="header item"><i class="github alternate icon"></i>动物</div> -->
					<div class="item">
						<span>汪汪喵呜孤儿院</span>
						<div class="menu">
							<a class="item" href="/admin/pet">全部动物列表</a>
						</div>
					</div>
				</div>
						
			</div>
			
			<div class="twelve wide column">
				<?php echo $this->getContent(); ?>
			</div>
		</div>
	</body>
</html>