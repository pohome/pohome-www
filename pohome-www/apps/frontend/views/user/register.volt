    	<div class="w_common main">
        	<div class="m_30 register_tab">
                <ul>
                    <li><a class="active" href="/register">注册</a></li>
                    <li><a href="/forgot">找回密码</a></li>
                </ul>
                <div class="clear"></div>
            </div>
            <div class="register_wrap">
            	<h2>基本信息：</h2>
                <form method="post">
	            	<div class="row">
	                	<span class="label">用户名：</span> <input class="input" type="text" name="username" value="{% if username is defined %}{{ username }}{% endif %}" />
	                	{% if error['空用户名'] is defined %}<font>用户名不能为空</font>{% endif %}
	                	{% if error['用户名已存在'] is defined %}<font>用户名已存在</font>{% endif %}
	                </div>
	                <div class="row">
	                	<span class="label">登录密码：</span> <input class="input" type="password" name="password" value="" />
	                	{% if error['密码为空'] is defined %}<font>密码不能为空</font>{% endif %}
	                	{% if error['密码格式错误'] is defined %}<font>密码由字母与数字组成</font>{% endif %}
	                </div>
	                <div class="row">
	                	<span class="label">确认密码：</span> <input class="input" type="password" name="password_retype" value="" />
	                	{% if error['两次输入的密码不一致'] is defined %}<font>两次输入的密码不一致</font>{% endif %}
	                </div>
	                <div class="row">
	                	<span class="label">邮件邮箱：</span> <input class="input" type="text" name="email" value="{% if email is defined %}{{ email }} {% endif %}" />
	                	{% if error['Email为空'] is defined %}<font>Email地址不能为空</font>{% endif %}
	                	{% if error['Email格式错误'] is defined %}<font>Email地址格式错误</font>{% endif %}
	                	{% if error['Email已存在'] is defined %}<font>Email地址已存在</font>{% endif %}
	                </div>
	                <div class="row">
	                	<span class="label"></span>
	                	<input class="radius_2 btn_submit" type="submit" name="submit" value="注册" />
	                </div>
	                <input type="hidden" name="step" value="0" />
                </form>
                <div class="row">
                	<span class="label"></span>
                	如果需要领养宠物，或者成为我们的志愿者需要填写下一步信息！游客直接完成注册。
                </div>
            </div>
    	</div>