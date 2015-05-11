<table class="ui striped table" style="width: 600px;display: inline-block">
    <tbody>
        {% for key, value in application.getForm() %}
        <tr{% if value is empty %} class="warning"{% endif %}>
            <td style="width: 20em">{{ key }}</td>
            <td>
                <?php
                    if(!is_array($value)) {
                        if(!empty($value)) {
                            echo $value;
                        } else {
                            echo '未填';
                        }
                    } else {
                        foreach($value as $v) {
                            echo $v . ' ';
                        }
                    }
                ?>
            </td>
        </tr>
        {% endfor %}
    </tbody>
</table>

<div style="display: inline-block; vertical-align: top;margin-left: 20px">
    <div class="ui card">
        <div class="image">
            <img src="/upload/image/512/{{ application.getPet().id }}.jpeg">
        </div>
        <div class="content">
            <div class="header">{{ application.getPet().name }}</div>
            <div class="meta">
                <span class="date">{{ application.getPet().getAge() }}</span>
                <span>{{ application.getPet().getSpecies() }}</span>
                <span>{{ application.getPet().getGender() }}</span>
            </div>
            <div class="description">{{ application.getPet().notice }}</div>
        </div>
    </div>
    <a href="/admin/adoption/mail/{{ application.id }}"><div class="ui green button">回复邮件</div></a>
</div>

<div class="ui segment comments" style="width: 600px">
    <div class="ui top attached label">审核团意见</div>
    
    {% for comment in comments %}
    <div class="comment">
        <div class="content">
            <a class="author">{{ comment.getUsername() }}</a>
            <div class="metadata">
                <div class="date">{{ comment.getTimePassed() }}</div>
            </div>
            <div class="text">{{ comment.comment }}</div>
        </div>
    </div>
    {% endfor %}
    
    <div class="ui divider"></div>
    
    <form class="ui form" method="post" style="width: 100%">
        <div class="field">
            <textarea name="comment"></textarea>
        </div>
        <input class="ui green button" type="submit" value="提交审核意见">
    </form>
</div>