		<div class="w_common main">
        	<div class="f_l blog">
            	<div class="m_30 unit">
                	<h2>{{ blog.title }}</h2>
                    <p class="date">发表时间：{{ blog.published_at }}</p>
                    <div class="blog_desrc">
                    	{{ blog.content }}
                    </div>
 <!--
                   <div class="social">
                    	标签：<a href="#">流浪求</a><a href="#">爱情</a><a href="#">狗狗</a>
                    </div>
-->
                    
                    <div class="m_30 related_blog">
                    	<div class="radius_2 title">相关的文章推荐</div>
                    	<ul>
                        	<li class="f_l">
                            	<div class="f_l image"><img src="/img/demo/blog_02.jpg" width="183" height="116" /></div>
                                <div class="f_r info">
                                	<h2>有一只流浪狗等你领养</h2>
                                    <div class="descr">
                                    	我看着陌生的人或风景，我总是想着，他们一定都曾有自己的故事狗狗的内心是很脆弱的...
                                    </div>
                                </div>
                                <div class="clear"></div>
                            </li>
                            <li class="f_r">
                            	<div class="f_l image"><img src="/img/demo/blog_02.jpg" width="183" height="116" /></div>
                                <div class="f_r info">
                                	<h2>有一只流浪狗等你领养</h2>
                                    <div class="descr">
                                    	我看着陌生的人或风景，我总是想着，他们一定都曾有自己的故事狗狗的内心是很脆弱的...
                                    </div>
                                </div>
                                <div class="clear"></div>
                            </li>
                        </ul>
                        <div class="clear"></div>
                    </div>
                </div>
            </div>
            
            <div class="f_r blog_side">
            	<div class="m_30 side_box hot_blog">
                    <div class="title"><h3>热点博文</h3></div>
                    <div class="content">
                        <ul>
	                        {% for hotStory in hotStories %}
	                        <a href="/blog/{{ hotStory.id }}">
                            <li>
                                <h2>{{ hotStory.title }}</h2>
                                <div class="descr">
                                    {{ hotStory.abstract }}
                                </div>
                                <p class="date">发表时间：{{ hotStory.published_at }}</p>
                            </li></a>
                            {% endfor %}
                        </ul>
                    </div>
                </div>
                
                <div class="m_30 side_box blog_cat">
                    <div class="title"><h3>文章分类</h3></div>
                    <div class="content">
                        <ul>
	                        {% for catelog in catelogs %}
                            <li><a href="\blog\catelog\{{ catelog.id }}">{{ catelog.name }}({{ catelog.countBlog() }})</a></li>
                            {% endfor %}
                        </ul>
                    </div>
                </div>
            </div>
            <div class="clear"></div>
    	</div>