		    	<div style="position:relative; width:100%; height:559px; overflow:hidden;">
		            <div style="position:absolute; left:50%; margin-left:-951px;">
		                <img src="img/demo/ad_home.jpg" width="1903" />
		            </div>
		        </div>
		    	<div class="w_common main">
		            <div class="mode">
		            	<ul>
		                	<li class="sponsor">
		                    	<h3>助养</h3>
		                        <p>蓝天白云，绿水青山，阳光普照，微风蓝天白云，绿水青山，阳光普照蓝天白云，绿水青山，阳光普照轻享受不到蓝动物享受不享受不到蓝动物享受不享......</p>
		                        <a href="sponsor.html">点击查看 ></a>
		                    </li>
		                    <li class="donate">
		                    	<h3>捐赠</h3>
		                        <p>蓝天白云，绿水青山，阳光普照，微风蓝天白云，绿水青山，阳光普照蓝天白云，绿水青山，阳光普照轻享受不到蓝动物享受不享受不到蓝动物享受不享......</p>
		                        <a href="donate.html">点击查看 ></a>
		                    </li>
		                    <li class="volunteer">
		                    	<h3>志愿者</h3>
		                        <p>蓝天白云，绿水青山，阳光普照，微风蓝天白云，绿水青山，阳光普照蓝天白云，绿水青山，阳光普照轻享受不到蓝动物享受不享受不到蓝动物享受不享......</p>
		                        <a href="volunteer.html">点击查看 ></a>
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
		                
		                <div class="adopt_recommond">
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