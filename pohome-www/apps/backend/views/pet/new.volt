<div class="ui segment">
	<form class="ui form" enctype="multipart/form-data" method="post">
		<div class="ui yellow message">
			<div class="header">说明</div>
			<ul class="list">
				<li>日期类项目请按照YYYY-MM-DD的格式填写。</li>
				<li>生日项可填写具体的出生日期，也可填写估计的年龄，如3岁，3岁零8个月。</li>
			</ul>
		</div>
		
		<div class="ui error message">
		</div>
		<div class="inline field">
			<label for="name">动物名</label>
			<input name="name" type="text">
		</div>
		
		<div class="inline field">
			<label for="avatar">头像</label>
			<input name="avatar" type="file">
		</div>
		
		<div class="inline fields">
			<label for="species">物种</label>
			<div class="field">
				<div class="ui radio checkbox" id="species-dog">
					<input type="radio" name="species" value="D">
					<label>犬</label>
				</div>
			</div>
			<div class="field">
				<div class="ui radio checkbox" id="species-cat">
					<input type="radio" name="species" value="C">
					<label>猫</label>
				</div>
			</div>

		</div>
		
		<div class="inline fields">
			<label for="gender">性别</label>
			<div class="field">
				<div class="ui radio checkbox">
					<input type="radio" name="gender" value="M">
					<label>雄性</label>
				</div>
			</div>
			<div class="field">
				<div class="ui radio checkbox">
					<input type="radio" name="gender" value="F">
					<label>雌性</label>
				</div>
			</div>
		</div>
		
		<div class="inline field">
			<label for="breed">品种</label>
			<input name="breed" type="text">
		</div>
			
		<div class="inline field">
			<label for="birthday">生日</label>
			<input name="birthday" type="text">
		</div>
		
		<div class="inline fields">
			<label for="body_size">体型</label>
			<div class="field">
				<div class="ui radio checkbox">
					<input type="radio" name="body_size" value="L">
					<label>大型</label>
				</div>
			</div>
			<div class="field">
				<div class="ui radio checkbox">
					<input type="radio" name="body_size" value="M">
					<label>中型</label>
				</div>
			</div>
			
			<div class="field">
				<div class="ui radio checkbox">
					<input type="radio" name="body_size" value="S">
					<label>小型</label>
				</div>
			</div>
		</div>
		
		<div class="inline field">
			<label for="character">性格</label>
			<input name="character" type="text">
		</div>
		
		<div class="inline field">
			<label for="health">健康</label>
			<input name="health" type="text">
		</div>
		
		<div class="inline field">
			<label for="notice">领养须知</label>
			<textarea name="notice"></textarea>
		</div>
		
		<div class="inline fields">
			<label for="neutered">已绝育</label>
			<div class="field">
				<div class="ui radio checkbox">
					<input type="radio" name="neutered" value="1">
					<label>是</label>
				</div>
			</div>
			<div class="field">
				<div class="ui radio checkbox">
					<input type="radio" name="neutered" value="0">
					<label>否</label>
				</div>
			</div>
		</div>
		
		<div class="inline field">
			<label>目前位于</label>
			<select class="ui dropdown" name="location">
				<option value="1">良乡基地</option>
				<option value="2">模拟家庭</option>
			</select>
		</div>
		
		<div class="inline field">
			<label>目前状态</label>
			<select class="ui dropdown" name="status">
				<option value="1">等待领养</option>
				<option value="2">模拟家庭受训</option>
				<option value="3">入院治疗</option>
			</select>
		</div>
		
		<div class="inline field">
			<label for="angel_id">小天使编号</label>
			<input name="angel_id" type="text" placeholder="如果该动物不属于小天使基金请留空">
		</div>
		
		<div class="inline field">
			<label for="entry_date">进入小院的日期</label>
			<input name="entry_date" type="text">
		</div>
		
		<div class="inline fields">
			<label for="adoptable">适合领养</label>
			<div class="field">
				<div class="ui radio checkbox">
					<input type="radio" name="adoptable" value="1" checked="">
					<label>是</label>
				</div>
			</div>
			<div class="field">
				<div class="ui radio checkbox">
					<input type="radio" name="adoptable" value="0">
					<label>否</label>
				</div>
			</div>
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

<div class="ui small modal">
	<div class="header">提示</div>
	<div class="content">添加动物信息成功！</div>
	<div class="actions">
		<div class="ui orange button">确定</div>
	</div>
</div>

<script type="text/javascript">
	$(function() {
		//$(".ui.modal").modal("show");
		
		$('form').ajaxForm({
			success : function(responseText) {
				console.log(responseText);
				$(".ui.modal").modal("show");
			},
			resetForm : true
		});
		
		// 添加生日格式的验证
		$.fn.form.settings.rules.birthday = function(e) {
			var t = /^[0-9]{4}-\d{1,2}-\d{1,2}$/;
			if(t.test(e) == true) return true;
			
			t = /^(\d{1,2})岁$/;
			if(t.test(e) == true) return true;
			
			t = /^(\d{1,2})个月$/;
			if(t.test(e) == true) return true;
			
			t = /^(\d{1,2})岁零(\d{1,2})个月$/;
			if(t.test(e) == true) return true;
			
			return false;
		}
		
		$.fn.form.settings.rules.date = function(e) {
			var t = /^[0-9]{4}-\d{1,2}-\d{1,2}$/;
			return t.test(e);
		}
		
		$('.ui.form').form({
			name : {
				identifier : 'name',
				rules : [{
					type : 'empty',
					prompt : '请输入新增动物的名字'
				}]
			},
			avatar : {
				identifier : 'avatar',
				rules : [{
					type : 'empty',
					prompt : '清选择要上传的动物头像照片'
				}]
			},
			species : {
				identifier : 'species',
				rules : [{
					type : 'checked',
					prompt : '请选择动物的物种'
				}]
			},
			gender : {
				identifier : 'gender',
				rules : [{
					type : 'checked',
					prompt : '请选择动物的性别'
				}]
			},
			breed : {
				identifier : 'breed',
				rules : [{
					type : 'empty',
					prompt : '请输入动物的品种'
				}]
			},
			birthday : {
				identifier : 'birthday',
				rules : [{
					type : 'empty',
					prompt : '请输入动物的生日或年龄'
				}]
			},
			body_size : {
				identifier : 'body_size',
				rules : [{
					type : 'checked',
					prompt : '请选择动物的体型'
				}]
			},
			character : {
				identifier : 'character',
				rules : [{
					type : 'empty',
					prompt : '请填写动物的性格特征'
				}]
			},
			health : {
				identifier : 'health',
				rules : [{
					type : 'empty',
					prompt : '请填写动物的健康状况'
				}]
			},
			neutered : {
				identifier : 'neutered',
				rules : [{
					type : 'checked',
					prompt : '请选择动物的绝育状况'
				}]
			},
			adoptable : {
				identifier : 'adoptable',
				rules : [{
					type : 'empty',
					prompt : '请确认动物是否适合领养'
				}]
			},
			entry_date : {
				identifier : 'entry_date',
				rules : [{
					type : 'empty',
					prompt : '请填写该动物进入小院儿的日期'
				}, {
					type : 'date',
					prompt : '进入小院儿的日期格式错误'
				}]
			},
			birthday : {
				identifier : 'birthday',
				rules : [{
					type : 'birthday',
					prompt : '生日的格式不对'
				}]
			}
		});
		
		$('#species-dog').click(function() {
			$('input[name="breed"]').val('中华田园犬');
		});
		
		$('#species-cat').click(function() {
			$('input[name="breed"]').val('中华土猫');
		});
	});
</script>