<?php
    
namespace Pohome\Backend\Controllers;

use \Pohome\Models\File;
use \Pohome\Models\Blog;
use \Pohome\Models\Pet;

class FileController extends BaseController
{
    
    public function listAction()
    {
        $this->view->disable();
        $path = $_SERVER['DOCUMENT_ROOT'] . '/upload/image/';
        $i = 1024;
        $id = 1234;
        $type = 'jpeg';
        echo $path . $i . '/' . $id . '.' . $type;
    }
    
    public function uploadAction()
    {
        $this->view->disable();
        
        $files = $this->saveImage();
        $id = $files[0]['id'];
        $type = $files[0]['type'];
        $path = $_SERVER['DOCUMENT_ROOT'] . '/upload/image/';
        
        for ($i = 1024; $i >= 64; $i /= 2)
        {
            if (file_exists($path . $i . '/' . $id . '.' . $type)) {
                $path = '/upload/image/' . $i . '/' . $id . '.' . $type;
                break;
            }
        }
        
        $result = array(
            'filelink' => $path
        );
        
        echo stripslashes(json_encode($result));
    }
    
    public function cleanAction()
    {
        $this->view->disable();
        
        $usedFiles = array();
        
        // 确认博客包含的照片
        $blogs = Blog::find();
        foreach($blogs as $blog)
        {
            $content = $blog->content;
            preg_match_all('#<img src="/upload/image/\d+?/(\d+?.jpeg)".*?>#', $content, $match);
            foreach($match[1] as $filename)
            {
                $usedFiles[] = $filename;
            }
        }
        
        // 确认动物的照片
        $pets = Pet::find();
        foreach($pets as $pet)
        {
            $usedFiles[] = $pet->id.'jpeg';
        }
        
        
        $savedFiles = scandir($_SERVER['DOCUMENT_ROOT'] . '/upload/image/64');
        
        $diff = array_diff($usedFiles, $savedFiles);
        foreach($diff as $img)
        {
            echo $img;
            printf('<img src="/upload/image/128/%s" width=400>', $img);
        }
    }
    
    public function updateAction()
    {
        $this->view->disable();
        set_time_limit(60);
        
        $path = $_SERVER['DOCUMENT_ROOT'] . '/upload/image/';

        $files = File::find();
        foreach($files as $file)
        {
            if(is_null($file->type)) {
                $filename = $file->id . '.' . $file->file_type;
                $img = new \Imagick($path.'64/'.$filename);
                $size = $img->getImageGeometry();
                
                $width = $size['width'];
                $height = $size['height'];
                
                if($width > $height) {
                    $type = 'L';
                } elseif($width < $height) {
                    $type = 'P';
                } else {
                    $type = 'S';
                }
                
                for($d = 2048; $d >= 64; $d /= 2)
                {
                    if(file_exists($path.$d.'/'.$filename)) {
                        $max_size = $d;
                        break;
                    }
                }
                
/*
                echo $type . "\n";
                echo $max_size . "\n";
*/
                $file->type = $type;
                $file->max_size = $max_size;
                $file->update();
            }
        }        
        
    }
}