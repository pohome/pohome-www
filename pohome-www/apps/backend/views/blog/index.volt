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
		{% for b in blog %}
		<tr>
			<td>{{ b.title }}</td>
			<td>{{ b.author() }}</td>
			<td>{{ b.published_at }}</td>
			<td>{{ b.viewed }}</td>
			<td><a href="/admin/blog/edit/{{ b.id }}">编辑</a></td>
		</tr>
		{% endfor %}
	</tbody>
</table>