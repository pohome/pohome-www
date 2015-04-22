<table class="ui table">
    <thead>
        <tr>
            <th style="width: 40em">问题</th>
            <th style="width: 10em">分类</th>
            <th>操作</th>
        </tr>
    </thead>
    <tbody>
        {% for faq in page.items %}
        <tr>
            <td>{{ faq.question }}</td>
            <td>{{ faq.getCatelogName() }}</td>
            <td><a href="/admin/faq/edit/{{ faq.id }}">编辑</a><a href="/admin/faq/delete/{{ faq.id }}"> 删除</a></td>
        </tr>
        {% endfor %}
    </tbody>
    </tbody>
</table>

<div class="ui pagination menu">
    <a class="icon item" href="/admin/faq/index/{{ page.before }}"><i class="left arrow icon"></i></a>
    <?php
        $page = $this->view->page;
        $current = $page->current;
        $total = $page->total_pages;
        
        if($current > 3) {
            echo '<a class="item" href="/admin/faq/index/1">1</a>';
            echo '<div class="disabled item">...</div>';
        }
        
        for($i = max($current - 2, 1); $i < min($current + 3, $total + 1); $i++)
        {
            if($i == $current) {
                echo '<a class="active item" href="/admin/faq/index/' . $i . '">' . $i . '</a>';
            } else {
                echo '<a class="item" href="/admin/faq/index/' . $i . '">' . $i . '</a>';
            }
        }
        
        if($current < $total - 2) {
            echo '<div class="disabled item">...</div>';
            echo '<a class="item" href="/admin/faq/index/' . $total . '">' . $total . '</a>';
        }
    ?>
    
    <a class="icon item" href="/admin/faq/index/{{ page.next }}"><i class="right arrow icon"></i></a>
</div>
