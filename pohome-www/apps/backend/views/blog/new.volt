<div>
	{% if petName is defined %}<a class="ui orange ribbon label">{{ petName }}</a>{% endif %}
	<form class="ui form" enctype="multipart/form-data" method="post">
		{% if petName is defined %}
		<input type="hidden" name="pet_id" value="{{ petId }}">
		{% endif %}
		<!-- 错误信息 -->
		<div class="ui error message">
		</div>
		
		<div class="field">
			<label for="title">标题</label>
			<input name="title" type="text" style="width: 100% !important">
		</div>
		
		<div class="inline field">
			<label for="feature_image">精选图片</label>
			<input name="feature_image" type="file">
		</div>
		
		<div class="field">
			<label for="abstract" style="vertical-align: top; margin-top: 12px">摘要</label>
			<textarea name="abstract"></textarea>
		</div>
		
		<div class="field">
			<label for="content" style="vertical-align: top; margin-top: 12px">正文</label>
			<textarea name="content"></textarea>
		</div>
		
		<div class="inline field">
			<label>博文分类</label>
			<select class="ui dropdown" name="catelog_id">
				{% for key, value in catelogs %}
				<option value="{{ key }}">{{ value }}</option>
				{% endfor %}
			</select>
		</div>
		
		<div class="inline field">
			<label for="published_at">发布时间</label>
			<input name="published_at" type="text" value="{{ date('Y-m-d H:i:s') }}">
		</div>
		
		<div class="inline fields">
			<label for="draft">草稿</label>
			<div class="field">
				<div class="ui radio checkbox">
					<input type="radio" name="draft" value="1">
					<label>是</label>
				</div>
			</div>
			<div class="field">
				<div class="ui radio checkbox">
					<input type="radio" name="draft" value="0" checked="">
					<label>否</label>
				</div>
			</div>
		</div>
		
		<div style="text-align: center">
			<input type="submit" class="ui submit orange button" value="提交">
		</div>
	</form>
</div>

<script type="text/javascript">
$(document).ready(function() {
    $('textarea[name="content"]').redactor({
		lang : 'zh_cn',
		minHeight : 500,
		imageUpload : '/admin/file/upload'
	});
	
	$('#redactor').redactor({
		pastePlainText: true
	});
	
	$('.dropdown').dropdown();
});
</script>