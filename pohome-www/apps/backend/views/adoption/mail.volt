{% if messages is defined %}
{% for msg in messages %}
<div class="ui card" style="width: 60% !important">
    {% if msg.status == "投递成功" %}<label class="ui top right attached blue label">{{ msg.status }}</label>{% endif %}
    {% if msg.status == "提交" %}<label class="ui top right attached yellow label">{{ msg.status }}</label>{% endif %}
    {% if msg.status == "已阅" %}<label class="ui top right attached green label">{{ msg.status }}</label>{% endif %}
    {% if msg.status == "退回" %}<label class="ui top right attached red label">{{ msg.status }}</label>{% endif %}
    {% if msg.status == "失败" %}<label class="ui top right attached red label">{{ msg.status }}</label>{% endif %}
    <div class="content">
        <div class="header">
            {{ msg.title }}
        </div>
        <div class="meta"><span>{{ msg.sent_at }}</span><span style="margin-left: 0.5em">{{ msg.user.username }}</span></div>
        <div class="description">
        {{ msg.content }}
        </div>
    </div>
</div>
{% endfor %}
{% endif %}
<div class="ui divider"></div>
<form method="post" class="ui form">
    <div class="field">
        <label>标题</label>
        <input type="text" name="title" value="感谢您申请领养{{ application.pet.name }}" />
    </div>
    <div class="inline fields">
        <label>变更状态</label>
        <div class="field">
            <input type="radio" name="status" value="" checked=""/>
            <label>无变化</label>
        </div>
        
        <div class="field">
            <input type="radio" name="status" value="" />
            <label>预约面试</label>
        </div>
        
        <div class="field">
            <input type="radio" name="status" value="" />
            <label>预约送养</label>
        </div>
        
        <div class="field">
            <input type="radio" name="status" value="" />
            <label>拒绝申请</label>
        </div>
    </div>
    <div class="field">
        <label>邮件正文</label>
        <textarea name="content"></textarea>
    </div>
    
    <input type="submit" class="ui green button" value="回复" />
</form>