		<div class="w_common main">
            <div class="m_20 adopt_view">
                <h1>{{ pet.name }}</h1>
                <div class="f_l adopt_view_image">
                    <img src="/upload/pet/avatar/{{ pet.avatar }}" width="312" height="312" />
                </div>
                <div class="f_r adopt_view_info">
                    <p><span>年龄：</span>{{ pet.getAge() }}</p>
                    <p><span>性别：</span>{{ pet.getGender() }}</p>
                    <p><span>体型：</span>中型</p>
                    <p><span>健康状况：</span>{{ pet.ExtraInfo.health }}</p>
                    <p><span>勋章：</span></p>
                    <div class="medal">
                        <label{% if pet.neutered %} class="active"{% endif %}>绝育</label>
                        <label{% if pet.ExtraInfo.angel_id %} class="active"{% endif %}>小天使</label>
                        </div>
                    <p>性格：{{ pet.ExtraInfo.character }}<br />
                    领养须知：{{ pet.ExtraInfo.notice }}</p>
                    
                    <div class="social">
                        <a class="btn btn_adopt" href="#">我要领养</a>
                        <a class="btn btn_sponsor" href="#">我要助养</a>
                        <a class="btn_digg" href="#">推荐</a>
                        <a class="btn_favorite" href="#">收藏</a>
                    </div>
                </div>
                <div class="clear"></div>
            </div>
            
            <div class="m_20 common_box help_story">
            	<div class="title">
                	<h3>救助故事</h3>
                </div>
                <div class="content">
                	<ul>
                    	<li class="active">
                        	<div class="image">
                            	<img src="/img/demo/adopt_09.jpg" width="264" height="167" />
                                <a href="javascript:void(0);"></a>
                                <span>第一天</span>
                            </div>
                            <h3>2014-07-08</h3>
                            <p>帅帅很乖的，我也是很舍不得帅帅很乖的，我也是很舍不得的但帅帅很乖的，我也是很舍不得的但帅是很舍不得的但的但是没有办法我要出国了......</p>
                        </li>
                        <li>
                        	<div class="image">
                            	<img src="/img/demo/adopt_09.jpg" width="264" height="167" />
                                <a href="javascript:void(0);"></a>
                                <span>第一天</span>
                            </div>
                            <h3>2014-07-08</h3>
                            <p>帅帅很乖的，我也是很舍不得帅帅很乖的，我也是很舍不得的但帅帅很乖的，我也是很舍不得的但帅是很舍不得的但的但是没有办法我要出国了......</p>
                        </li>
                        <li>
                        	<div class="image">
                            	<img src="/img/demo/adopt_09.jpg" width="264" height="167" />
                                <a href="javascript:void(0);"></a>
                                <span>第一天</span>
                            </div>
                            <h3>2014-07-08</h3>
                            <p>帅帅很乖的，我也是很舍不得帅帅很乖的，我也是很舍不得的但帅帅很乖的，我也是很舍不得的但帅是很舍不得的但的但是没有办法我要出国了......</p>
                        </li>
                        <li>
                        	<div class="image">
                            	<img src="/img/demo/adopt_09.jpg" width="264" height="167" />
                                <a href="javascript:void(0);"></a>
                                <span>第一天</span>
                            </div>
                            <h3>2014-07-08</h3>
                            <p>帅帅很乖的，我也是很舍不得帅帅很乖的，我也是很舍不得的但帅帅很乖的，我也是很舍不得的但帅是很舍不得的但的但是没有办法我要出国了......</p>
                        </li>
                    </ul>
                    <div class="clear"></div>
                </div>
            </div>
            
            <div class="m_20 common_box album">
            	<div class="title">
                	<h3>宠物图集</h3>
                </div>
                <div class="content">
                	<ul>
                    	<li class="active">
                        	<img src="/img/demo/adopt_09.jpg" width="264" height="167" />
                            <div class="info">
                              <h3>我和狗狗的十个约定</h3>
                              <p>帅帅很乖的，我也是很舍不得的但帅是很舍不得的但的但是没有办法我要出国了......</p>
                              <a class="zoom" href="#"></a>
                            </div>
                        </li>
                        <li class="active">
                        	<img src="/img/demo/adopt_09.jpg" width="264" height="167" />
                            <div class="info">
                              <h3>我和狗狗的十个约定</h3>
                              <p>帅帅很乖的，我也是很舍不得的但帅是很舍不得的但的但是没有办法我要出国了......</p>
                              <a class="zoom" href="#"></a>
                            </div>
                        </li>
                        <li class="active">
                        	<img src="/img/demo/adopt_09.jpg" width="264" height="167" />
                            <div class="info">
                              <h3>我和狗狗的十个约定</h3>
                              <p>帅帅很乖的，我也是很舍不得的但帅是很舍不得的但的但是没有办法我要出国了......</p>
                              <a class="play" href="#"></a>
                            </div>
                        </li>
                        <li class="active">
                        	<img src="/img/demo/adopt_09.jpg" width="264" height="167" />
                            <div class="info">
                              <h3>我和狗狗的十个约定</h3>
                              <p>帅帅很乖的，我也是很舍不得的但帅是很舍不得的但的但是没有办法我要出国了......</p>
                              <a class="zoom" href="#"></a>
                            </div>
                        </li>
                    </ul>
                    <div class="clear"></div>
                    <div class="slide_page">
                    	<a class="prev">前四个</a>
                        <p>第4-8个，共24个</p>
                        <a class="next">后四个</a>
                    </div>
                </div>
            </div>
            
            <div class="m_20 common_box pet_recommend">
            	<div class="title">
                	<h3>宠物推荐</h3>
                </div>
                <div class="content">
                	<div class="pet_recommend_list">
                        <ul>
	                        {% for pet in recommends %}
                            <li class>
                                <div class="pet_image">
                                    <a href="/pet/{{ pet.id }}"><img src="/upload/pet/avatar/thumbnail/{{ pet.avatar }}" width="210" height="210" alt="" /></a>
                                    <a class="more" href="/pet/{{ pet.id }}"></a>
                                </div>
                                <h2>{{ pet.getSpecies() }}名：{{ pet.name }}</h2>
                                <p>性别：{{ pet.getGender() }}   年龄：{{ pet.getAge() }}</p>
                                <a class="btn btn_digg" href="#"></a>
                                <a class="btn btn_favorite" href="#"></a>
                            </li>
                            {% endfor %}
                        </ul>
                    	<div class="clear"></div>
                    </div>
                </div>
            </div>
            
            <div class="clear"></div>
        </div>