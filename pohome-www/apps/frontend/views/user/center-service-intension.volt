<div id="carousel">
    <div style="background-image: url(/image/carousel/individual-center.jpg);min-height: 450px;"></div>
</div>

<div class="segment">
    <div class="wrap" style="background-color: #fff; padding: 40px;">
        <div class="ui grid">
            <div class="four wide column">
                <div class="ui vertical fluid menu">
                    <a class="item" href="/user/center">基本信息</a>
                    <a class="item" href="/user/center/edit">编辑基本信息</a>
<!--                     <a class="item" href="/user/center/favorite-pet">关注的动物</a> -->
<!--
                    <a class="item" href="/user/center/service-record">义工服务记录</a>
                    <a class="item" href="/user/center/adoption-record">领养申请记录</a>
-->
                    <a class="active item" href="/user/center/service-intension">志愿者服务意向</a>
<!--                     <a class="item" href="/user/center/change-password">修改密码</a> -->
                </div>
            </div>
            <div class="twelve wide column usercenter">
                <form class="ui form" method="post">
                    <div class="inline field">
                        <label>姓名</label><input type="text" name="realname"{% if user.extra.realname is defined %}value="{{ user.extra.realname }}"{% endif %} />
                    </div>
                    <div class="inline fields">
                        <label>性别</label>
                        <div class="field"><input type="radio" name="gender" value="M"{% if user.extra.gender is defined%}{% if user.extra.gender == 'M' %} checked=""{% endif %}{% endif %} /><label>男</label></div>
                        <div class="field"><input type="radio" name="gender" value="F"{% if user.extra.gender is defined%}{% if user.extra.gender == 'F' %} checked=""{% endif %}{% endif %} /><label>女</label></div>
                    </div>
                    <div class="inline field">
                        <label>年龄</label><input type="text" name="age" {% if user.extra.birthday is defined %}value="{{ user.extra.getAge() }}"{% endif %}/>                        
                    </div>
                    <div class="inline field">
                        <label>Email</label><input type="email" name="email" value="{{ user.email }}"/>
                    </div>
                    <div class="inline field">
                        <label>手机</label><input type="text" name="mobile"{% if user.mobile is defined %}value="{{ user.mobile }}"{% endif %} />
                    </div>
                    <div class="inline fields" style="-webkit-align-items: flex-start;">
                        <label>服务意愿</label>
                        <div class="box">
                            {% for key, value in sit %}
                            <div class="field">
                                <input type="checkbox" name="intension[]" value="{{ key }}" {% if user.hasIntension(key) %}checked="checked"{% endif %} />
                                <label>{{ value }}</label>
                            </div>
                            {% endfor %}
                        </div>
                    </div>
                    <div class="inline field">
                        <label>补充说明</label>
                        <textarea name="remark"></textarea>
                    </div>
                    <div><input type="submit" class="ui green button" value="保存" /></div>
                </form>
            </div>
        </div>
    </div>
</div>

<div class="ui small modal" id="success_modal">
    <div class="header">志愿服务意向更新成功</div>
    <div class="content">
        <p>您的新志愿服务意向已经保存</p>
    </div>
    <div class="actions">
        <div class="ui positive button">确定</div>
    </div>
</div>

<div class="ui small modal" id="failed_modal">
    <div class="header">志愿服务意向更新失败</div>
    <div class="content">
        <p>保存志愿服务意向失败，请稍后重试。</p>
    </div>
    <div class="actions">
        <div class="ui positive button">确定</div>
    </div>
</div>

<script type="text/javascript">
    $('.checkbox').checkbox();
    
    $('form').ajaxForm({
        beforeSubmit : function(arr, $form, options) {
            var result = $('.ui.form').form('validate form');

            if(result == true) {
                $('.form').addClass('loading');
            }

            return result;
        },
        success : function(responseText, statusText) {
            $('.form').removeClass('loading');
            
            console.log(responseText);
            
            if(responseText == 'success') {
                $("#success_modal").modal({
                    onApprove : function() {
                    }
                }).modal("show");
            } else {
                $("#failed_modal").modal({
                    onApprove : function() {
                    }
                }).modal("show");
            }
        },
        resetForm : false
    });
    
    $('.ui.form').form({
        inline : true,
        on : 'blur',
        fields : {
            email : {
                identifier : 'email',
                rules : [
                    {
                        type : 'empty',
                        prompt : 'Email地址不能为空'
                    },
                    {
                        type : 'email',
                        prompt : 'Email地址的格式有误'
                    }
                ]
            },
            mobile : {
                identifier : 'mobile',
                rules : [
                    {
                        type : 'regExp[/^(1[0-9]{10})?$/]',
                        prompt : '手机号码的格式有误'
                    }
                ]
            },
            realname : {
                identifier : 'realname',
                rules : [
                    {
                        type : 'regExp[/^(([\u4e00-\u9fa5]{2,4})|([a-zA-Z ]{3,60}))?$/]',
                        prompt : '姓名有误'
                    }
                ]
            },
            birthday : {
                identifier : 'age',
                rules : [
                    {
                        type : 'regExp[/^([0-9]{1,2})?$/]',
                        prompt : '年龄格式有误'
                    }
                ]
            }
        }
    });
</script>