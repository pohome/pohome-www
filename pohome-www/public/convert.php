<?php

// 初始化数据库
try {
    $db = new PDO("mysql:host=localhost;dbname=pohome", "pohome", "pohome");
} catch (PDOException $err) {
    echo $err->getMessage();
}

convert_blog_images();
convert_pet_images();
//convert_avatar_images();
//convert_event_images();




// 转换博文中涉及到的图片
function convert_blog_images()
{
    global $db;

    $query = $db->prepare("SELECT id,content,feature_image FROM Blog");
    $query->execute();
    $blogs = $query->fetchAll();
    
    foreach($blogs as $blog)
    {
        if(strlen($blog['feature_image']) < 5) {
            // 将未设置展示图片的博文的feature_image栏统一设置成0
            set_feature_image($blog['id'], 0);
        } else {
            // 将展示图片转换成合适的尺寸
            $file_id = $blog['feature_image'];
            convert($file_id, 240, 160, 'blog/feature/', false, $blog['id']);
            
            // 将博文中的图片转换成合适的尺寸
            parse_blog_image($blog['id'], $blog['content']);
        }
    } 
}


// 转换动物相关的图片
function convert_pet_images()
{
    global $db;
    
    // 转换动物头像
    $query = $db->prepare("SELECT id FROM Pet");
    $query->execute();
    $pets = $query->fetchAll();
    
    foreach($pets as $pet)
    {
        $file_id = $pet['id'];
        convert($file_id, 360, 360, 'pet/avatar/large/', true);
        convert($file_id, 280, 280, 'pet/avatar/small/', true);
    }
    
    // 转换动物照片
    $query = $db->prepare("SELECT file_id FROM PetPhoto");
    $query->execute();
    $photos = $query->fetchAll();
    
    foreach($photos as $photo)
    {
        $file_id = $photo['file_id'];
        convert($file_id, 1080, 720, 'pet/photo/full/', true);
        convert($file_id, 180, 120, 'pet/photo/thumbnail/', true);
    }
}


// 转换用户头像相关的图片
function convert_avatar_images()
{
    
}


// 转换活动相关的图片
function convert_event_images()
{
    
}


function parse_blog_image($id, $content)
{
    $pattern = '#<img src="/upload/image/\d+/(\d+).jpeg".*?>#';
    
    $result = preg_replace_callback($pattern, function($matches) {
        $file_id = $matches[1];
        
        convert($file_id, 600, 400, 'blog/content/', true);
        return '<img src="/upload/img/blog/content/' . $file_id . '.jpeg">';
    }, $content);
    
    global $db;
    
    $s = $db->prepare('UPDATE Blog SET content=:content WHERE id=:id');
    $s->bindValue(':content', $result, PDO::PARAM_STR);
    $s->bindValue(':id', $id, PDO::PARAM_INT);
    $s->execute();
}


// 设置博文的展示图片id
function set_feature_image($id, $file_id)
{
    global $db;
    
    $sql = "UPDATE Blog SET feature_image = 0 WHERE id = '$id'";
    
    if(!$db->exec($sql)) {
        print_r($db->errorInfo(), true);
    }
}

function convert($file_id, $width, $height, $path, $rotate, $target_file_id = '')
{
    if(max_size_file_path($file_id) == false) {
        return;
    }
    
    $origin = new Imagick(max_size_file_path($file_id));
    $origin->setImageCompressionQuality(80);
    $root = $_SERVER['PWD'] . '/upload/img/';
    
    
    // 将最大尺寸的图片源文件保存到相应目录的origin目录下
    $origin->writeImage($root . 'origin/' . $file_id . '.jpeg');
    
    
    if($rotate) {
        $w = $origin->getImageWidth();
        $h = $origin->getImageHeight();
        if($w < $h && $width > $height) {
            $width = $height / ($width / $height);
        }
    }
    
    if($origin->getImageWidth() > $width) {
        // 将图片缩放到合适的尺寸并保存
        crop($origin, $width / $height);
        
        $origin->resizeImage($width, $height, Imagick::FILTER_CATROM, 1, true);
    }
    
    if(empty($target_file_id)) {
        $origin->writeImage($root . $path . $file_id . '.jpeg');
    } else {
        $origin->writeImage($root . $path . $target_file_id . '.jpeg');
    }
}

function crop(&$img, $ratio)
{
    $w = $img->getImageWidth();
    $h = $img->getImageHeight();
    $r = $w / $h;
    
    if($r != 1) {
        if($r > $ratio) {
            $w1 = $h * $ratio;
            $x = ($w - $w1) / 2;
            $img->cropImage($w1, $h, $x, 0);
        } elseif($r < $ratio) {
            $h1 = $w / $ratio;
            $y = ($h - $h1) / 2;
            $img->cropImage($w, $h1, 0, $y);
        }
    }
}


// 返回file_id对应文件的最大尺寸文件的绝对路径
function max_size_file_path($file_id)
{
    $root = $_SERVER['PWD'] . '/upload/image/';
    
    for($size = 2048; $size > 32; $size /= 2)
    {
        $path = $root . $size . '/' . strval($file_id) . ".jpeg";
        
        if(file_exists($path)) {
            return $path;
        }
    }
    
    return false;
}
?>