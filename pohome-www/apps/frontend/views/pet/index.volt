<!--
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
                        	<a href="/pet/{{ hotPet.id }}"><img src="/upload/image/256/{{ hotPet.id }}.jpeg" width="278" height="264" /></a>
                            <div class="descr">
                            	<div class="point"></div>
                            	<a href="/pet/{{ hotPet.id }}" style="color: white">
                            	<h2>{{ hotPet.name }}</h2>
                                <p class="status">领养状态：等待领养</p>
                                <p class="info">
                                年龄：{{ hotPet.getAge() }}<br />
                                性别：{{ hotPet.getGender() }}<br />
                                体型：{{ hotPet.getBodySize() }}<br />
                                </p></a>
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
                        {% for faq in faqs %}
                        <li><a href="/faq/{{ faq.id }}">{{ faq.question }}</a></li>
                        {% endfor %}
                    </ul>
                    
                    <a class="btn btn_adopt" href="#">我要领养</a>
                    <a class="btn btn_sponsor" href="#">我要助养</a>
                </div>
                <div class="clear"></div>
            </div>
        </div>
-->
        <div id="common">
            <div class="w_common main">
                <div class="adopt_search_wrap">
<!--
                	<ul class="tab">
                    	<li class="wait active"><a href="/pet/p/1">等待领养的汪喵</a></li>
                        <li class="success"><a href="/pet/success/p/1">成功被领养汪喵</a></li>
                        <li class="super"><a href="/pet/died/p/1">去世的汪喵</a></li>
                    </ul>
-->
                    <div class="clear"></div>
                    <form class="adopt_condition" method="get" action="/pet/p/1">
                        <div class="adopt_search_row">
                            <span class="label">排序：</span>
                            <label><input type="radio" name="sort_by" value="created_at" {% if sort_by == 'created_at' %}checked=""{% endif %}/> 发布时间</label>
                            <label><input type="radio" name="sort_by" value="viewed" {% if sort_by == 'viewed' %}checked=""{% endif %}/> 人气最高</label>
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
                                <label><input type="radio" name="species" value="ALL" {% if species == 'ALL' %}checked=""{% endif %}/> 全部</label>
                                <label><input type="radio" name="species" value="D" {% if species == 'D' %}checked=""{% endif %}/> 汪星人</label>
                                <label><input type="radio" name="species" value="C" {% if species == 'C' %}checked=""{% endif %}/> 喵星人</label>
                            </div>
                            <div class="separate">
                                <span class="label">性别：</span> 
                                <label><input type="radio" name="gender" value="ALL" {% if gender == 'ALL' %}checked=""{% endif %}/> 全部</label>
                                <label><input type="radio" name="gender" value="M" {% if gender == 'M' %}checked=""{% endif %}/> 男孩</label>
                                <label><input type="radio" name="gender" value="F" {% if gender == 'F' %}checked=""{% endif %}/> 女孩</label>
                            </div>
                            <div class="separate last">
                                <span class="label">体型：</span> 
                                <label><input type="radio" name="size" value="ALL" {% if size == 'ALL' %}checked=""{% endif %}/> 全部</label>
                                <label><input type="radio" name="size" value="L" {% if size == 'L' %}checked=""{% endif %}/> 大型</label>
                                <label><input type="radio" name="size" value="M" {% if size == 'M' %}checked=""{% endif %}/> 中型</label>
                                <label><input type="radio" name="size" value="S" {% if size == 'S' %}checked=""{% endif %}/> 小型</label>
                            </div>
                            <div class="clear"></div>
                        </div>
                                                
                        <div class="adopt_search_row">
                            <input class="ui green button" type="submit" value="筛选" style="padding: 0.75em 1em; width: 8em;border-radius: 5px;border: none; background-color: orange;color: white">
                        </div>
                    </form>
                </div>
                
                <div class="adopt_list_wrap">
                	<div class="adopt_list">
                        <ul>
	                        {% for pet in page.items %}
                            <li>
                                <div class="pet_image">
                                    <a href="/pet/{{ pet.id }}"><img src="/upload/image/256/{{ pet.id }}.jpeg" width="220" height="220" alt="" /></a>
                                    <a class="more" href="/pet/{{ pet.id }}"></a>
                                </div>
                                <h2>{{ pet.getSpecies() }}名：{{ pet.name }}</h2>
                                <p>性别：{{ pet.getGender() }}   年龄：{{ pet.getAge() }}</p>

<!--
                                <a class="btn btn_digg" href="#"></a>
                                <a class="btn btn_favorite" href="#"></a>
-->
                            </li>
                            {% endfor %}
                        </ul>
                        <div class="clear"></div>
                    </div>
                    <div class="m_30 page_navigation">
                        <a class="prev" href="/pet/p/{{ page.before }}{{ query }}">&lt;</a>
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
                                    printf('<a class="selected" href="/pet/p/%d%s">%d</a>', $i, $this->view->query, $i);
                                } elseif($i >= $current - $left_max && $i <= $current + $right_max) {
                                    printf('<a href="/pet/p/%d%s">%d</a>', $i, $this->view->query, $i);
                                }                           
                            }
                        ?>
                        <a class="next" href="/pet/p/{{ page.next }}{{ query }}">&gt;</a>
                    </div>
                </div>
                
                <div class="clear"></div>
            </div>
        </div>