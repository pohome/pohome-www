<div class="ui segment">
	<form class="ui form" enctype="multipart/form-data" method="post">
		<!-- 错误信息 -->
		<div class="ui error message">
		</div>
		
		<div class="field">
			<label for="title">标题</label>
			<input name="title" type="text" value="{{ blog.title }}" style="width: 100% !important">
		</div>
		
		<!--
<div class="inline field">
			<label for="feature_image">精选图片</label>
			<div class="feature image">
				<img src="img/blog/feature/{{ blog.feature_image }}">
				<input name="feature_image" type="file">
			</div>
		</div>
-->
		
		<div class="field">
			<label for="abstract" style="vertical-align: top; margin-top: 12px">摘要</label>
			<textarea name="abstract">{{ blog.abstract }}</textarea>
		</div>
		
		<div class="field">
			<label for="content" style="vertical-align: top; margin-top: 12px">正文</label>
			<textarea name="content">{{ blog.content }}</textarea>
		</div>
		
		<div class="inline field">
			<label>博文分类</label>
			<select class="ui dropdown" name="catelog_id">
				{% for key, value in catelogs %}
				<option value="{{ key }}" {% if blog.catelog_id == key %} selected="" {% endif %}>{{ value }}</option>
				{% endfor %}
			</select>
		</div>
		
		<div class="inline field">
			<label for="published_at">发布时间</label>
			<input name="published_at" type="text" value="{{ blog.published_at }}">
		</div>
		
		<div class="inline fields">
			<label for="draft">草稿</label>
			<div class="field">
				<div class="ui radio checkbox">
					<input type="radio" name="draft" value="1" {% if blog.draft == 1 %}checked=""{% endif %}>
					<label>是</label>
				</div>
			</div>
			<div class="field">
				<div class="ui radio checkbox">
					<input type="radio" name="draft" value="0" {% if blog.draft == 0 %}checked=""{% endif %}>
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
	$(function() {
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