<?php
    
namespace Pohome\Frontend\Controllers;

use Pohome\Models\User;

class BaseController extends \Phalcon\Mvc\Controller
{
    public $result = array();
    
    public function initialize()
    {
        if(!$this->session->has('userId')) {
            // 判断cookie里是否存在uuid
    		if($this->cookies->has('uuid')) {
        		$uuid = $this->cookies->get('uuid');
        		$userId = $this->redis->get($uuid);
        		
        		if($userId) {
            		$user = User::findFirst($userId);
            		
            		$this->session->set('userId', $userId);
            		$this->session->set('username', $user->username);
        		}
    		}
        } else {
            $this->view->userId = $this->session->get('userId');
    		$this->view->username = $this->session->get('username');
        }
    }
    
    protected function checkPermission()
    {
        if (!$this->session->has('userId')) {
            $this->session->set('_url', $_REQUEST['_url']);
            $this->response->redirect('admin/user/login');
        }
        
        if (!$this->hasPermission(PERMISSION_LOGIN_BACKEND)) {
            $this->response->redirect('admin/user/login');
        }

    }
    
    protected function hasPermission($permission)
    {
        if (!$this->session->has('permission')) {
            return false;
        } else {
            return ($this->session->get('permission') & $permission) == $permission;
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
                
                $fileType = $matches[1];
                
                // 生成文件名的uuid   
                if(is_null($id)) {
                    $fileId = gen_uuid();
                } else {
                    $fileId = $id;
                }
                
                $files[] = array('id' => $fileId, 'type' => $fileType);
                
                $filename = $fileId . '.' . $fileType;
                
                $img = new \Imagick($file->getTempName());
                $result = $this->resizeImage($img, $filename);
                                
                $f = new \Pohome\Backend\Models\File();
                
                $post = array(
                    'id' => $fileId,
                    'original_filename' => $file->getName(),
                    'file_type' => $fileType,
                    'file_size' => $file->getSize(),
                    'type' => $result['type'],
                    'max_size' => $result['max_size'],
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
        $result = array();
        
        $size = $img->getImageGeometry();
        $width = $size['width'];
        $height = $size['height'];
        
        if($width > $height) {
            $result['type'] = 'L';
        } elseif($width < $height) {
            $result['type'] = 'P';
        } else {
            $result['type'] = 'S';
        }
        
        for($d = 2048; $d >= 64; $d /= 2)
        {
            if($width < $d && $height < $d) {
                $result['max_size'] = $d / 2;
                continue;
            }

            $img->resizeImage($d, $d, \Imagick::FILTER_CATROM, 0.95, true);
            $path = $_SERVER['DOCUMENT_ROOT'] . $basePath . $d . '/' . $filename;
            $img->writeImage($path);
        }
        
        return $result;
    }
    
    private function cleanTags($str)
    {
        return strip_tags($str, '<code><span><div><label><a><br><p><b><i><del><strike><u><img><video><audio><iframe><object><embed><param><blockquote><mark><cite><small><ul><ol><li><hr><dl><dt><dd><sup><sub><big><pre><code><figure><figcaption><strong><em><table><tr><td><th><tbody><thead><tfoot><h1><h2><h3><h4><h5><h6>');
    }
    
    protected function generateCookieUUID($username)
    {
        $timestamp = explode(' ', microtime());
        $sec = intval($timestamp[1]);
        $msec = intval($timestamp[0] * 1000);
        $tid = $sec * 1000 + $msec;
        
        $uuid = sprintf('%s%012x%x', substr(md5($_SERVER['HTTP_USER_AGENT'] . $username), 0, 12), $tid, ip2long($_SERVER['REMOTE_ADDR']));
        return $uuid;
    }
}