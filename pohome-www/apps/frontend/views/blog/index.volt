        <div class="w_common main">
        	<div class="f_l blog">
	        	{% for blog in page.items %}
            	<div class="m_30 unit">
                	<h2>{{ blog.title }}</h2>
                    <p class="date">发表时间：{{ blog.published_at }}</p>
                    <div class="blog_desrc">
                    	<img src="/upload/image/256/{{ blog.feature_image }}.jpeg" style="display: inline-block; width: 40%; padding: 0 !important;" />
                        <div style="display: inline-block; width: 50%; margin-left: 20px; vertical-align: top;">
                            {{ blog.abstract }}
                            <div style="margin-top: 1.2em;"><a href="/blog/{{ blog.id }}">查看全文</a></div>
                        </div>
                    </div>
<!--
                    <div class="social">
                    	标签：<a href="#">流浪求</a><a href="#">爱情</a><a href="#">狗狗</a>
                    </div>
-->
                </div>
                {% endfor %}
                <div class="m_30 page_navigation">
                    <a class="prev" href="/blog/p/{{ page.before }}">&lt;</a>
                    <?php
                        $p = $this->view->page;
                        $current = $p->current;
                        
                        $left_max = $current - 1;
                        $right_max = $p->total_pages - $current;
                        
                        if($left_max < 5) {
                            $right_max = 10 - $left_max - 1;
                        } elseif($right_max < 5) {
                            $left_max = 10 - $right_max + 1;
                        } else {
                            $left_max = 4;
                            $right_max = 5;
                        }
                        
                        for($i = 1; $i <= $p->total_pages; $i++)
                        {
                            if($i == $current) {
                                printf('<a class="selected" href="/blog/p/%d">%d</a>', $i, $i);
                            } elseif($i >= $current - $left_max && $i <= $current + $right_max) {
                                printf('<a href="/blog/p/%d">%d</a>', $i, $i);
                            }
                        }
                    ?>
                    <a class="next" href="/blog/p/{{ page.next }}">&gt;</a>
                </div>
        	</div>
            
            <div class="f_r blog_side">
                <div class="m_30 side_box blog_cat">
                    <div class="title"><h3>文章分类</h3></div>
                    <div class="content">
                        <ul>
	                        {% for key, value in catelogs %}
                            <li><a href="\blog\catelog\{{ key }}">{{ value }}</a></li>
                            {% endfor %}
                        </ul>
                    </div>
                </div>
                
            	<div class="m_30 side_box hot_blog">
                    <div class="title"><h3>热点博文</h3></div>
                    <div class="content">
                        <ul>
	                        {% for hotStory in hotStories %}
	                        <a href="/blog/{{ hotStory.id }}">
                            <li>
                                <h2>{{ hotStory.title }}</h2>
                                <img src="/upload/image/256/{{ hotStory.feature_image }}.jpeg" style="width: 100%">
                                <div class="descr">
                                    {{ hotStory.abstract }}
                                </div>
                                <p class="date">发表时间：{{ hotStory.published_at }}</p>
                            </li></a>
                            {% endfor %}
                        </ul>
                    </div>
                </div>
            </div>
            
            <div class="clear"></div>
    	</div>