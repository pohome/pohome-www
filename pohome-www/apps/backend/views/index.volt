<html>
	<head>
		<meta charset="utf-8">
		
		<link href="/css/semantic.min.css" rel="stylesheet">
		<link href="/css/redactor.css" rel="stylesheet">
		<link href="/css/backend.css" rel="stylesheet">
		

		<script src="/js/jquery-2.1.4.min.js"></script>
		<script src="/js/jquery.form.js"></script>
		<script src="/js/semantic.js"></script>
		<script src="/js/redactor.js"></script>
		<script src="/js/zh_cn.js"></script>
		<script src="/js/backend.js"></script>
		
		<style type="text/css">
    		    
        	#logo {
        		width: 200px;
        	}
    
        	.ui.inverted.vertical.menu {
        		width: 200px;
        		height: 100%;
        		position: fixed;
        		top: 0;
        		left: 0;
        		border-radius: 0;
        	}
    
        	#main {
        		width: auto;
        		margin-left: 200px;
        		position: relative;
        		overflow: auto;
        	}
        	
        	#top_menu {
            	border-radius: 0;
        	}
        	
        	#container {
            	margin: 20px;
            	padding: 20px;
            	background: white;
        	}
        	
        	.ui.breadcrumb {
            	margin: 0 20px;
        	}
        	
        	.ui.form {
            	width: 60%;
        	}
        	
        	.inline.field label {
            	width: 8em !important;
        	}
        	
        	.inline.fields>label {
            	width: 8em !important;
        	}
        	
        	.inline.field textarea {
            	display: inline-block !important;
            	width: 32em
        	}
        	
        	.inline.field input[type='text'] {
            	width: 20em !important;
        	}
        	
        	.ui.dropdown {
            	width: 20em !important;
        	}
        	
        	.ui.button {
            	margin: 10px 0px;
        	}
    	</style>
		
		<title>{{ title }}</title>
	</head>
	
	<body>
    	<nav class="ui inverted vertical menu">
    		<a href="/"><img src="/img/backend/logo.png" id="logo"></a>
    		<a class="item" href="/admin/pet/index">动物</a>
    		<a class="item" href="/admin/adoption/index">领养申请</a>
    		<a class="item" href="/admin/blog/index">博客</a>
    		<div class="item">
        		活动
        		<div class="menu">
            		<a class="item" href="/admin/event/index">活动列表</a>
            		<a class="item" href="/admin/event/audition">活动报名审核</a>
        		</div>
    		</div>
    		<a class="item" href="/admin/user/index">用户</a>
    		<a class="item" href="/admin/faq/index">常见问题</a>
    		<div class="item">设置
    			<div class="menu">
    				<a class="item" href="">全局</a>
    				<a class="item" href="">博客</a>
    			</div>
    		</div>
    	</nav>
    	<div id="main">
    		<div class="ui menu" id="top_menu">
    			<div class="item">
        			<div class="ui transparent icon input">
            			<input type="text" placeholder="搜索...">
            			<i class="search link icon"></i>
        			</div>
    			</div>
    			<div class="right menu">
        			<a class="item"><i class="inbox icon"></i></a>
    				<a class="item"><?php echo $this->session->get('username'); ?></a>
    				<a class="item" href="/admin/user/logout"><i class="sign out icon"></i></a>
    			</div>
    		</div>
    		
    		<div class="ui breadcrumb">
                <a class="section" href="/admin/index/index">首页</a>
                <div class="divider"> / </div>
                {% for item in breadcrumb %}
                    {% if item['active'] is defined %}
                    <div class="active section">{{ item['name'] }}</div>
                    {% else %}
                    <a class="section" href="{{ item['link'] }}">{{ item['name'] }}</a>
                    <div class="divider"> / </div>
                    {% endif %}
                {% endfor %}
            </div>
                
            <div id="container">
        		{{ content() }}
            </div>
    	</div>
	</body>
</html>