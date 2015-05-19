<form class="ui form" method="post">
    <div class="inline field">
        <label>动物</label>
        <span>{{ pet.name }}</span>
    </div>
    
    <div class="inline field">
        <label>位置</label>
        <select class="ui dropdown" name="location" id="location">
            {% for value, name in location %}
            <option value="{{ value }}" {% if pet.location_id == value %}selected=""{% endif %}>{{ name }}</option>
            {% endfor %}
        </select>
    </div>
    
    <div class="inline field">
        <label>日期</label>
        <input type="text" name="happened_at" id="happened_at" value="{{ today }}" placeholder="YYYY-MM-DD">
    </div>
    
    <div class="field">
        <label>说明</label>
        <textarea name="description"></textarea>
    </div>
    
    <div class="ui orange button" id="save_button">保存</div>
</form>

<div class="ui small modal">
    <div class="header">添加动物医疗记录成功！</div>
    <div class="content"></div>
    <div class="actions">
        <div class="ui positive button">确定</div>
    </div>
</div>

<script type="text/javascript">
    $(document).ready(function() {
        $('textarea').redactor({
			lang : 'zh_cn',
			minHeight : 500,
			imageUpload : '/admin/file/upload',
			pastePlainText : true
		});		
	});
	
	$("#save_button").click(function() {
    	$("form").addClass("loading");
            $('form').ajaxSubmit({
                success : function(responseText, statusText) {
                    console.log(responseText);
                    if(responseText == "S") {
                        $(".ui.modal .content").text("已登记{{ pet.name }}于" + $("#happened_at").val() + "在" + $("#location :selected").text() + "进行的医疗诊治记录");
                        $(".ui.modal").modal({
                            closable : false,
                            onApprove : function() {
                                window.location.href = "/admin/pet/index";
                            }
                        }).modal("show");
                    } else {
                        console.log(responseText);
                        $("form").removeClass("loading");
                    }
                }
            });
	});
</script>