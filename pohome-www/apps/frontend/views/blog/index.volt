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
                            <li>
                                <h2>kimbo 是因为怕陌生人而被弃养</h2>
                                <div class="descr">
                                    北京领养。kimbo 是因为怕陌生人而被弃养，而且主人本来要把他安乐。kimbo 不到一岁。kimbo 还有个问题
                                </div>
                                <p class="date">发表时间：2014-05-29</p>
                            </li>
                            <li>
                                <h2>kimbo 是因为怕陌生人而被弃养</h2>
                                <div class="descr">
                                    北京领养。kimbo 是因为怕陌生人而被弃养，而且主人本来要把他安乐。kimbo 不到一岁。kimbo 还有个问题
                                </div>
                                <p class="date">发表时间：2014-05-29</p>
                            </li>
                            <li>
                                <h2>kimbo 是因为怕陌生人而被弃养</h2>
                                <div class="descr">
                                    北京领养。kimbo 是因为怕陌生人而被弃养，而且主人本来要把他安乐。kimbo 不到一岁。kimbo 还有个问题
                                </div>
                                <p class="date">发表时间：2014-05-29</p>
                            </li>
                            <li>
                                <h2>kimbo 是因为怕陌生人而被弃养</h2>
                                <div class="descr">
                                    北京领养。kimbo 是因为怕陌生人而被弃养，而且主人本来要把他安乐。kimbo 不到一岁。kimbo 还有个问题
                                </div>
                                <p class="date">发表时间：2014-05-29</p>
                            </li>
                            <li class="last">
                                <h2>kimbo 是因为怕陌生人而被弃养</h2>
                                <div class="descr">
                                    北京领养。kimbo 是因为怕陌生人而被弃养，而且主人本来要把他安乐。kimbo 不到一岁。kimbo 还有个问题
                                </div>
                                <p class="date">发表时间：2014-05-29</p>
                            </li>
                        </ul>
                    </div>
                </div>
                
                <div class="m_30 side_box blog_cat">
                    <div class="title"><h3>文章分类</h3></div>
                    <div class="content">
                        <ul>
                            <li><a href="#">领养故事(18)</a></li>
                            <li><a href="#">领养故事(18)</a></li>
                            <li><a class="active" href="#">领养故事(18)</a></li>
                            <li><a href="#">领养故事(18)</a></li>
                            <li><a href="#">领养故事(18)</a></li>
                            <li><a href="#">领养故事(18)</a></li>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="clear"></div>
    	</div>