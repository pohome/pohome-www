		<div class="w_common main">
            <div class="m_20 adopt_view">
                <h1>{{ pet.name }}</h1>
                <div class="f_l adopt_view_image">
                    <img src="/upload/image/512/{{ pet.id }}.jpeg" width="312" height="312" />
                </div>
                <div class="f_r adopt_view_info">
                    <p><span>年龄：</span><span>{{ pet.getAge() }}</span></p>
                    <p><span>性别：</span><span>{{ pet.getGender() }}</span></p>
                    <p><span>体型：</span><span>{{ pet.getBodySize() }}</span></p>
                    <p><span>品种：</span><span>{{ pet.breed }}</span></p>
                    <!--<p><span>勋章：</span></p>
                    <div class="medal">
                        <label{% if pet.neutered %} class="active"{% endif %}>绝育</label>
                    </div>-->
                    <p>领养须知：{{ pet.notice }}</p>
                    
                    <div class="social">
                        {% if pet.adoptable %}<a class="btn btn_adopt" href="/adoption/application/{{ pet.id }}">我要领养</a>{% endif %}
                        {% if pped.getTaobaoUrl() is not null %} <a class="btn btn_sponsor" href="{{ pped.getTaobaoUrl() }}">我要助养</a>{% endif %}
                        <!--<a class="btn_digg" href="#">推荐</a>-->
                        <!--<a class="btn_favorite" href="#">收藏</a> -->
                    </div>
                </div>
                <div class="clear"></div>
            </div>
            
            <div class="m_20 common_box help_story">
            	<div class="title">
                	<h3>救助故事</h3>
                </div>
                <div class="content" style="font-size: 1.5em; padding: 30px">
                	{{ pet.story }}
                </div>
            </div>
            
            {% if pp is iterable %}
            <div class="m_20 common_box album">
            	<div class="title">
                	<h3>宠物图集</h3>
                </div>
                <div class="content">
                	<ul>
                    	{% for photo in pp %}
                    	<li class="active">
                        	<img src="{{ photo.getPhotoUrl(512) }}" width="264" />
<!--
                            <div class="info">
                              <h3>我和狗狗的十个约定</h3>
                              <p>帅帅很乖的，我也是很舍不得的但帅是很舍不得的但的但是没有办法我要出国了......</p>
                              <a class="zoom" href="#"></a>
                            </div>
-->
                        </li>
                        {% endfor %}
                    </ul>
                    <div class="clear"></div>
                </div>
            </div>
            {% endif %}
            
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
                                    <a href="/pet/{{ pet.id }}"><img src="/upload/image/256/{{ pet.id }}.jpeg" width="210" height="210" alt="" /></a>
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