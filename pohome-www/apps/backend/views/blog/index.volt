<table class="ui small table">
	<thead>
		<tr>
			<th>标题</th>
			<th>作者</th>
			<th>发布日期</th>
			<th>浏览量</th>
			<th>操作</th>
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
    			<a href="/admin/blog/edit/{{ blog.id }}">编辑</a>
    			<a href="/admin/blog/delete/{{ blog.id }}">删除</a>
			</td>
		</tr>
		{% endfor %}
	</tbody>
</table>
<a href="/admin/blog/index/{{ page.before }}"><div class="ui blue circular label"><</div></a>
<a href="/admin/blog/index/1"><div class="ui blue circular label">{{ page.current }}</div></a>
<a href="/admin/blog/index/{{ page.next }}"><div class="ui blue circular label">></div></a>
