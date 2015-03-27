<!-- <div class="ui segment"> -->
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
			{% for pet in pets %}
			<tr>
				<td>{{ pet.name }}</td>
				<td>{{ pet.getAge() }}</td>
				<td>{{ pet.getGender() }}</td>
				<td>{{ pet.getSpecies() }}</td>
				<td>
					<a href="\admin\pet\edit\{{ pet.id }}" style="margin-right: 0.5em">编辑</a>
					<a href="\admin\pet\photo\{{ pet.id }}" style="margin-right: 0.5em">照片</a>
					<a href="\admin\pet\story\list\{{ pet.id }}" style="margin-right: 0.5em">故事</a>
				</td>
			</tr>
			{% endfor %}
		</tbody>
	</table>
<!-- </div> -->