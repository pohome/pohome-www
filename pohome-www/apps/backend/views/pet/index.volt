<a href="/admin/pet/new">
    <div class="ui orange vertical animated button">
        <div class="visible content">
            <i class="plus icon"></i>
        </div>
        <div class="hidden content">新增</div>
    </div>
</a>

<table class="ui small table">
	<thead>
		<tr>
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
			<td>{{ pet.name }}</td>
			<td>{{ pet.getAge() }}</td>
			<td>{{ pet.getGender() }}</td>
			<td>{{ pet.getSpecies() }}</td>
			<td>
				<a href="\admin\pet\edit\{{ pet.id }}" style="margin-right: 0.5em"><i class="edit icon"></i></a>
				<a href="\admin\pet\photo\{{ pet.id }}" style="margin-right: 0.5em"><i class="photo icon"></i></a>
				<a href="\admin\pet\story\list\{{ pet.id }}" style="margin-right: 0.5em"><i class="book icon"></i></a>
			</td>
		</tr>
		{% endfor %}
	</tbody>
</table>
<a href="/admin/pet/index/{{ page.before }}"><div class="ui blue circular label"><</div></a>
<?php
    $page = $this->view->page;
    for ($i = 1; $i < $page->total_pages + 1; $i++)
    {
        if ($page->current == $i) {
            printf('<a href="/admin/pet/index/%d"><div class="ui orange circular label">%d</div></a>', $i, $i);
        } else {
            printf('<a href="/admin/pet/index/%d"><div class="ui blue circular label">%d</div></a>', $i, $i);
        }
    }
?>
<a href="/admin/pet/index/{{ page.next }}"><div class="ui blue circular label">></div></a>