<div class="ui segment">
	<form class="ui form" enctype="multipart/form-data" method="post">
		<div class="ui four cards">
			{% for photo in petPhotos %}
			<div class="card">
				<div class="image">
					<img src="/upload/pet/photo/thumbnail/{{ photo.filename }}">
				</div>
				<div class="content" style="text-align: center; padding: 5px">
					<input name="photo_{{ photo.id }}" type="text" value="{{ photo.priority }}" style="width: 2em !important;padding: 0px; text-align: center; vertical-align: middle; font-size: 0.6em; border: none;">
					<input name="delete_photo_{{ photo.id }}" type="checkbox" style="vertical-align: middle; margin: 0 0.5em 0 2em"><label style="vertical-align: middle; font-size: 0.6em">删除</label>
				</div>
			</div>
			{% endfor %}
		</div>
	
		<div class="inline field">
			<label for="avatar">上传新照片</label>
			<input name="avatar[]" type="file" multiple="">
			<input type="submit" class="ui submit orange button" value="保存">
		</div>
	</form>
</div>