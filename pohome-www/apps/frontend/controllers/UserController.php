<?php
	
namespace Pohome\Frontend\Controllers;

use Pohome\Models\User;

class UserController extends BaseController
{
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
					
					// 发送验证邮件
					// TODO: 完成邮件地址验证功能
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
					
					// 跳转页面
					//$this->response->redirect('/user/success');
					
				}
			}
		}
	}
	
	public function successAction()
	{
		$this->view->meta = '<meta http-equiv="Refresh" content="5;url=/">';
	}
	
	public function forgotAction()
	{
		
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