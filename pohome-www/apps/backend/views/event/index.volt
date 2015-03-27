<a href="/admin/event/new">
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
			<th>标题</th>
			<th>发布者</th>
			<th>创建时间</th>
			<th>开始时间</th>
			<th>操作</th>
		</tr>
	</thead>
	<tbody>
		{% for event in page.items %}
		<tr>
			<td>{{ event.title }}</td>
			<td>{{ event.creator_id }}</td>
			<td>{{ event.created_at }}</td>
			<td>{{ event.begin_at }}</td>
			<td>
    			<a href="/admin/blog/edit/{{ blog.id }}"><i class="edit icon"></i></a>
    			<a href="/admin/blog/delete/{{ blog.id }}"><i class="delete icon"></i></a>
			</td>
		</tr>
		{% endfor %}
	</tbody>
</table>
<a href="/admin/event/index/{{ page.before }}"><div class="ui blue circular label"><</div></a>
<?php
    $page = $this->view->page;
    for ($i = 1; $i < $page->total_pages + 1; $i++)
    {
        if ($page->current == $i) {
            printf('<a href="/admin/event/index/%d"><div class="ui orange circular label">%d</div></a>', $i, $i);
        } else {
            printf('<a href="/admin/event/index/%d"><div class="ui blue circular label">%d</div></a>', $i, $i);
        }
    }
?>
<a href="/admin/event/index/{{ page.next }}"><div class="ui blue circular label">></div></a>