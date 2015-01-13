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
		{% for user in users %}
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

<a href="/admin/user/new"><button class="ui orange button">添加用户</button></a>