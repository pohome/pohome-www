<a href="/admin/blog/new">
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
			<th>作者</th>
			<th>发布日期</th>
			<th>浏览量</th>
			<th>操作</th>
    		<th>草稿</th>
		</tr>
	</thead>
	<tbody>
		{% for blog in page.items %}
		<tr>
			<td>{{ blog.title }}</td>
			<td>{{ blog.author().username }}</td>
			<td>{{ blog.published_at }}</td>
			<td>{{ blog.viewed }}</td>
			<td>
    			<a href="/admin/blog/edit/{{ blog.id }}"><i class="edit icon"></i></a>
<!--     			<a href="/admin/blog/delete/{{ blog.id }}"><i class="delete icon"></i></a> -->
			</td>
    		<td><input type="checkbox" {% if blog.draft == 1 %}checked=""{% endif %} /></td>
		</tr>
		{% endfor %}
	</tbody>
</table>
<div class="ui pagination menu">
    <a class="icon item" href="/admin/blog/index/{{ page.before }}"><i class="left arrow icon"></i></a>
    <?php
        $page = $this->view->page;
        $current = $page->current;
        $total = $page->total_pages;
        
        if($current > 3) {
            echo '<a class="item" href="/admin/blog/index/1">1</a>';
            echo '<div class="disabled item">...</div>';
        }
        
        for($i = max($current - 2, 1); $i < min($current + 3, $total + 1); $i++)
        {
            if($i == $current) {
                echo '<a class="active item" href="/admin/blog/index/' . $i . '">' . $i . '</a>';
            } else {
                echo '<a class="item" href="/admin/blog/index/' . $i . '">' . $i . '</a>';
            }
        }
        
        if($current < $total - 2) {
            echo '<div class="disabled item">...</div>';
            echo '<a class="item" href="/admin/blog/index/' . $total . '">' . $total . '</a>';
        }
    ?>
    
    <a class="icon item" href="/admin/blog/index/{{ page.next }}"><i class="right arrow icon"></i></a>
</div>
