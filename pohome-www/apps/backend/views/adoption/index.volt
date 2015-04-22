<table class="ui table">
    <thead>
        <tr>
            <th>动物名</th>
            <th>申请人</th>
            <th>性别</th>
            <th>年龄</th>
            <th>工作状态</th>
            <th>住房</th>
            <th>小区/道路</th>
            <th>申请时间</th>
            <th>状态</th>
            <th>操作</th>
        </tr>
    </thead>
    <tbody>
    {% for application in page.items %}
        <tr>
            <td>{{ application.getPet().name }}</td>
            <td>{{ application.getForm()['姓名'] }}</td>
            <td>{{ application.getForm()['性别'] }}</td>
            <td>{{ application.getForm()['年龄'] }}</td>
            <td>{{ application.getForm()['您目前'] }}</td>
            <td>{{ application.getForm()['您目前住房的性质'] }}</td>
            <td>{{ application.getForm()['街道/小区名'] }}</td>
            <td>{{ application.applied_at }}</td>
            <td>{{ application.getStatus() }}</td>
            <td><a href="/admin/adoption/view/{{ application.id }}">审核</a></td>
        </tr>
    {% endfor %}
    </tbody>
</table>

<div class="ui pagination menu">
    <a class="icon item" href="/admin/adoption/index/{{ page.before }}"><i class="left arrow icon"></i></a>
    <?php
        $page = $this->view->page;
        $current = $page->current;
        $total = $page->total_pages;
        
        if($current > 3) {
            echo '<a class="item" href="/admin/adoption/index/1">1</a>';
            echo '<div class="disabled item">...</div>';
        }
        
        for($i = max($current - 2, 1); $i < min($current + 3, $total + 1); $i++)
        {
            if($i == $current) {
                echo '<a class="active item" href="/admin/adoption/index/' . $i . '">' . $i . '</a>';
            } else {
                echo '<a class="item" href="/admin/adoption/index/' . $i . '">' . $i . '</a>';
            }
        }
        
        if($current < $total - 2) {
            echo '<div class="disabled item">...</div>';
            echo '<a class="item" href="/admin/adoption/index/' . $total . '">' . $total . '</a>';
        }
    ?>
    
    <a class="icon item" href="/admin/adoption/index/{{ page.next }}"><i class="right arrow icon"></i></a>
</div>
