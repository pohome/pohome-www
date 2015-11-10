<div class="ui four cards">
    {% for photo in photos %}
    <div class="card" id="card_{{ photo.file_id }}" style="width: 180px;">
        <div class="ui inverted dimmer" id="dimmer_{{ photo.file_id }}"><div class="ui loader"></div></div>
        <div class="image">
            <img src="/upload/img/pet/photo/thumbnail/{{ photo.file_id }}.jpeg">
        </div>
        <div class="extra">
            <div class="ui red tiny label"><span class="delete button" data="{{ photo.file_id }}">删除</span></div>
        </div>
    </div>
    {% endfor %}
</div>

<div class="ui horizontal divider">上传新照片</div>

<form class="ui form" method="post" enctype="multipart/form-data">
    <div class="field">
        <label>选择要上传的照片（可多选）</label>
        <input type="file" name="photos[]" multiple="" />
    </div>
    <input type="submit" class="ui orange button" value="上传" />
</form>

<div class="ui small modal">
    <div class="header">
        删除动物照片
    </div>
    <div class="image content">
        <div class="ui small image">
            <img id="modal_pet_photo" src="">
        </div>
        <div class="description">确认删除此照片吗？</div>
    </div>
    
    <div class="actions">
        <div class="ui positive button">确认</div>
        <div class="ui deny button">取消</div>
    </div>
</div>

<script>
$(document).ready(function() {
    $(".delete.button").click(function() {
        
        var fileId = $(this).attr('data');
        var dimmer = $('#dimmer_' + fileId);
        var card = $('#card_' + fileId);
        
        $('#modal_pet_photo').attr('src', '/upload/img/pet/photo/thumbnail/' + fileId + '.jpeg')
        
        $('.ui.modal').modal({
            closable : false,
            onApprove : function() {
                dimmer.addClass("active");
                $.post('/admin/pet/deletePhoto', {fileId : fileId}, function(data, status) {
                    dimmer.removeClass('active');
                    card.remove();
                });
            }
        }).modal('show');
    });
});
</script>
