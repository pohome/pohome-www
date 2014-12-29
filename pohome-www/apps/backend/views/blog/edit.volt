<div class="ui segment">
	<form class="ui form" enctype="multipart/form-data" method="post">
		<!-- 错误信息 -->
		<div class="ui error message">
		</div>
		
		<div class="inline field">
			<label for="title">标题</label>
			<input name="title" type="text" style="width: 50em !important" value="{{ blog.title }}">
		</div>
		
		<!--
<div class="inline field">
			<label for="feature_image">精选图片</label>
			<div class="feature image">
				<img src="img/blog/feature/{{ blog.feature_image }}">
				<input name="feature_imsage" type="file">
			</div>
		</div>
-->
		
		<div class="inline field">
			<label for="abstract" style="vertical-align: top; margin-top: 12px">摘要</label>
			<textarea name="abstract" style="width: 50em !important">{{ blog.abstract }}</textarea>
		</div>
		
		<div class="inline field">
			<label for="content" style="vertical-align: top; margin-top: 12px">正文</label>
			<textarea name="content" style="width: 48em !important">{{ blog.content }}</textarea>
		</div>
		
		<div class="inline field">
			<label>博文分类</label>
			<select class="ui dropdown" name="catelog">
				<option value="1" {% if blog.catelog_id == 1 %}}checked=""{% endif %}>活动汇报</option>
				<option value="2" {% if blog.catelog_id == 2 %}}checked=""{% endif %}>救助故事</option>
				<option value="3" {% if blog.catelog_id == 3 %}}checked=""{% endif %}>知识库</option>
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
			imageUpload : '/admin/blog/upload'
		});
	});
</script>