<?php
    
namespace Pohome\Backend\Controllers;


class BaseController extends \Phalcon\Mvc\Controller
{
    public $result = array();
    
    public function initialize()
    {
        $controller = $this->dispatcher->getControllerName();
        $action = $this->dispatcher->getActionName();
        
        if($controller == 'file' && $action == 'upload') {
            return;
        }
        
        if($controller != 'user' || $action != 'login') {
            // 如果session中没有userId，尝试从cookie中获取用户的登录uuid
            if(!$this->session->has('userId')) {
                // 尝试从cookie里获取userId
                $this->getUserIdFromCookie();
            }
            
            $userId = $this->session->get('userId');
            $url = '/admin/' . $controller . '/' . $action;
            
            // 判断是否有进入后台的权限
    		if(!$this->hasPermission($userId, '/admin/index/index')) {
        		$this->securityLog->log($this->session->get('username') . '尝试越权访问' . $url);
        		$this->response->redirect('');
    		}
    		
    		// 判断是否有访问当前页面的权限
    		if(!$this->hasPermission($userId, $url)) {
        		//$this->response->redirect('');
    		}
        }
    }
    
    protected function getUserIdFromCookie()
    {
        if($this->cookies->has('uuid')) {
    		$uuid = $this->cookies->get('uuid');
    		$userId = $this->redis->get($uuid);
    		
    		if($userId) {
        		$user = \Pohome\Models\User::findFirst($userId);
        		
        		if($user) {
            		$this->session->set('userId', $userId);
            		$this->session->set('username', $user->username);
        		}        		
    		} 
		}
		
		if(!$this->session->has('userId')) {
    		$this->redirectToLogin();
		}
    }
    
    protected function redirectToLogin()
    {
        $this->session->set('_url', $_REQUEST['_url']);
        $this->response->redirect('admin/user/login');
    }
        
    protected function hasPermission($userId, $url)
    {
        $phql = "SELECT uhr.user_id FROM Pohome\Models\UserHasRole uhr JOIN Pohome\Models\RoleHasPermission rhp ON uhr.role_id = rhp.role_id JOIN Pohome\Models\Permission p ON rhp.permission_id = p.id WHERE uhr.user_id = :id: AND p.url = :url:";
    	
    	$query = $this->modelsManager->createQuery($phql);
    	$result = $query->execute(array(
        	'id' => $userId,
        	'url' => $url
    	));
    	
    	return $result->count() == 1;
    }
    
    protected function saveData(&$model, &$post, $type)
    {
        if($model->$type($post) == false)
        {
            foreach($model->getMessages() as $msg)
            {
                $this->debug->error($msg->getMessage());
                $field = $msg->getField();
                $this->result[] = array('field' => $field, 'type' => $msg->getType(), 'value' => $post[$field]);
            }
        }
    }
    
    protected function cropInCenter(&$img, $ratio)
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
    
    protected function saveImageInfo($file, $id, $type)
    {
        $data = array(
            'id' => $id,
            'original_filename' => $file->getName(),
            'file_type' => $type,
            'file_size' => $file->getSize(),
            'type' => 'L',
            'max_size' => '1024',
            'uploader_id' => $this->session->get('userId')
        );
        
        $f = \Pohome\Models\File::findFirst($id);
        
        if(!$f) {
            $f = new \Pohome\Models\File();
            $this->saveData($f, $data, 'create');
        } else {
            $this->saveData($f, $data, 'update');
        }
    }
    
    protected function saveImage($spec, $id = null)
    {
        $files = $this->request->getUploadedFiles();
        $root = $_SERVER['DOCUMENT_ROOT'] . '/upload/img';
        $result = array();
        
        foreach($files as $file)
        {
            if(preg_match("#^image\/(jpeg|png|gif)$#", $file->getRealType(), $matches) == 0) {
                continue;
            }
            
            $type = $matches[1];
            
            if(is_null($id)) {
                $id = gen_uuid();
            }
            //var_dump($id);     
            $filename = $id . '.' . $type;
            $img = new \Imagick($file->getTempName());
            $img->writeImage($root . '/origin/' . $filename);
            
            array_push($result, array('id' => $id, 'type' => $type));
            $this->saveImageInfo($file, $id, $type);
            
            foreach($spec as $s)
            {
                $w = $img->getImageWidth();
                $h = $img->getImageHeight();
                $r = $w / $h;
                
                if($s['crop'] == true) {
                    $this->cropInCenter($img, $s['width'] / $s['height']);
                }
                
                $img->resizeImage($s['width'], $s['height'], \Imagick::FILTER_CATROM, 1, true);
                $img->writeImage($root . $s['path'] . $filename);
            }
        }
        
        return $result;
    }
    
    protected function saveBlogImage($id = null)
    {
        if($this->request->hasFiles())
        {
            $files = array();
            $root = $_SERVER['DOCUMENT_ROOT'] . '/upload/img';
            
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
                
                array_push($files, array('id' => $fileId, 'type' => $fileType));
                
                $filename = $fileId . '.' . $fileType;
                
                $img = new \Imagick($file->getTempName());
                $img->setImageFormat($fileType);
                
                // 保存原始图片文件
                $img->writeImage($root . '/origin/' . $filename);

                $w = $img->getImageWidth();
                $h = $img->getImageHeight();
                $r = $w / $h;
                
                $width = $r > 1 ? 720 : 480;
                
                $result = $img->resizeImage($width, $width / $r, \Imagick::FILTER_CATROM, 1, false);
                $img->writeImage($root . '/blog/content/' . $filename);
                
                $post = array(
                    'id' => $fileId,
                    'original_filename' => $file->getName(),
                    'file_type' => $fileType,
                    'file_size' => $file->getSize(),
                    'type' => $result['type'],
                    'max_size' => $result['max_size'],
                    'uploader_id' => $this->session->get('userId')
                );
                
                $f = \Pohome\Models\File::findFirst($fileId);
                
                if(!$f) {
                    $f = new \Pohome\Models\File();
                    
                    $this->saveData($f, $post, 'create');
                } else {
                    $this->saveData($f, $post, 'update');
                }
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
}