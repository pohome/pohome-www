<div id="carousel">
    <div style="background-image: url(/image/demo/pet-detail-carousel.jpg);min-height: 400px;"></div>
</div>

<div class="wrap">
    <div id="pet-detail">
        <img src="/upload/image/512/{{ pet.id }}.jpeg">
        <div class="info">
            <div class="name">{{ pet.name }}</div>
            <div>
                <div><span class="label">年　　龄：</span><span>{{ pet.getAge() }}</span></div>
                <div><span class="label">性　　别：</span><span>{{ pet.getGender() }}</span></div>
                <div><span class="label">体　　型：</span><span>{{ pet.getBodySize() }}</span></div>
                <div><span class="label">品　　种：</span><span>{{ pet.getBreed() }}</span></div>        
            </div>
            <div class="notice"><span class="label">领养需知：</span><span>{{ pet.notice }}</span></div>
            <div>
                {% if pet.isAdoptable() %}
                <a href="/adoption/application/{{ pet.id }}"><span class="ui orange button">我要领养</span></a>
                {% elseif pet.status_id == 6 %}
                <span class="ui red button">{{ pet.name }}已经被领养啦</span>
                {% elseif pet.status_id == 9 %}
                <span class="ui red button">{{ pet.name }}已经被预订啦</span>
                {% endif %}
                {% if pet.status_id < 6 %}
                <a href="{{ pet.getTaobaoUrl() }}"><span class="ui green button">我要助养</span></a>
                {% endif %}
            </div>
        </div>
    </div>
</div>
	    	
<div class="segment background white">
    <div class="wrap">
    	<div class="title green">『{{ pet.name }}』的故事</div>
    	<div style="color: #000;text-align: justify;background-color: #fff;margin: 40px">
        	{{ pet.story }}
    	</div>
    </div>
</div>
    	
<div class="segment background white">
    <div class="wrap">
    	<div class="title green">『{{ pet.name }}』的照片</div>
    	<ul id="pet-photo">
        	{% for photo in pp %}<li><img src="/upload/image/256/{{ photo.file_id }}.jpeg" class="pet_thumbnail" data="{{ photo.file_id }}"></li>{% endfor %}
    	</ul>
	</div>
</div>

<div class="ui modal">
    <div class="image content">
        <img src="" class="image" style="max-width: 100%;height: 600px;">
    </div>
</div>

<script>
    $('.modal').modal();
    $(".pet_thumbnail").click(function() {
        var filename = '/upload/image/1024/' + $(this).attr('data') + '.jpeg';
        $('.modal img').attr('src', filename);
        $('.modal').modal('refresh').modal('show');
    });
</script>