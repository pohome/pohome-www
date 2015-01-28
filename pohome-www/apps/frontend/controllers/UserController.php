<?php
	
namespace Pohome\Frontend\Controllers;

use Pohome\Frontend\Models\User;

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
				//$this->session->set('permissions', $this->getAllPermissions($user->id));
				
				$this->response->redirect('');
			} else {
				$this->view->error = $error;
			}
		}
	}
	
	public function logoutAction()
	{
		$this->session->remove('userId');
		$this->session->remove('username');
		//$this->session->remove('permissions');
		$this->response->redirect('');
	}
	
	public function registerAction()
	{
		$this->view->title = '新用户注册';
		
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
					$user->username = $post['username'];
					$user->password = $this->security->hash($post['password']);
					$user->email = $post['email'];
					$user->create();
					
					// 发送验证邮件
					// TODO: 完成邮件地址验证功能
					
					// 跳转页面
					$this->response->redirect('register/success');
					
				}
			}
			//$this->view->disable();
		}
	}
	
	public function successAction()
	{
		$this->view->meta = '<meta http-equiv="Refresh" content="5;url=/">';
	}
	
	public function forgotAction()
	{
		
	}
}