<?php
	
namespace Pohome\Backend\Controllers;

use \Pohome\Backend\Models\User;
	
class AuthController extends \Phalcon\Mvc\Controller
{
	public function loginAction()
	{
		$result = new \Pohome\FormResult();
		
		$this->view->setRenderLevel(\Phalcon\Mvc\View::LEVEL_ACTION_VIEW);
		$this->view->title = '汪汪喵呜孤儿院 - 后台管理系统';
				
		if($this->request->isPost()) {
			
			// 防止跨脚本攻击
			if(!$this->security->checkToken()) {
				$this->view->disable();
				echo 'DO NOT ATTACK US!';
				//$this->response->redirect('notFound');
			}
			
			// 验证用户信息
			$post = $this->request->getPost();
			$username = $post['username'];
			$password = $post['password'];
			
			// 检查用户名是否存在
			$user = User::findFirstByUsername($username);
						
			if(!$user) {
				// 用户不存在
				$result->add('username', '未找到指定用户信息，请检查您是否正确输入了用户名！');
				$this->view->result = $result;
				$this->view->tokenKey = $this->security->getTokenKey();
				$this->view->token = $this->security->getToken();
				return;
			} 

			if(!$this->security->checkHash($password, $user->password)) {
				// 密码错误
				$result->add('username,password', '用户名和密码错误，请检查您的输入。');
				$this->view->result = $result;
				$this->view->tokenKey = $this->security->getTokenKey();
				$this->view->token = $this->security->getToken();
				return;
			} 

			// 用户名密码正确
			$user->update();
			
			$this->session->set('userId', $user->id);
			$this->session->set('username', $user->username);
			$this->session->set('permissions', $this->getAllPermissions($user->id));
			
			$returnUrl = $this->session->get('returnUrl');
			
			if(is_null($returnUrl)) {
				$this->response->redirect('admin');
			} else {
				$this->session->remove('returnUrl');
				$this->response->redirect($returnUrl);
			}
		} else {
			$this->view->result = $result;
			$this->view->tokenKey = $this->security->getTokenKey();
			$this->view->token = $this->security->getToken();
		}
	}
	
	public function logoutAction()
	{
		$this->session->remove('userId');
		$this->session->remove('username');
		$this->session->remove('permissions');
		
		$this->response->redirect('admin/login');
	}
	
	public function permissionDeniedAction()
	{
		// TODO: 编写更优雅的无权访问页面
		$this->view->disable();
		echo 'Permission Denied.';
	}
	
	public function testAction()
	{
		$this->view->disable();
		
		if(is_null($this->session->get('userId'))) {
			// 跳转到登录页面
			$this->response->redirect('admin/auth/login');
		} else {
			$userId = $this->session->get('userId');
			checkPermission($userId, '登录后台');
		}
	}
	
	private function checkPermission($userId, $permission)
	{
		// 检查session中是否有保存该用户的全部权限
		$p = $this->session->get('permissions');
		
		if(!is_null($p)) {
			return in_array($permission, $p);
		} else {
			$p = $this->getAllPermissions($userId);
			$this->session-set('permissions', $p);
			return in_array($permission, $p);
		}
	}
	
	private function getAllPermissions($userId)
	{
		$permissions = array();
		$sql = "select name from permissions where permissions.id in (select permission_id from role_has_permissions where role_id in (select role_id from user_has_roles where user_id='$userId'))";
		$resultset = $this->db->query($sql);
		foreach($resultset->fetchAll() as $r) {
			array_push($permissions, $r['name']);
		}
		return $permissions;
	}
}