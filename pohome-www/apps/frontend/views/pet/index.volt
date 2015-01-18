		<div class="ad_wrap">
        	<div class="w_common adopt_a">
            	<div class="f_l adopt_recommond_list">
                	<ul>
	                	<?php $blockCount = 1;?>
	                	{% for hotPet in hotPets %}
                    	<li<?php 
	                    	if($blockCount == 3) {
	                    		echo ' class="last"';
	                    		$blockCount = 0;
	                    	}
	                    	$blockCount++;
	                    	?>
	                    >
                        	<a href=""><img src="/upload/pet/avatar/{{ hotPet.avatar }}" width="278" height="264" /></a>
                            <div class="descr">
                            	<div class="point"></div>
                            	<h2>{{ hotPet.name }}</h2>
                                <p class="status">领养状态：等待领养</p>
                                <p class="info">
                                年龄：{{ hotPet.getAge() }}<br />
                                性别：{{ hotPet.getGender() }}<br />
                                调教情况：良好：憋尿  叼球  坐下<br />
                                健康：良好<br />
                                体型：中型<br />
                                </p>
                                <a class="btn btn_digg" href="#"></a>
                                <a class="btn btn_favorite" href="#"></a>
                            </div>
                        </li>
                        {% endfor %}
                    </ul>
                    <div class="clear"></div>
                </div>
                
                <script type="text/javascript">
				jQuery(document).ready(function($) {				
					$(".adopt_recommond_list li").hover(
						function(){
							$(this).find('.descr').fadeIn(500);	
						},
						function(){
							$(this).find('.descr').fadeOut();	
						}
					);
					
					$(".adopt_list li").hover(
						function(){
							$(this).addClass('active');	
						},
						function(){
							$(this).removeClass('active');	
						}
					);
				});		
				</script>
                
                <div class="f_r adopt_faq">
                	<h2>常见问答</h2>
                    <ul>
                        <li><a href="help_view.html">领养宠物具体需要准备哪些东西呢？</a></li>
                        <li><a href="help_view.html">选择汪星人好还是选择喵星人好？</a></li>
                        <li><a href="help_view.html">选择汪星人好还是选择喵星人好？</a></li>
                        <li><a href="help_view.html">选择汪星人好还是选择喵星人好？</a></li>
                        <li><a href="help_view.html">选择汪星人好还是选择喵星人好？</a></li>
                        <li><a href="help_view.html">领养宠物具体需要准备哪些东西呢？</a></li>
                        <li><a href="help_view.html">选择汪星人好还是选择喵星人好？</a></li>
                        <li><a href="help_view.html">选择汪星人好还是选择喵星人好？</a></li>
                        <li><a href="help_view.html">选择汪星人好还是选择喵星人好？</a></li>
                        <li><a href="help_view.html">选择汪星人好还是选择喵星人好？</a></li>
                    </ul>
                    
                    <a class="btn btn_adopt" href="#">我要领养</a>
                    <a class="btn btn_sponsor" href="#">我要助养</a>
                </div>
                <div class="clear"></div>
            </div>
        </div>
        <div id="common">
            <div class="w_common main">
                <div class="adopt_search_wrap">
                	<ul class="tab">
                    	<li class="wait active"><a href="#">等待领养的汪喵</a></li>
                        <li class="success"><a href="#">成功被领养汪喵</a></li>
                        <li class="super"><a href="#">去世的汪喵</a></li>
                    </ul>
                    <div class="clear"></div>
                    <div class="adopt_condition">
                        <div class="adopt_search_row">
                            <span class="label">排序：</span> <span class="s_unit active"><a href="#">发布时间</a></span> <span class="s_unit"><a href="#">人气最高</a></span>
                        </div>
 <!--
                       <div class="adopt_search_row">
                            <span class="label">地区：</span> <select class="select" name="p"><option value="">省份不限</option></select> <select class="select" name="c"><option value="">城市不限</option></select>
							<div class="mini">
                            <input class="input" type="text" name="keyword" value="" /> <input class="btn_submit" type="submit" name="dosubmit" value="搜索" />
                            </div>
                        </div>
-->
                        <div class="adopt_search_row">
                            <div class="separate">
                                <span class="label">类型：</span> 
                                <label><input type="radio" name="type" {% if species == 'ALL' %}checked=""{% endif %}/> 全部</label>
                                <label><input type="radio" name="type" {% if species == 'D' %}checked=""{% endif %}/> 汪汪</label>
                                <label><input type="radio" name="type" {% if species == 'C' %}checked=""{% endif %}/> 喵喵</label>
                            </div>
                            <div class="separate">
                                <span class="label">性别：</span> 
                                <label><input type="radio" name="sex" {% if gender == 'ALL' %}checked=""{% endif %}/> 全部</label>
                                <label><input type="radio" name="sex" {% if gender == 'M' %}checked=""{% endif %}/> 公</label>
                                <label><input type="radio" name="sex" {% if gender == 'F' %}checked=""{% endif %}/> 母</label>
                            </div>
                            <div class="separate last">
                                <span class="label">体型：</span> 
                                <label><input type="radio" name="size" {% if body_size == 'ALL' %}checked=""{% endif %}/> 全部</label>
                                <label><input type="radio" name="size" {% if body_size == 'L' %}checked=""{% endif %}/> 大型</label>
                                <label><input type="radio" name="size" {% if body_size == 'M' %}checked=""{% endif %}/> 中型</label>
                                <label><input type="radio" name="size" {% if body_size == 'S' %}checked=""{% endif %}/> 小型</label>
                            </div>
                            <div class="clear"></div>
                        </div>
                    </div>
                </div>
                
                <div class="adopt_list_wrap">
                	<div class="adopt_list">
                        <ul>
	                        {% for pet in pets %}
                            <li>
                                <div class="pet_image">
                                    <a href="/pet/{{ pet.id }}"><img src="/upload/pet/avatar/{{ pet.avatar }}" width="220" height="220" alt="" /></a>
                                    <a class="more" href="/pet/{{ pet.id }}"></a>
                                </div>
                                <h2>{{ pet.getSpecies() }}名：{{ pet.name }}</h2>
                                <p>性别：{{ pet.getGender() }}   年龄：{{ pet.getAge() }}</p>
                                <p>性格：{{ pet.extraInfo.character }}</p>
                                <a class="btn btn_digg" href="#"></a>
                                <a class="btn btn_favorite" href="#"></a>
                            </li>
                            {% endfor %}
                        </ul>
                        <div class="clear"></div>
                    </div>
                    <div class="m_30 page_navigation">
                        <a class="prev" href="#">&lt;</a>
                        <a href="#">1</a>
                        <a href="#">2</a>
                        <a class="selected" href="#">3</a>
                        <a href="#">4</a>
                        <a href="#">5</a>
                        <a href="#">6</a>
                        <a href="#">7</a>
                        <a href="#">8</a>
                        <a href="#">9</a>
                        <a class="next" href="#">&gt;</a>
                    </div>
                </div>
                
                <div class="clear"></div>
            </div>
        </div>