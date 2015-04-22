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
    			<a href="/admin/event/edit/{{ event.id }}"><i class="edit icon"></i></a>
			</td>
		</tr>
		{% endfor %}
	</tbody>
</table>

<div class="ui pagination menu">
    <a class="icon item" href="/admin/event/index/{{ page.before }}"><i class="left arrow icon"></i></a>
    <?php
        $page = $this->view->page;
        $current = $page->current;
        $total = $page->total_pages;
        
        if($current > 3) {
            echo '<a class="item" href="/admin/event/index/1">1</a>';
            echo '<div class="disabled item">...</div>';
        }
        
        for($i = max($current - 2, 1); $i < min($current + 3, $total + 1); $i++)
        {
            if($i == $current) {
                echo '<a class="active item" href="/admin/event/index/' . $i . '">' . $i . '</a>';
            } else {
                echo '<a class="item" href="/admin/event/index/' . $i . '">' . $i . '</a>';
            }
        }
        
        if($current < $total - 2) {
            echo '<div class="disabled item">...</div>';
            echo '<a class="item" href="/admin/event/index/' . $total . '">' . $total . '</a>';
        }
    ?>
    
    <a class="icon item" href="/admin/event/index/{{ page.next }}"><i class="right arrow icon"></i></a>
</div>