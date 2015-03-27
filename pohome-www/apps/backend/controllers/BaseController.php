<?php
    
namespace Pohome\Backend\Controllers;


class BaseController extends \Phalcon\Mvc\Controller
{
    public $result = array();
    
    public function initialize()
    {   
        if ($this->dispatcher->getControllerName() == 'user') {
            
            $action = $this->dispatcher->getActionName();
            
            if ($action <> 'login' && $action <> 'logout') {
                $this->checkPermission();
            }
        } else {
            $this->checkPermission();
        }
    }
    
    private function checkPermission()
    {
        if (!$this->session->has('userId')) {
            $this->session->set('_url', $_REQUEST['_url']);
            $this->response->redirect('admin/user/login');
        }
        
        if (!$this->hasPermission(PERMISSION_LOGIN_BACKEND)) {
            $this->response->redirect('admin/user/login');
        }

    }
    
    protected function saveData(&$model, &$post, $type)
    {
        if($model->$type($post) == false)
        {
            foreach($model->getMessages() as $msg)
            {
                $field = $msg->getField();
                $this->result[] = array('field' => $field, 'type' => $msg->getType(), 'value' => $post[$field]);
            }
        }
    }
    
    protected function saveImage($id = null)
    {
        $fileIds = array();
        
        if($this->request->hasFiles())
        {
            foreach($this->request->getUploadedFiles() as $file)
            {
                $fileType = $file->getRealType();
                
                if(preg_match("/^image\/(jpeg|png|gif)$/", $fileType, $matches) == 0) {
                    echo 'wrong image type.';
                    continue;
                }
                
                // 生成文件名的uuid   
                if(is_null($id)) {
                    $fileId = gen_uuid();
                } else {
                    $fileId = $id;
                }
                
                $files[] = array('id' => $fileId, 'type' => $matches[1]);
                
                $filename = $fileId . '.' . $matches[1];
                
                $img = new \Imagick($file->getTempName());
                $this->resizeImage($img, $filename);
                                
                $f = new \Pohome\Backend\Models\File();
                
                $post = array(
                    'id' => $fileId,
                    'original_filename' => $file->getName(),
                    'file_type' => $matches[1],
                    'file_size' => $file->getSize(),
                    'uploader_id' => $this->session->get('userId')
                );
                
                $this->saveData($f, $post, 'create');
            }
        }
        
        return $files;
    }
    
    protected function resizeImage(&$img, $filename)
    {
        $basePath = '/upload/image/';
        
        $size = $img->getImageGeometry();
        $width = $size['width'];
        $height = $size['height'];
        
        for($d = 2048; $d >= 64; $d /= 2)
        {
            if($width < $d && $height < $d) {
                continue;
            }

            $img->resizeImage($d, $d, \Imagick::FILTER_CATROM, 0.95, true);
            $path = $_SERVER['DOCUMENT_ROOT'] . $basePath . $d . '/' . $filename;
            $result = $img->writeImage($path);
        }
        
    }
    
    private function cleanTags($str)
    {
        return strip_tags($str, '<code><span><div><label><a><br><p><b><i><del><strike><u><img><video><audio><iframe><object><embed><param><blockquote><mark><cite><small><ul><ol><li><hr><dl><dt><dd><sup><sub><big><pre><code><figure><figcaption><strong><em><table><tr><td><th><tbody><thead><tfoot><h1><h2><h3><h4><h5><h6>');
    }
    
    protected function hasPermission($permission)
    {
        if (!$this->session->has('permission')) {
            return false;
        } else {
            return ($this->session->get('permission') & $permission) == $permission;
        }
    }
}