<form class="ui form" method="post">
    <div class="inline field">
        <label>动物</label>
        <span>{{ pet.name }}</span>
    </div>
    
    <div class="inline field">
        <label>目前位于</label>
        <select class="ui dropdown" name="from" id="transfer_from">
            {% for value, name in location %}
            <option value="{{ value }}" {% if pet.location_id == value %}selected=""{% endif %}>{{ name }}</option>
            {% endfor %}
        </select>
    </div>
    
    <div class="inline field">
        <label>目前位于</label>
        <select class="ui dropdown" name="destination" id="transfer_destination">
            {% for value, name in location %}
            <option value="{{ value }}">{{ name }}</option>
            {% endfor %}
        </select>
    </div>
    
    <div class="inline field">
        <label>日期</label>
        <input type="text" name="date" id="transfer_date" value="{{ today }}" placeholder="YYYY-MM-DD">
    </div>
    
    <div class="inline field">
		<label for="description" style="vertical-align: top;">说明</label>
		<textarea name="description"></textarea>
	</div>
	
	<div class="ui orange button" id="save_button">保存</div>
</form>

<div class="ui small modal">
    <div class="header">添加动物转移记录成功！</div>
    <div class="content">已登记{{ pet.name }}于</div>
    <div class="actions">
        <div class="ui positive button">确定</div>
    </div>
</div>

<script type="text/javascript">
    $(document).ready(function() {
        $("#save_button").click(function() {
            $("form").addClass("loading");
            $('form').ajaxSubmit({
                success : function(responseText, statusText) {
                    console.log(responseText);
                    if(responseText == "S") {
                        $(".ui.modal .content").text("已登记{{ pet.name }}于" + $("#transfer_date").val() + "从 " + $("#transfer_from :selected").text() + " 转移至 " + $("#transfer_destination :selected").text())
                        $(".ui.modal").modal({
                            closable : false,
                            onApprove : function() {
                                window.location.href = "/admin/pet/index";
                            }
                        }).modal("show");
                    } else {
                        $("form").removeClass("loading");
                    }
                },
                resetForm : false
            });
        });
    });
</script>