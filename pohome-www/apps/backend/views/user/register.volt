<div class="ui segment">
	<form class="ui form" method="post">
		<div class="inline field">
			<label>用户名</label>
			<input  type="text" name="username">
		</div>
		<div class="inline field">
			<label>初始密码</label>
			<input type="password" name="password">
		</div>
		<div class="inline field">
			<label>Email</label>
			<input type="text" name="email">
		</div>
		<div class="inline fields">
    		<label>用户类型</label>
    		<div class="field">
    		    <div class="ui radio checkbox">
        		    <input type="radio" name="user_type" value="individual" checked="checked" />
        		    <label>个人</label>
    		    </div>
    		</div>
    		<div class="field">
        		<div class="ui radio checkbox">
                    <input type="radio" name="user_type" value="group" />
                    <label>团体</label>
        		</div>
    		</div>
		</div>
		<input class="ui orange button" type="submit" value="保存">
	</form>
</div>