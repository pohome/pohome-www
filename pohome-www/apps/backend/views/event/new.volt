<div class="ui segment">
	<form class="ui form" enctype="multipart/form-data" method="post">
		<div class="ui error message">
		</div>
		
		<div class="inline field">
			<label for="title">活动标题</label>
			<input name="title" type="text">
		</div>
		
		<div class="inline field">
			<label for="begin">起始时间</label>
			<input name="begin" type="text">
		</div>
		
		<div class="inline field">
			<label for="end">结束时间</label>
			<input name="end" type="text">
		</div>
		
		<div class="inline field">
			<label for="deadlin">报名截止时间</label>
			<input name="deadline" type="text">
		</div>
		
		<div class="inline field">
			<label for="location">地点</label>
			<input name="location" type="text">
		</div>
		
		<div class="inline field">
			<label for="content" style="vertical-align: top; margin-top: 12px;">正文</label>
			<textarea name="content"></textarea>
		</div>
		
		<div class="inline field">
			<label for="member_limit">人数限制</label>
			<input name="member_limit" type="text">
		</div>
		
		<div class="inline field">
			<label>博文分类</label>
			<select class="ui dropdown" name="catelog">
				{% for catelog in catelogs %}
				<option value="{{ catelog.id }}">{{ catelog.name }}</option>
				{% endfor %}
			</select>
		</div>
		
		<div style="text-align: center">
			<input type="submit" class="ui submit orange button" value="提交">
		</div>
	</form>
</div>

<script type="text/javascript">
	$(function() {
		$('textarea[name="content"]').redactor({
			lang : 'zh_cn',
			minHeight : 500,
			imageUpload : '/admin/blog/upload'
		});
	});
</script>