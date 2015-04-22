<form class="ui form" method="post">
    <div class="field">
        <label>问题</label>
        <input type="text" name="question" value="{{ faq.question }}">
    </div>
    
    <div class="field">
        <label>回答</label>
        <textarea name="answer">{{ faq.answer }}</textarea>
    </div>
    
    <div class="inline field">
		<label>常见问答分类</label>
		<select class="ui dropdown" name="catelog_id">
			{% for key, value in catelogs %}
			<option value="{{ key }}"{% if faq.catelog_id == key %} selected=""{% endif %}>{{ value }}</option>
			{% endfor %}
		</select>
	</div>
	
	<input type="submit" class="ui orange button" value="保存" style="margin-bottom: 10em">
</form>