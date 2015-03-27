<h1><span>博文总数: </span><span id="total">尚未生成博文列表</span></h1>
<div class="ui orange button" id="generate_blog_list">生成博文列表</div>
<div class="ui disabled green button" id="import_blog">导入全部博文</div>
<div class="ui blue progress" id="import">
    <div class="bar">
        <div class="progress"></div>
    </div>
    <div class="label"></div>
</div>

<script type="text/javascript">
    $(document).ready(function() {

    });
    
    var blog_list;
    
    $('#generate_blog_list').click(function() {
        $('#generate_blog_list').addClass('loading');
        $.ajax({
            url: 'http://beta2014.pohome.cn/admin/blog/import',
            method: 'POST',
            data: {
                action: 'generate'
            },
            dataType: 'json'
        }).done(function(data, textStatus, xhr) {
            blog_list = data;
            $('#total').text(blog_list.length);
            $('#import').progress({
                total:  blog_list.length,
                text: {
                    active: '已导入{total}篇博文中的{value}篇',
                    success: '{total}已全部导入！'
                }
            });
            $('#generate_blog_list').removeClass('loading');
            $('#import_blog').removeClass('disabled');
        }).fail(function(xhr, textStatus, errorThrown) {
            console.log(errorThrown);
            console.log(xhr.responseText);
            $('#generate_blog_list').removeClass('loading');
        });
    });
    
    $('#import_blog').click(function() {
        var count = 0;
        for(var i = 0, length = blog_list.length; i < length; i++)
        {
            $('#import_blog').addClass('loading');
            $.ajax({
                url: 'http://beta2014.pohome.cn/admin/blog/import',
                method: 'POST',
                async: true,
                data: {
                    action: 'import',
                    url: blog_list[i],
                    count: i
                },
                dataType: 'json'
            }).done(function(data, textStatus, xhr) {
                count++;
                if(count == length - 1) {
                    $('#import_blog').removeClass('loading');
                    $('#import_blog').addClass('disabled');
                }
                $('#import').progress('increment');
            }).fail(function(xhr, textStatus, errorThrown) {
                console.log(xhr.responseText);
                count++;
                if(count == length - 1) {
                    $('#import_blog').removeClass('loading');
                    $('#import_blog').addClass('disabled');
                }
            });
        }
    });
</script>