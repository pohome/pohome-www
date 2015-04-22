<div class="w_common main">
<!--
	<div class="m_10 position">
        <p><a href="./">首页</a> > <a href="adopt.html">领养平台</a> > <a href="activity.html">活动详情</a></p>
    </div>
-->
    <div class="m_20 activity_content">
        <div class="activity_content_r">
			<div class="f_l activity_form">
            	<div><img src="/img/demo/activity_01.jpg" width="444" height="444" /></div>
                <a class="btn btn_sign_up" href="#">报名参与</a>
<!--
                <div class="f_l activity_model">
                	<p>如果您想参与我们的互动，可以通过以下两种方式参与:</p>
                    <p>1、线上<a href="#">志愿者注册</a>，注明想参与的相关活动，等待我们相关工作人员 组织与通知</p>
                    <p>2、下载<a href="#">志愿者表格</a>，并邮寄活动中相关工作邮箱，静候我们相关工作人组织与安排 。</p>
                    <p>&nbsp;</p>
                    <p>&nbsp;</p>
                    <p>&nbsp;</p>
                    <p>&nbsp;</p>
                    <p>点击进入<a href="#">淘宝售票通道</a>，享受我们的最新优惠。</p>
                </div>
                <div class="f_r manual">
                	<img src="statics/images/demo/activity_02.jpg" width="123" />
                    <h2>活动指导手册</h2>
                    <a class="btn btn_download" href="#">点击下载</a>
                </div>
                <div class="clear"></div>
-->
            </div>
            
            <div class="f_r activity_info">
            	<h1>{{ currentEvent.title }}</h1>
                <p class="m_20 info"><span>活动时间：{{ currentEvent.beginAt() }} 至 {{ currentEvent.endAt() }}</span></p>
                <h3 class="m_10">活动简介：</h3>
                <div class="activity_descr">{{ currentEvent.content }}</div>
                
                <h3>报名截止时间：{{ currentEvent.deadline() }}</h3>
                <h3>活动地点：{{ currentEvent.location }}</h3>
<!--
                <div class="m_20 map">
                	<img src="statics/images/demo/activity_03.jpg" />
                </div>
-->
            </div>
            
            <div class="clear"></div>
        </div>
    </div>
    
<!--
    <div class="m_20 activity_list">
        <div class="title">其他相关活动 <span><a href="#">换一批</a></span></div>
        <ul>
            <li class="ongoing">
                <div class="item">
                    <div class="c">
                        <div class="f_l l_image">
                            <a href="#"><img src="/img/demo/example_join_01.jpg" width="134" height="134" /></a>
                            <a href="#"><img src="/img/demo/example_join_02.jpg" width="134" height="134" /></a>
                        </div>
                        <div class="f_r l_info">
                            <h2>守护宠物行动</h2>
                            <p>世界野生动物日，让我们来一起关爱动物让我们来一起关爱动物让我世界野生动物日，让我们来一起关爱动物让我们来一起关爱动物让我们世界野生动物日我们们来...<a href="#">[详细]</a></p>
                        </div>
                        <div class="clear"></div>
                    </div>
                    <div class="info">
                        <p>参与人数：2687人</p>
                        <p>活动时间：2014-05-30</p>
                        <a class="btn" href="#">正在进行</a>
                    </div>
                </div>
            </li>
            <li class="end">
                <div class="item">
                    <div class="c">
                        <div class="f_l l_image">
                            <a href="#"><img src="/img/demo/example_join_01.jpg" width="134" height="134" /></a>
                            <a href="#"><img src="/img/demo/example_join_02.jpg" width="134" height="134" /></a>
                        </div>
                        <div class="f_r l_info">
                            <h2>守护宠物行动</h2>
                            <p>世界野生动物日，让我们来一起关爱动物让我们来一起关爱动物让我世界野生动物日，让我们来一起关爱动物让我们来一起关爱动物让我们世界野生动物日我们们来...<a href="#">[详细]</a></p>
                        </div>
                        <div class="clear"></div>
                    </div>
                    <div class="info">
                        <p>参与人数：2687人</p>
                        <p>活动时间：2014-05-30</p>
                        <a class="btn" href="#">已结束</a>
                    </div>
                </div>
            </li>
        </ul>
        <div class="clear"></div>
    </div>
-->
</div>