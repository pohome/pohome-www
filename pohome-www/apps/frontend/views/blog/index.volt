<div class="w_common main">
        	<div class="f_l blog">
	        	{% for blog in blogs %}
            	<div class="m_30 unit">
                	<h2>{{ blog.title }}</h2>
                    <p class="date">发表时间：{{ blog.published_at }}</p>
                    <div class="blog_desrc">
                    	<p><img src="upload/blog/feature/{{ blog.feature_image }}" width="788" height="503" /></p>
                        <p>{{ blog.abstract }}</p>
                    </div>
                    <a class="more" href="/blog/{{ blog.id }}">查看全文</a>
<!--
                    <div class="social">
                    	标签：<a href="#">流浪求</a><a href="#">爱情</a><a href="#">狗狗</a>
                    </div>
-->
                </div>
                
                {% endfor %}
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
                            <li><a href="\blog\catelog\{{ catelog['id'] }}">{{ catelog['name'] }}({{ catelog['count'] }})</a></li>
                            {% endfor %}
                        </ul>
                    </div>
                </div>
            </div>
            <div class="clear"></div>
    	</div>