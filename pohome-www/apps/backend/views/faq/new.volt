<form class="ui form" method="post">
    <div class="ui error message"></div>
    <div class="field">
        <label>问题</label>
        <input type="text" name="question">
    </div>
    
    <div class="field">
        <label>回答</label>
        <textarea name="answer"></textarea>
    </div>
    
    <div class="inline field">
		<label>常见问答分类</label>
		<select class="ui dropdown" name="catelog_id">
			{% for key, value in catelogs %}
			<option value="{{ key }}">{{ value }}</option>
			{% endfor %}
		</select>
	</div>
	
	<input type="submit" class="ui orange button" value="保存" style="margin-bottom: 10em">
</form>

<div class="ui small modal">
    <div class="header">添加成功！</div>
    <div class="content">添加常见问答成功！</div>
    <div class="actions">
        <div class="ui orange button">确定</div>
    </div>
</div>

<script type="text/javascript">
$(document).ready(function() {
    $('form').ajaxForm({
        beforeSubmit : function(arr, $form, options) {
            var result = $('.ui.form').form('validate form');
            return result;
        },
        success : function(responseText, statusText) {
            responseText = $.parseJSON(responseText);
            if($.isEmptyObject(responseText)) {
                $(".ui.modal").modal("show");
            } else {
                $('.ui.form').form('validate form')
            }
        },
        dateType : 'json',
        resetForm : true
    });
    
    $('.ui.form').form({
        question : {
            identifier : 'question',
            rules : [
                {
                    type : 'empty',
                    prompt : '问题不能为空'
                },
                {
                    type : 'maxLength[100]', 
                    prompt : '问题长度不能超过100字'
                }
            ]
        },
        answer : {
            identifier : 'answer',
            rules : [
                {
                    type : 'empty',
                    prompt : '答案不能为空'
                },
                {
                    type : 'maxLength[400]', 
                    prompt : '答案长度不能超过400字'
                }
            ]
        }
    });
});
</script>
