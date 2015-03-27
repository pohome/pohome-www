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
                    <input type="radio" name="size" value="L">
                    <label>大型</label>
                </div>
            </div>
            <div class="field">
                <div class="ui radio checkbox">
                    <input type="radio" name="size" value="M">
                    <label>中型</label>
                </div>
            </div>
            
            <div class="field">
                <div class="ui radio checkbox">
                    <input type="radio" name="size" value="S">
                    <label>小型</label>
                </div>
            </div>
        </div>
        
        <div class="inline field">
            <label>亲人指数</label>
            <div class="ui star rating" id="friendly_index_rating"></div>
        </div>
        
        <div class="inline field">
            <label>能量指数</label>
            <div class="ui star rating" id="energy_index_rating"></div>
        </div>
        
        <div class="inline field">
            <label>适应指数</label>
            <div class="ui star rating" id="adaptability_index_rating"></div>
        </div>
                
        <div class="inline field">
            <label for="notice">领养须知</label>
            <textarea name="notice" placeholder="字数不超过400"></textarea>
        </div>
        
        <div class="field">
			<label for="story" style="vertical-align: top; margin-top: 12px">故事</label>
			<textarea name="story"></textarea>
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
            <select class="ui dropdown" name="location_id">
                {% for value, name in location %}
                <option value="{{ value }}">{{ name }}</option>
                {% endfor %}
            </select>
        </div>
        
        <div class="inline field">
            <label>目前状态</label>
            <select class="ui dropdown" name="status_id">
                {% for value, name in status  %}
                <option value="{{ value }}">{{ name }}</option>
                {% endfor %}
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
            <label for="belongs_to_pohome">属于汪汪喵呜</label>
            <div class="field">
                <div class="ui radio checkbox">
                    <input type="radio" name="belongs_to_pohome" value="1" checked="">
                    <label>是</label>
                </div>
            </div>
            <div class="field">
                <div class="ui radio checkbox">
                    <input type="radio" name="belongs_to_pohome" value="0">
                    <label>否</label>
                </div>
            </div>
        </div>
        
        <div class="inline field">
            <label for="taobao_url">淘宝链接</label>
            <input name="taobao_url" type="text">
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
        
        <input type="hidden" name="friendly_index" id="friendly_index_field" value="1">
        <input type="hidden" name="energy_index" id="energy_index_field" value="1">
        <input type="hidden" name="adaptability_index" id="adaptability_index_field" value="1">
        
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
        
        $('textarea[name="story"]').redactor({
			lang : 'zh_cn',
			minHeight : 500,
			imageUpload : '/admin/file/upload'
		});
		
		$('#redactor').redactor({
    		pastePlainText: true
		});
        
        $('form').ajaxForm({
            success : function(responseText) {
                console.log(responseText);
                $(".ui.modal").modal("show");
            },
            resetForm : false
        });
        
        $('.rating').rating({
            maxRating: 5
        });
        
        $('#friendly_index_rating').rating('setting', 'onRate', function(value) {
            $('#friendly_index_field').val(value);
        });
        
        $('#energy_index_rating').rating('setting', 'onRate', function(value) {
            $('#energy_index_field').val(value);
        });
        
        $('#adaptability_index_rating').rating('setting', 'onRate', function(value) {
            $('#adaptability_index_field').val(value);
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