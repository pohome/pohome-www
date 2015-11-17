<div id="carousel"><div></div></div>

<div id="main">
    <div class="wrap">
	    <div id="videos">
		    <div class="main-video" style="border-top: #f1c749 solid 15px">
    		    <a href="/pet"><img src="image/carousel/pet-small.jpg">
<!--     		    <img src="image/m_play.png" class="play"> --></a>
    		    <div class="desc">
        		    <h3>领养</h3>
        		    <h4>ADOPTION</h4>
    		    </div>
<!--     		    <div class="stat">已有4502人参与</div> -->
		    </div><div class="main-video" style="border-top: #8fd462 solid 15px">
    		    <a href="http://wd.koudai.com/?userid=165412960"><img src="image/carousel/donate-small.jpg">
<!--     		    <img src="image/m_play.png" class="play"> --></a>
    		    <div class="desc">
        		    <h3>捐赠</h3>
        		    <h4>DONATION</h4>
    		    </div>
<!--     		    <div class="stat">已有268人参与</div> -->
		    </div><div class="main-video" style="border-top: #4d9fd3 solid 15px">
    		    <a href="/event"><img src="image/carousel/event-small.jpg">
<!--     		    <img src="image/m_play.png" class="play"> --></a>
    		    <div class="desc">
        		    <h3>志愿者</h3>
        		    <h4>VOLUNTEER</h4>
    		    </div>
<!--     		    <div class="stat">已有84032人参与</div> -->
		    </div>   
	    </div>
    </div>
    
    <div class="segment">
	    <div class="wrap">
		    <div class="title green">领养故事</div>
		    <div class="story">
    		    <div style="width: 360px;text-align: center; margin-right: 2em; display: inline-block"><img src="/upload/img/blog/feature/{{ adoptionStory.id }}.jpeg" style="max-width: 360px; max-height: 240px;"></div><div class="content">
        		    <div class="title">{{ adoptionStory.title }}</div>
        		    {{ adoptionStory.abstract }}
                    <div class="readall">
            		    <a href="/blog/{{ adoptionStory.id }}"><div class="mini ui green button">阅读全文</div></a>
        		    </div>
    		    </div>
    		    <div style="clear: both"></div>
		    </div>
	    </div>
    </div>
    
    <div class="segment">
	    <div class="wrap">
		    <div class="title green">领养推荐</div>
		    <div>
    		    {% for pet in pets %}<div class="pet">
        		    <div class="ui fluid image">
            		    {% if pet.status_id == 6 %}
            		    <a class="ui red ribbon label">已领养</a>
            		    {% endif %}
            		    {% if pet.status_id == 9 %}
            		    <a class="ui green ribbon label">已预订</a>
            		    {% endif %}
                        <img src="upload/img/pet/avatar/small/{{ pet.id }}.jpeg">
        		    </div>
        		    <div class="info">
            		    <div class="name">{{ pet.name }}</div>
            		    <div class="extra"><span>{{ pet.getAge() }}</span><span> {{ pet.getGender() }}</span><span> {{ pet.breed }}</span></div>
        		    </div><div class="actions">
            		    <a href="/pet/{{ pet.id }}"><div class="ui tiny green button">详情</div></a>
                        {% if pet.taobao_url > 0 %}<a href="{{ pet.getTaobaoUrl() }}" target="_blank"><div class="ui tiny orange button">助养</div></a>{% endif %}
        		    </div>
    		    </div>{% endfor %}
		    </div>
	    </div>
    </div>
    
    <div class="segment background green">
	    <div class="wrap">
		    <div class="title white">最新博文</div>
		    {% for blog in blogs %}
		    <div class="blog">
    		    <img src="/upload/img/blog/feature/{{ blog.id }}.jpeg">
    		    <div class="content">
        		    <div class="main">
            		    <div class="title">{{ blog.title }}</div>
            		    <div class="abstract">
                		    {{ blog.abstract }}
            		    </div>
            		    <div class="fadeout" style=""></div>
        		    </div>
        		    <div class="readall">
            		    <a href="/blog/{{ blog.id }}"><div class="mini ui green button">阅读全文</div></a>
        		    </div>
    		    </div>
            </div>
            {% endfor %}
	    </div>
    </div>
    
    <div class="segment" style="height: 300px;background-image: url(/image/partner-background.jpg);background-repeat: no-repeat;background-size: cover;background-position-x: center">
    </div>
    
    <div class="segment">
        <div class="wrap">
            <div class="title">合作伙伴</div>
            <div id="partner">
                <div><img src="/image/partner/sunshine-farm.png" /></div>
                <div><img src="/image/partner/cfx.png" /></div>
                <div><img src="/image/partner/xjgy.png" /></div>
                <div><img src="/image/partner/mzys.png" /></div>
                <div><img src="/image/partner/jdl.png" /></div>
                <div><img src="/image/partner/tajijin.png" /></div>
                <div><img src="/image/partner/GHP.png" /></div>
                <div><img src="/image/partner/lush.png" /></div>
                <div><img src="/image/partner/sugar_shack.png" /></div>
                <div><img src="/image/partner/cwp.jpg" /></div>
                <div><img src="/image/partner/qingcloud.png" /></div>
                <div><img src="/image/partner/zimutech.png" /></div>
                <div><img src="/image/partner/ifaw.jpg" /></div>
                <div><img src="/image/partner/aaf.png" /></div>
                <div><img src="/image/partner/hk-spca.png" /></div>
                <div><img src="/image/partner/mars.png" /></div>
                <div><img src="/image/partner/helpu.png" /></div>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
    $('document').ready(function() {
        $("#carousel div").bgswitcher({
            images: ["/image/carousel/yingjiajun.jpg", "/image/carousel/pet.jpg", "/image/carousel/event.jpg", "/image/carousel/donate.jpg"],
            interval: 6000,
            duration: 1500
        });
        
        $('#carousel').click(function() {
            var img = $(this).find('div').css('background-image');
            console.log(img);
            switch(img) {
                case 'url(http://www.pohome.cn/image/carousel/yingjiajun.jpg)':
                case 'url("http://www.pohome.cn/image/carousel/yingjiajun.jpg")':
                    window.location.href = '/topic/ying-jia-jun';
                    break;
                    
                case 'url(http://www.pohome.cn/image/carousel/pet.jpg)':
                case 'url("http://www.pohome.cn/image/carousel/pet.jpg")':
                    window.location.href = '/pet';
                    break;
                    
                case 'url(http://www.pohome.cn/image/carousel/event.jpg)':
                case 'url("http://www.pohome.cn/image/carousel/event.jpg")':
                    window.location.href = '/event';
                    break;
                    
                case 'url(http://www.pohome.cn/image/carousel/donate.jpg)':
                case 'url("http://www.pohome.cn/image/carousel/donate.jpg")':
                    window.location.href = 'http://wd.koudai.com/?userid=165412960';
                    break;
                
            }
            
        });
    })
    
</script>