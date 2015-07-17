<div id="carousel"><div style="background-image: url(/image/carousel/blog.jpg);"></div></div>

<!--
<div id="blog-catelog">
	<ul>
    	<li><a href="/blog/catelog/1"><img src="/image/catelog-adoption-story.png"></a></li><li><img src="/image/catelog-knowledge-base.png"></li><li><img src="/image/catelog-rescue-story.png"></li><li><img src="/image/catelog-professor.png"></li><li><img src="/image/catelog-little-angel-fund.png"></li><li><img src="/image/catelog-news.png"></li><li><img src="/image/catelog-volunteer.png"></li><li><img src="/image/catelog-unclassified.png"></li>
	</ul>
    	
</div>
-->

<div class="segment">
    <div class="wrap">
        <a name="blog-list"></a>
        {% for blog in page.items %}
        <div class="blog">
		    <img src="/upload/image/256/{{ blog.feature_image }}.jpeg">
		    <div class="content">
    		    <div class="main">
        		    <div class="title">{{ blog.title }}</div>
        		    <div class="abstract">
            		    <p>{{ blog.abstract }}</p>
        		    </div>
        		    <div class="fadeout" style=""></div>
    		    </div>
    		    <div class="readall">
        		    <a href="/blog/{{ blog.id }}"><div class="mini ui green button">阅读全文</div></a>
    		    </div>
		    </div>
        </div>
        {% endfor %}
        
        <div class="paginator">
    	    <div class="ui pagination menu">
                <a class="icon item" href="/blog/p/{{ page.before }}#blog-list"><i class="left arrow icon"></i></a>
                <?php
                    $current = $this->view->page->current;
                    $total = $this->view->page->total_pages;
                    
                    for($i = 1; $i <= $total; $i++)
                    {
                        if($current != $i) {
                            echo '<a class="item" href="/blog/p/' . $i . '#blog-list">' . $i . '</a>';
                        } else {
                            echo '<a class="active item" href="/blog/p/' . $i . '#blog-list">' . $i . '</a>';
                        }
                    }
                ?>
                <a class="icon item" href="/blog/p/{{ page.next }}#blog-list"><i class="right arrow icon"></i></a>
            </div>
	    </div>
    </div>
</div>