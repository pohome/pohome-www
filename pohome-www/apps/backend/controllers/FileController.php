<?php
    
namespace Pohome\Backend\Controllers;

use \Pohome\Backend\Models\File;

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
}