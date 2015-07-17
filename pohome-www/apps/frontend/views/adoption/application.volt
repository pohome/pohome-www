<div id="carousel">
    <div style="background-image: url(/image/demo/pet-detail-carousel.jpg);min-height: 400px;"></div>
</div>

<div class="segment">
    <div class="wrap">
        <form class="ui segment form" method="post" id="pet_application_form">
            <a name="error_msg"></a>
        	<div class="ui yellow message">
                <div class="header">领养说明</div>
                <ul class="list">
                    <li>从汪汪喵呜孤儿院领养狗狗或猫咪不需支付任何费用。</li>
                    <li>由于能力有限，我们目前只接受北京地区的领养申请。如果您的居住地不是北京，请咨询您周边的领养机构。</li>
                    <li>您所填写的信息将只用于领养的评估。</li>
                    <li>如果您现在仍是一名学生，请和您的父母或监护人就领养事宜进行充分的沟通。在取得他们的同意后，由您的父母或监护人代为填写领养申请表。</li>
                </ul>
            </div>
            
            <div class="ui error message"></div>
            
        	<div class="ui horizontal divider">个人信息</div>
        	<div class="inline field">
            	<label>姓名</label>
            	<input type="text" name="姓名" />
        	</div>
        	
        	<div class="inline field">
            	<label>年龄</label>
            	<input type="text" name="年龄" />
        	</div>
        	
        	<div class="inline fields">
            	<label for="species">性别</label>
                <div class="box">
                    <div class="field">
                        <div class="ui radio checkbox">
                            <input type="radio" name="性别" value="男">
                            <label>男</label>
                        </div>
                    </div>
                    <div class="field">
                        <div class="ui radio checkbox">
                            <input type="radio" name="性别" value="女">
                            <label>女</label>
                        </div>
                    </div>
                </div>
        	</div>
        	
        	<div class="inline field">
            	<label>Email</label>
            	<input type="text" name="Email" />
        	</div>
        	
        	<div class="inline field">
            	<label>手机号</label>
            	<input type="text" name="手机" />
        	</div>
        	
        	<div class="inline field">
            	<label>常居住在</label>
            	<select class="selection dropdown" name="常居住在">
                    <option value="北京">北京</option>
                    <option value="天津">天津</option>
                    <option value="河北">河北</option>
                    <option value="山西">山西</option>
                    <option value="内蒙古">内蒙古</option>
                    <option value="辽宁">辽宁</option>
                    <option value="吉林">吉林</option>
                    <option value="黑龙江">黑龙江</option>
                    <option value="上海">上海</option>
                    <option value="江苏">江苏</option>
                    <option value="浙江">浙江</option>
                    <option value="安徽">安徽</option>
                    <option value="福建">福建</option>
                    <option value="江西">江西</option>
                    <option value="山东">山东</option>
                    <option value="河南">河南</option>
                    <option value="湖北">湖北</option>
                    <option value="湖南">湖南</option>
                    <option value="广东">广东</option>
                    <option value="广西">广西</option>
                    <option value="海南">海南</option>
                    <option value="重庆">重庆</option>
                    <option value="四川">四川</option>
                    <option value="贵州">贵州</option>
                    <option value="云南">云南</option>
                    <option value="西藏">西藏</option>
                    <option value="陕西">陕西</option>
                    <option value="甘肃">甘肃</option>
                    <option value="青海">青海</option>
                    <option value="宁夏">宁夏</option>
                    <option value="新疆">新疆</option>
                    <option value="香港">香港</option>
                    <option value="澳门">澳门</option>
                    <option value="台湾">台湾</option>
                </select>
        	</div>
        	
        	<div class="inline fields">
            	<label>现居住在</label>
            	<span style="margin-right: 1em">北京市</span>
            	<select class="ui dropdown" name="现居住在">
                    <option value="东城区">东城区</option>
                    <option value="西城区">西城区</option>
                    <option value="朝阳区">朝阳区</option>
                    <option value="丰台区">丰台区</option>
                    <option value="石景山区">石景山区</option>
                    <option value="海淀区">海淀区</option>
                    <option value="门头沟区">门头沟区</option>
                    <option value="房山区">房山区</option>
                    <option value="通州区">通州区</option>
                    <option value="顺义区">顺义区</option>
                    <option value="昌平区">昌平区</option>
                    <option value="大兴区">大兴区</option>
                    <option value="怀柔区">怀柔区</option>
                    <option value="平谷区">平谷区</option>
                    <option value="密云县">密云县</option>
                    <option value="延庆县">延庆县</option>
                </select>
        	</div>
        	
        	{{ formContent }}
        	
        	<input type="submit" class="ui orange button" value="提交申请" style="width: 100%;margin-top: 20px" />
        	
        </form>
    </div>
</div>

<div class="ui small modal">
    <div class="header">领养申请提交成功</div>
    <div class="content">
        <p>我们将在2-5个工作日内完成对您的领养申请的初步评估，并通过Email或电话与您联系，请耐心等待！如果5天后仍未收联系信息，请检查您领养申请表里填写的邮箱的垃圾邮件文件夹。</p>
    </div>
    <div class="actions">
        <div class="ui positive button">确定</div>
    </div>
</div>

<script type="text/javascript">
$(document).ready(function() {
    // 根据申请领养的动物物种来删减表单项
    var species = "{{ pet.species }}";
    if(species == 'C') {
        $('#field_您了解上犬证的相关事宜吗').remove();
    }
    
    $('form').ajaxForm({
        beforeSubmit : function(arr, $form, options) {
            var result = $('.ui.form').form('validate form');

            if(result == true) {
                $('.form').addClass('loading');
            } else {
                scrollTo(0, 640);
            }

            return result;
        },
        success : function(responseText, statusText) {
            $('.form').removeClass('loading');
            
            if(responseText == 'success') {
                $(".ui.modal").modal({
                    onApprove : function() {
                        window.location.href = "http://www.pohome.cn/pet";
                    }
                }).modal("show");
            } else {
                //
                console.log('wrong');
            }
        },
        resetForm : true
    });
    
    $('.ui.form').form({
        fields : {
            name : {
                identifier : '姓名',
                rules : [
                    {
                        type : 'empty', 
                        prompt : '请填写您的姓名'
                    }
                ]
            },
            age : {
                identifier : '年龄',
                rules : [
                    {
                        type : 'empty', 
                        prompt : '请填写您的年龄'
                    },
                    {
                        type : 'integer',
                        prompt : '您输入的年龄格式有误'
                    }
                ]
            },
            gender : {
                identifier : '性别',
                rules : [
                    {
                        type : 'checked', 
                        prompt : '请填写您的性别'
                    }
                ]
            },
            email : {
                identifier : 'Email',
                rules : [
                    {
                        type : 'empty', 
                        prompt : '请填写您的Email地址'
                    },
                    {
                        type : 'email',
                        prompt : '您填写的Email地址格式有误'
                    }
                ]
            },
            mobile : {
                identifier : '手机',
                rules : [
                    {
                        type : 'empty', 
                        prompt : '请填写您的手机号'
                    },
                    {
                        type : 'regExp[/^1[0-9]{10}$/]',
                        prompt : '您输入的手机号格式有误'
                    }
                ]
            },
            marriage : {
                identifier : '婚姻状况',
                rules : [
                    {
                        type : 'checked', 
                        prompt : '请选择您的婚姻状况'
                    }
                ]
            },
            marriage2 : {
                identifier : '您是否了解怀孕期间养宠物的影响',
                rules : [
                    {
                        type : 'checked', 
                        prompt : '请选择您是否了解怀孕期间养宠物的影响'
                    }
                ]
            },
            live_in : {
                identifier : '您目前住房的性质',
                rules : [
                    {
                        type : 'checked', 
                        prompt : '请选择您目前住房的性质'
                    }
                ]
            },
            area : {
                identifier : '住房面积',
                rules : [
                    {
                        type : 'empty', 
                        prompt : '请填写您目前的住房面积'
                    }
                ]
            },
            work : {
                identifier : '您目前',
                rules : [
                    {
                        type : 'checked', 
                        prompt : '请填写您目前的工作状况'
                    }
                ]
            }
        }
    });     
});
</script>