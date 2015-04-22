<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8" >
		
		<link href="/css/semantic.min.css" rel="stylesheet" type="text/css" />
		
		<script type="text/javascript" src="/js/jquery-2.1.1.min.js"></script>
		<script type="text/javascript" src="/js/semantic.min.js"></script>
		
		<title>建设中……</title>
		
		<style>
/*
    		html {
        		background: url(img/demo/constructing.jpg) no-repeat center center fixed;
        		-webkit-background-size: cover;
                -moz-background-size: cover;
                -o-background-size: cover;
                background-size: cover;
    		}
*/
    		
    		body {
        		width: 924px;
        		margin: 20px auto;
    		}
        </style>
	</head>
	
	<body>
    	<div class="ui accordion">
        	{% for faq in faqs %}
        	<div class="title">
            	<i class="dropdown icon"></i>{{ faq.question }}
        	</div>
        	<div class="content">
            	<p>{{ faq.answer }}</p>
        	</div>
        	{% endfor %}
    	</div>
	</body>
</html>

<script type="text/javascript">
    $(document).ready(function() {
        $('.accordion').accordion({
            selector: {
                trigger: '.title .icon'
            }
        });
    });
</script>