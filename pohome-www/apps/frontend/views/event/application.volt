<div id="carousel">
    <div style="background-image: url(/image/demo/pet-detail-carousel.jpg);min-height: 400px;"></div>
</div>

<div class="segment">
    <div class="wrap" style="background-color: #fff; padding: 40px;">
        <form class="ui form" method="post">
            <div class="inline field">
                <label>人数</label><input type="text" name="number_of_people" />
            </div>
            <div class="inline field">
                <label>出发地</label><input type="text" name="departure_from" />
            </div>
            <div class="inline fields">
                <label>开车</label>
                <div class="field"><input type="radio" name="has_car" value="1" /><label>是</label></div>
                <div class="field"><input type="radio" name="has_car" value="0" /><label>否</label></div>
            </div>
            
            <div><input type="submit" class="ui green button" value="保存"></div>
        </form>
    </div>
</div>

<div class="ui small modal">
    <div class="header">个人信息更新成功</div>
    <div class="content">
        <p>您的新个人信息已经保存</p>
    </div>
    <div class="actions">
        <div class="ui positive button">确定</div>
    </div>
</div>

<script type="text/javascript">
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
                $(".ui.modal").modal({
                    onApprove : function() {
                        //window.location.href = "http://www.pohome.cn/pet";
                    }
                }).modal("show");
            } else {
                // console.log('wrong');
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
                identifier : 'birthday',
                rules : [
                    {
                        type : 'regExp[/^([0-9]{4}-[0-9]{1,2}-[0-9]{1,2})?$/]',
                        prompt : '日期格式有误'
                    }
                ]
            }
        }
    });
</script>