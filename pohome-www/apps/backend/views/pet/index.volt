<a href="/admin/pet/new">
    <div class="ui orange vertical animated button">
        <div class="visible content">
            <i class="plus icon"></i>
        </div>
        <div class="hidden content">新增</div>
    </div>
</a>

<div class="ui selection dropdown" id="bbaa">
    <div class="default text">批量添加...</div>
    <i class="dropdown icon"></i>
    <div class="menu">
        <div class="item">免疫记录</div>
        <div class="item">驱虫记录</div>
        <div class="item">洗澡记录</div>
        <div class="item">位置转移记录</div>
        <div class="item">状态变化记录</div>
    </div>
</div>

<table class="ui small table">
	<thead>
		<tr>
    		<th><input type="checkbox" id="select_all_pet" /></th>
			<th style="width: 10em">名字</th>
			<th style="width: 16em">年龄</th>
			<th style="width: 4em">性别</th>
			<th style="width: 4em">物种</th>
			<th>操作</th>
		</tr>
	</thead>
	<tbody>
		{% for pet in page.items %}
		<tr>
    		<td class="table_row_checkbox" style="width: 1em !important"><input type="checkbox" id="pet_{{ pet.id }}" /></td>
			<td>{{ pet.name }}</td>
			<td>{{ pet.getAge() }}</td>
			<td>{{ pet.getGender() }}</td>
			<td>{{ pet.getSpecies() }}</td>
			<td>
				<a href="\admin\pet\edit\{{ pet.id }}" style="margin-right: 0.5em">编辑</a>
				<a href="\admin\pet\photo\{{ pet.id }}" style="margin-right: 0.5em">添加照片</a>
				<a href="\admin\pet\story\list\{{ pet.id }}" style="margin-right: 0.5em">添加故事</a>
				<a href="\admin\pet\medical\list\{{ pet.id }}" style="margin-right: 0.5em">医疗记录</a>
				<a href="\admin\pet\healthcare\{{ pet.id }}" style="margin-right: 0.5em">健康护理</a>
				<a href="\admin\pet\adopt\{{ pet.id }}" style="margin-right: 0.5em">领养</a>
				<a href="\admin\pet\transfer\{{ pet.id }}" style="margin-right: 0.5em">转移</a>
				
			</td>
		</tr>
		{% endfor %}
	</tbody>
</table>

<div class="ui pagination menu">
    <a class="icon item" href="/admin/pet/index/{{ page.before }}"><i class="left arrow icon"></i></a>
    <?php
        $page = $this->view->page;
        $current = $page->current;
        $total = $page->total_pages;
        
        if($current > 3) {
            echo '<a class="item" href="/admin/pet/index/1">1</a>';
            echo '<div class="disabled item">...</div>';
        }
        
        for($i = max($current - 2, 1); $i < min($current + 3, $total + 1); $i++)
        {
            if($i == $current) {
                echo '<a class="active item" href="/admin/pet/index/' . $i . '">' . $i . '</a>';
            } else {
                echo '<a class="item" href="/admin/pet/index/' . $i . '">' . $i . '</a>';
            }
        }
        
        if($current < $total - 2) {
            echo '<div class="disabled item">...</div>';
            echo '<a class="item" href="/admin/pet/index/' . $total . '">' . $total . '</a>';
        }
    ?>
    
    <a class="icon item" href="/admin/pet/index/{{ page.next }}"><i class="right arrow icon"></i></a>
</div>

<div class="ui modal" id="medical">
    <i class="close icon"></i>
    <div class="header">批量操作</div>
    <div class="content">
        <form class="ui form">
            <div class="inline field">
                <label>日期</label>
                <input type="text" />
            </div>
            <div class="inline field">
                <label>项目</label>
                <div class="ui radio checkbox">
                    <input type="radio" name="record_type" />
                    <label>狂犬疫苗</label>
                </div>
                <div class="ui radio checkbox">
                    <input type="radio" name="record_type" />
                    <label>免疫疫苗</label>
                </div>
            </div>
<!--
            <div class="field">
                <label>免疫疫苗品牌</label>
                <select class="ui modal dropdown" id="aabb">
                    <option value="">疫苗</option>
                    <option value="">疫苗</option>
                    <option value="">疫苗</option>
                </select>
            </div>
-->
            
            <input class="ui orange button" type="submit" value="提交" />
        </form>
    </div>
</div>

<script>
    $(document).ready(function() {
        // 一键选择当前页全部动物
        $('#select_all_pet').click(function() {
            if($(this).prop("checked")) {
                $('tbody').find('input[type="checkbox"]').each(function() {
                    $(this).prop('checked', true);
                })
            } else {
                $('tbody').find('input[type="checkbox"]').each(function() {
                    $(this).prop('checked', false);
                })
            }
        })
        
        $('#aabb').dropdown();
        
        $('#bbaa').dropdown({
            onChange : function(value, text) {
                $('input[type="checkbox"]').each(function() {
                    if($(this).prop("checked") == true) {
                        console.log($(this).attr("id"));
                    }
                });
                
                $('.modal').modal('show');
            }
        });
    });
</script>