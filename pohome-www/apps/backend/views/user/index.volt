<table class="ui small table">
	<thead>
		<tr>
			<th style="width: 10em">ID</th>
			<th style="width: 10em">用户名</th>
			<th style="width: 10em">Email</th>
			<th style="width: 10em">电话</th>
			<th>操作</th>
		</tr>
	</thead>
	<tbody>
		{% for user in page.items %}
		<tr>
			<td>{{ user.id }}</td>
			<td>{{ user.username }}</td>
			<td>{{ user.email }}</td>
			<td>{{ user.mobile }}</td>
			<td>
				<a href="\admin\user\edit\{{ user.id }}" style="margin-right: 0.5em">编辑</a>
			</td>
		</tr>
		{% endfor %}
	</tbody>
</table>

<div class="ui pagination menu">
    <a class="icon item" href="/admin/user/index/{{ page.before }}"><i class="left arrow icon"></i></a>
    <?php
        $page = $this->view->page;
        $current = $page->current;
        $total = $page->total_pages;
        
        if($current > 3) {
            echo '<a class="item" href="/admin/user/index/1">1</a>';
            echo '<div class="disabled item">...</div>';
        }
        
        for($i = max($current - 2, 1); $i < min($current + 3, $total + 1); $i++)
        {
            if($i == $current) {
                echo '<a class="active item" href="/admin/user/index/' . $i . '">' . $i . '</a>';
            } else {
                echo '<a class="item" href="/admin/user/index/' . $i . '">' . $i . '</a>';
            }
        }
        
        if($current < $total - 2) {
            echo '<div class="disabled item">...</div>';
            echo '<a class="item" href="/admin/user/index/' . $total . '">' . $total . '</a>';
        }
    ?>
    
    <a class="icon item" href="/admin/user/index/{{ page.next }}"><i class="right arrow icon"></i></a>
</div>

<!-- <a href="/admin/user/new"><button class="ui orange button">添加用户</button></a> -->