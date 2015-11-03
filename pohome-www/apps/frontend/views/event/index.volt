<div id="carousel"><div style="background-image: url(/image/carousel/event.jpg);"></div></div>

<div class="segment">
    <div class="wrap">
	    
	    <div class="event">
		    <div class="intro">
    		    <div><span class="month">{{ event.getEventMonth() }}</span><span class="slash">/</span><span class="deadline">{{ event.getDeadlineDate() }}</span></div>
    		    <div class="title">{{ event.title }}</div>
    		    <div class="date">时间：{{ event.getEventTime() }}</div>
    		    <div class="location">地点：{{ event.location }}</div>
    		    <div style="margin-top: 20px">
        		    <a class="ui green button">详细介绍</a>
        		    {% if event.passed() == 1 %}
                    <a class="ui gray disabled button">活动结束</a>
        		    {% elseif event.applied(userId) == 1 %}
        		    <a class="ui gray disabled button">已报名</a>
                    {% elseif event.deadlinePassed() == 1 %}
                    <a class="ui gray disabled button">报名截止</a>
                    {% elseif event.isFull() == 1 %}
                    <a class="ui gray disabled button">报名已满</a>
                    {% else %}
                    <a class="ui orange button" id="event_apply_button">报名</a>
                    {% endif %}
    		    </div>
		    </div><div class="divider">
    		    <div class="feature">
        		    <div><img src="image/demo/video-2.jpg"></div>
        		    <div class="intro">{{ event.content }}</div>
        		    <ul>
            		    <li>
                		    <div class="join">
                		        {% if user.hasAvatar() %}
                                <img class="ui avatar image" src="/upload/img/user/avatar/small/{{ userId }}.jpg">
                                {% else %}
                                <img class="ui avatar image" src="/image/user-default-avatar-small.png">
                                {% endif %}
                                <div class="username">Vivien</div>
                            </div>
                        </li>
<!--
            		    
            		    <li><div class="join"><img class="ui avatar image" src="img/demo/avatar.jpg"><div class="username">Vivien</div></div></li>
            		    <li><div class="join"><img class="ui avatar image" src="img/demo/avatar.jpg"><div class="username">Vivien</div></div></li>
            		    <li><div class="join"><img class="ui avatar image" src="img/demo/avatar.jpg"><div class="username">Vivien</div></div></li>
            		    <li><div class="join"><img class="ui avatar image" src="img/demo/avatar.jpg"><div class="username">Vivien</div></div></li>
-->
                		    
        		    </ul>
    		    </div>
    		    <div class="circle">
        		    <div style="width: 20px; height: 8px;background-color: #eee;position: relative;bottom: -18px"></div>
    		    </div>
		    </div>
	    </div>
    </div>
</div>

<div class="ui small modal" id="event_apply_modal">
    <div class="header">活动报名</div>
    <div class="content">
        <form class="ui form" method="post" id="event_apply_form" action="/event/application/{{ event.id }}">
            <div class="inline field">
                <label>手机</label><input type="text" name="mobile"{% if user.mobile is defined %}value="{{ user.mobile }}"{% endif %} />
            </div>
            <div class="inline field">
                <label>人数</label><input type="text" name="number_of_people" />
            </div>
            <div class="inline field">
                <label>出发地</label><input type="text" name="departure_from" />
            </div>
            <div class="inline fields">
                <label>开车</label>
                <div class="field"><input type="radio" name="has_car" value="1" /><label>是</label></div>
                <div class="field"><input type="radio" name="has_car" value="0" /><label>否</label></div>
            </div>
            <div class="inline field">
                <label>备注</label>
                <textarea name="remark"></textarea>
            </div>
        </form>
    </div>
    <div class="actions">
        <div class="ui positive button">提交</div>
        <div class="ui negative button">取消</div>
    </div>
</div>

<div class="ui small modal" id="apply_result_modal">
    <div class="header">报名成功</div>
    <div class="content">
        <p>您的活动报名申请已成功提交，我们随后将和您联系。</p>
    </div>
    <div class="actions">
        <div class="ui positive button">确定</div>
    </div>
</div>

<script type="text/javascript">
    $(document).ready(function() {
        $('#event_apply_button').click(function() {
            var isLogin = "{{ isLogin}}";
            if(isLogin == "false") {
                window.location.href="/user/login";
            } else {
                $('#event_apply_modal').modal({
                    onApprove : function() {
                        $('#event_apply_form').ajaxSubmit({
/*
                            beforeSubmit : function(arr, $form, options) {
                                var result = $('.ui.form').form('validate form');
                    
                                if(result == true) {
                                    $('.form').addClass('loading');
                                }
                    
                                return result;
                            },
*/
                            success : function(responseText, statusText) {
                                $('.form').removeClass('loading');
                                
                                if(responseText == 'success') {
                                    $('#apply_result_modal').modal('show');
                                } else {
                                    console.log(responseText);
                                }
                            },
                            resetForm : true
                        });
                    }
                }).modal('show');
            }
        });
    });
</script>