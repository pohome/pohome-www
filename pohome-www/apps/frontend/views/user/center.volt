<div id="carousel">
    <div style="background-image: url(/image/carousel/individual-center.jpg);"></div>
</div>

<div class="segment">
    <div class="wrap" style="background-color: #fff; padding: 40px;">
        <div class="ui grid">
            <div class="four wide column">
                <div class="ui vertical fluid menu">
                    <a class="active item" href="/user/center">基本信息</a>
                    <a class="item" href="/user/center/edit">编辑基本信息</a>
<!--                     <a class="item" href="/user/center/favorite-pet">关注的动物</a> -->
                    <a class="item" href="/user/center/service-record">义工服务记录</a>
                    <a class="item" href="/user/center/adoption-record">领养申请记录</a>
                    <a class="item" href="/user/center/service-intension">志愿者服务意向</a>
                    <a class="item" href="/user/center/change-password">修改密码</a>
                    </div>
            </div>
            <div class="nine wide column usercenter">
                <div class="row"><span class="field label">用户名：</span><span class="field value">{{ user.username }}</span></div>
                <div class="row"><span class="field label">Email：</span><span class="field value">{{ user.email }}</span><!-- {% if user.email_verified == 0 %}<span class="ui tiny red label">未验证</span>{% else %}<span class="ui tiny green label">已验证</span>{% endif%} --></div>
                <div class="row"><span class="field label">手机：</span>{% if user.mobile is defined %}<span class="field value">{{ user.mobile }}</span>{% else %}未填写{% endif %}</div>
                <div class="row"><span class="field label">真实姓名：</span>{% if user.extra.realname is defined %}<span class="field value">{{ user.extra.realname }}</span>{% else %}未填写{% endif %}</div>
                <div class="row"><span class="field label">生日：</span>{% if user.extra.birthday is defined %}<span class="field value">{{ user.extra.getBirthday() }}</span>{% else %}未填写{% endif %}</div>
                <div class="row"><span class="field label">性别：</span>{% if user.extra.gender is defined %}<span class="field value">{{ user.extra.getGender() }}</span>{% else %}未填写{% endif %}</div>
                <div class="row"><span class="field label">注册时间：</span><span class="field value">{{ user.created_at }}</span></div>
                <div class="row"><span class="field label">义工服务小时数：</span><span class="field value"></span></div>
                <div class="row"><span class="field label">等级：</span><span class="field value"></span></div>
            </div>
            <div class="three wide column" style="text-align: center;">
                <div><img src="/upload/img/user/avatar/large/{{ userId }}.jpg" id="avatar-image" style="width: 128px;border-radius: 128px"></div>
                <div><a class="ui tiny green button" style="margin-top: 10px" id="upload_avatar_button">上传头像</a></div>
                <input type="file" hidden="" name="avatar" id="upload_avatar_field" />
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
    $('#upload_avatar_button').click(function() {
        $('#upload_avatar_field').click();
    });
    
    $('#upload_avatar_field').change(function() {
        var file = document.getElementById("upload_avatar_field").files[0];
        var fd = new FormData();
        fd.append("avatar", file);
        $.ajax({
            url : "/user/upload-avatar",
            method : "post",
            processData : false,
            contentType : false,
            data : fd,
            success : function(data, status) {
                console.log(data);
                $('#avatar-image').attr("src", data + '?t='+ new Date().getTime());
            }
        });
    });
</script>