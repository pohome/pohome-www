<?php
	
namespace Pohome\Frontend\Controllers;

use Pohome\Models\User;
use Pohome\Models\UserExtraInfo;
use Pohome\Models\ServiceIntension;

class UserController extends BaseController
{
    public function centerAction($page)
    {
        if(!$this->session->has('userId')) {
            $this->response->redirect('user/login');
        }
        
        if($this->request->isPost()) {
            $this->view->disable();
            switch($page) {
                case 'edit':
                    $this->editProfile();
                    break;
                
                case 'service-intension':
                    $this->editServiceIntension();
                    break;
                    
                case 'change-password':
                    $this->changePassword();
                    break;
                    
                default:
                    return;
            }
            return;
        }
        
        $userId = $this->session->get('userId');
        $this->view->user = User::findFirst($userId);
        $this->view->addition = '<script type="text/javascript" src="/js/jquery.form.js"></script>';
        
        if($page == 'service-intension') {
            global $serviceIntensionType;
            $this->view->sit = $serviceIntensionType;
        }
        
        if(isset($page)) {
            $this->view->pick('user/center-' . $page);
        }
    }
    
    private function editProfile()
    {
        $post = $this->request->getPost();
        $userId = $this->session->get('userId');
        $user = User::findFirst($userId);
        $extra = UserExtraInfo::findFirst($userId);
        if(!$extra) {
            $extra = new UserExtraInfo();
            $extra->user_id = $userId;
        }
        
        $user->email = $post['email'];
        $user->mobile = $post['mobile'];
        $extra->realname = $post['realname'];
        
        if(!empty($post['birthday'])) {
            $extra->birthday = $post['birthday'];
        }
        
        if(array_key_exists('gender', $post)) {
            $extra->gender =$post['gender'];
        }
        
        $user->save();
        $extra->save();
        
        echo 'success';
    }
    
    private function editServiceIntension()
    {
        if($this->request->isPost()) {
            $post = $this->request->getPost();
        
            $userId = $this->session->get('userId');
            $user = User::findFirst($userId);
            $extra = UserExtraInfo::findFirst($userId);
            if(!$extra) {
                $extra = new UserExtraInfo();
                $extra->user_id = $userId;
            }
            
            $user->email = $post['email'];
            $user->mobile = $post['mobile'];
            $extra->realname = $post['realname'];
            $extra->service_intension_remark = $post['remark'];
            
            if(!empty($post['birthday'])) {
                $extra->birthday = $post['birthday'];
            }
            
            if(array_key_exists('gender', $post)) {
                $extra->gender =$post['gender'];
            }
            
            $this->db->begin();
            
            if($user->save() == false) {
                $this->db->rollback();
                echo 'failure #0';
                return;
            }
            
            if($extra->save() == false) {
                $this->db->rollback();
                echo 'failure #1';
                return;
            }
            
            // 删除原来的记录
            $oldIntensions = ServiceIntension::find("user_id = $userId");
            
            foreach($oldIntensions as $o)
            {
                if($o->delete() == false) {
                    $this->db->rollback();
                    echo 'failure #2';
                    return;
                }
            }
            
            foreach($post['intension'] as $intension_id)
            {
                $si = new ServiceIntension();
                $si->user_id = $userId;
                $si->intension_id = $intension_id;
                
                if($si->save() == false) {
                    $this->db->rollback();
                    echo 'failure #3';
                    return;
                }
            }
            
            $this->db->commit();
            echo 'success';
        }
    }
    
    public function uploadAvatarAction()
    {
        if($this->request->hasFiles()) {
            $this->view->disable();
            foreach($this->request->getUploadedFiles() as $file)
            {
                $img = new \Imagick($file->getTempName());
                
                $height = $img->getImageHeight();
                $width = $img->getImageWidth();
                $root = $_SERVER['DOCUMENT_ROOT'];
                $userId = $this->session->get('userId');
                
                if($width > $height) {
                    $length = $height;
                    $x = $width / 2 - $height / 2;
                    $img->cropImage($length, $length, $x, 0);
                } elseif($width < $height) {
                    $length = $width;
                    $y = $height / 2 - $width / 2;
                    $img->cropImage($length, $length, 0, $y);
                }
                
                // 保存256px的头像
                if($length > 240) {
                    $img->resizeImage(256, 256, \Imagick::FILTER_CATROM, 0.9);
                }
                
                $img->writeImage($root . "/upload/img/user/avatar/large/$userId.jpg");
                
                // 保存128px的头像
                $img->resizeImage(128, 128, \Imagick::FILTER_CATROM, 0.9);
                $img->writeImage($root . "/upload/img/user/avatar/small/$userId.jpg");
                
                // 保存64px的头像
                $img->resizeImage(64, 64, \Imagick::FILTER_CATROM, 0.9);
                $img->writeImage($root . "/upload/img/user/avatar/tiny/$userId.jpg");
                
                echo "/upload/img/user/avatar/large/$userId.jpg";
            }
        } else {
            $this->response->redirect('/');
        }
    }
    
	public function loginAction()
	{
		$this->view->setRenderLevel(\Phalcon\Mvc\View::LEVEL_ACTION_VIEW);
		
		if($this->request->isPost()) {
			$post = $this->request->getPost();
			$error = array();
			
			$user = User::findFirstByUsername($post['username']);
			if($user == false) {
				$error['用户名不存在'] = true;
				echo '用户名不存在！';
			} else {
				if(!$this->security->checkHash($post['password'], $user->password)) {
					$error['密码错误'] = true;
					echo '密码错误!';
				}
			}
			
			if(empty($error)) {
				$user->update();
				
				$this->session->set('userId', $user->id);
				$this->session->set('username', $user->username);
				$this->session->set('permission', $user->permission);
				$this->session->set('userHasAvatar', $user->hasAvatar());
				
				// 如果勾选了7天内免登录
				if($this->request->getPost('remember_me') == 'on') {
    				$this->view->disable();
    				$uuid = $this->generateCookieUUID($user->username);
    				$this->cookies->set('uuid', $uuid, time() + 7 * 86400);
    				$this->redis->set($uuid, $user->id, 7 * 86400);
				}
				
				if($this->session->has('returnURL')) {
    				$this->response->redirect(substr($this->session->get('returnURL'), 1));
				} else {
    				$this->response->redirect('');
				}
			} else {
				$this->view->error = $error;
			}
		}
	}
	
	public function logoutAction()
	{
    	// 移除cookie中保存的登录token
    	$uuid = $this->cookies->get('uuid');
    	$this->cookies->delete('uuid');
    	$userId = $this->redis->del($uuid);
    	
		$this->session->remove('userId');
		$this->session->remove('username');
		$this->session->remove('permission');
		$this->response->redirect('');
	}
	
	public function registerAction()
	{
    	$this->view->setRenderLevel(\Phalcon\Mvc\View::LEVEL_ACTION_VIEW);
		$this->view->title = '汪汪喵呜孤儿院 - 新用户注册';
		
		if($this->request->isPost()) {
			$post = $this->request->getPost();
			
			$error = array();
			
			if($post['step'] == 0) {
				// 第一步:验证用户信息
				if(empty($post['username'])) {
					$error['空用户名'] = true;
				} else if(User::findFirstByUsername($post['username']) != false) {
					$error['用户名已存在'] = true;
				}
				
				if(empty($post['password'])) {
					$error['密码为空'] = true;
				} else if(!preg_match('/[0-9a-zA-Z!@#$%^&*()_=]{6,16}/', $post['password'])) {
					$error['密码格式错误'] = true;
				} else if($post['password'] != $post['password_retype']) {
					$error['两次输入的密码不一致'] = true;
				}
				
				if(empty($post['email'])) {
					$error['Email为空'] = true;
				} else if(!preg_match('/^[_.0-9a-z-]+@([0-9a-z][0-9a-z-]+.)+[a-z]{2,3}$/', $post['email'])) {
					$error['Email格式错误'] = true;
				} else if(User::findFirstByEmail($post['email']) != false) {
					$error['Email已存在'] = true;
				}
				
				if(!empty($error)) {
					$this->view->username = $post['username'];
					$this->view->email = $post['email'];
					$this->view->error = $error;
				} else {
					// 保存用户数据
					$user = new User();
					$post['user_type'] = 'individual';
					$this->saveData($user, $post, 'create');

					$this->view->disable();
					
                    $this->session->set('userId', $user->id);
    				$this->session->set('username', $user->username);
    				$this->session->set('permission', $user->permission);

                    if($this->session->has('returnURL')) {
                        $url = substr($this->session->get('returnURL'), 1);
                        $this->response->redirect($url);
                    } else {
                        $this->response->redirect('user/success');
                    }
										
					// 发送验证邮件
					// TODO: 完成邮件地址验证功能
/*
					$key = $user->id;
					$value = md5($user->id . $user->created_at . $user->last_login_ip);
					$this->redis->set($key, $value);
					$this->redis->expire($key, 86400); // 一天之内完成邮件验证
					$verifyUrl = sprintf('http://beta2014.pohome.cn/user/verify-email/%s/%s', $key, $value);
					$this->mail->sendMessage('pohome.cn', array(
    					'from' => 'noreply@pohome.cn',
    					'to' => $user->email,
    					'title' => '欢迎您加入汪汪喵呜孤儿院！',
    					'html'=>'<h1>欢迎您加入汪汪喵呜孤儿院！</h1><p>请点击此链接以完成邮箱验证：<a href="' . $verifyUrl . '">' . $verifyUrl . '</p>'
					));
*/
				}
			}
		}
	}
	
	public function successAction()
	{
    	$this->view->setRenderLevel(\Phalcon\Mvc\View::LEVEL_ACTION_VIEW);
		//$this->view->meta = '<meta http-equiv="Refresh" content="5;url=/">';
	}
	
	public function forgotAction()
	{
		$this->view->setRenderLevel(\Phalcon\Mvc\View::LEVEL_ACTION_VIEW);
	}
	
	public function verifyEmailAction($userId, $verifyCode)
	{
    	$this->view->disable();

    	if($this->redis->get($userId) == $verifyCode) {
        	$user = User::findFirst($userId);
        	$user->email_verified = 1;
        	$user->update();
        	$this->redis->del($userId);
        	echo '邮箱验证通过！';
    	} else {
        	echo '邮箱验证失败!';
    	}
	}
}