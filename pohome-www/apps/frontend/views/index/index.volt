		    	<div class="flexslider" style="position:relative; width:100%; height:559px; overflow:hidden;">
    		    	<ul class="slides" style="position:absolute; left:50%; margin-left:-951px;">
        		    	<li style="position:absolute; left:50%; margin-left:-951px;">
        		    	    <img src="img/slider_2.jpg" width="1903" />
        		    	</li>
        		    	<li style="position:absolute; left:50%; margin-left:-951px;">
        		    	    <img src="img/demo/ad_home.jpg" width="1903" />
        		    	</li>
<!-- 		            <div style="position:absolute; left:50%; margin-left:-951px;"> -->
<!-- 		                <img src="img/demo/ad_home.jpg" width="1903" /> -->
                        <img src="img/slider_2.jpg" width="1903" />
		            </ul>
		        </div>
		    	<div class="w_common main">
		            <div class="mode">
		            	<ul>
		                	<li class="sponsor">
		                    	<h3>领养</h3>
		                        <p style="text-align: center">您与它的缘分，从这一刻开始。不需要费用，不需要户口，只需要爱心和责任感。</p>
		                        <a href="http://beta2014.pohome.cn/pet">点击查看 ></a>
		                    </li>
		                    <li class="donate">
		                    	<h3>助养</h3>
		                        <p style="text-align: center">如果您暂时无法给予它们一个家，可以通过捐赠助养费，帮助我们为等待领养的猫咪和狗狗营造一个干净、安全和温暖的领养中心。</p>
		                        <a href="http://pohome.taobao.com/category-156624852.htm?spm=a1z10.5-c.w4010-649933536.8.J3I7X6&search=y&catName=%C3%BF%D4%C2%D6%FA%D1%F8%B7%D1%C4%BC%BE%E8#bd">点击查看 ></a>
		                    </li>
		                    <li class="volunteer">
		                    	<h3>志愿者</h3>
		                        <p style="text-align: center">如果您精力旺盛又乐于帮助这些弱小脆弱的生命，加入我们吧，我们需要各种各样的义工服务！</p>
		                        <a href="https://pohome.wufoo.com/forms/ece/">点击查看 ></a>
		                    </li>
		                </ul>
		                <div class="clear"></div>
		            </div>
		            
		            <div class="m_30 row">
		            	<div class="f_l box index_blog">
		                	<div class="title"><h3>最新博客</h3> <span class="more"><a href="\blog">■ more</a></span></div>
		                    <div class="content">
		                    	<ul>
			                    	{% for blog in blogs %}
		                        	<li>
		                            	<div class="l_image"><a href="/blog/{{ blog.id }}"><img src="/upload/image/512/{{ blog.feature_image }}.jpeg" width="265" /></a></div>
		                                <div class="l_info">
		                                	<h2><a href="/blog/{{ blog.id }}">{{ blog.title}}</a></h2>
		                                    <p class="descr"><?php echo mb_substr(strip_tags($blog->content) , 0, 130) . '...';?></p>
		                                    <!-- <p class="tag">标签：<a>流浪求</a><a>爱情</a><a>狗狗</a> </p> -->
		                                </div>
		                                <div class="clear"></div>
		                            </li>
		                            {% endfor %}
		                        </ul>
		                    </div>
		                </div>
		                
		                <div class="f_r box index_story">
		                	<div class="title"><h3>领养故事</h3> <span class="more"><a href="\blog\catelog\3">■ more</a></span></div>
		                    <div class="content">
		                    	<img src="/upload/image/512/{{ adoptionStory.feature_image }}.jpeg" width="353"/>
		                    	<span class="date">{{ adoptionStory.title }}</span>
		                    	<p class="descr"><?php echo mb_substr(strip_tags($adoptionStory->content) , 0, 130) . '...';?><a href="\blog\{{ adoptionStory.id }}">[详细]</a></p>
		                    </div>
		                </div>
		                <div class="clear"></div>
		                
		                <div class="adopt_recommond" style="margin-top: 40px">
    		            	<div class="title"><h3>领养推荐</h3> <!-- <span class="num">23new</span> --> <span class="more"><a href="/pet">■ more</a></span></div>
    		                <div class="content">
    		                	<ul>
    			                	{% for pet in pets %}
    		                    	<li>
    		                        	<div class="pet_image">
    		                            	<a href="/pet/{{ pet.id }}"><img src="/upload/image/256/{{ pet.id }}.jpeg" width="210" height="210" /></a>
    		                                <a href="/pet/{{ pet.id }}" class="view"></a>
    		                            </div>
    		                            <a href="/pet/{{ pet.id }}" class="pet_name">{{ pet.name }}</a>
    		                        </li>
    		                        {% endfor %}
    		                    </ul>
    		                    <div class="clear"></div>
    		                </div>
    		            </div>
		            </div>
		            <div class="clear"></div>
		    	</div>
		    	
<script type="text/javascript">
$(document).ready(function() {
    $('.flexslider').flexslider({
		animation : 'fade',
		animationSpeed : 1500,
		slideshowSpeed : 5000,
		controlNav : false,
		directionNav : false
	});
});
</script>