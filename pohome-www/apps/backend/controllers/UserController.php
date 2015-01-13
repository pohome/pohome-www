<?php
	
namespace Pohome\Backend\Controllers;

use Pohome\Backend\Models\User;

class UserController extends \Phalcon\Mvc\Controller
{
	public function newAction()
	{
		if($this->request->isPost()) {
			$user = new User();
			$post = $this->request->getPost();
			
			$user->username = $post['username'];
			$user->password = $this->security->hash($post['password']);
			$user->email = $post['email'];
			
			
			// TODO: 处理用户权限的问题
			
			$user->create();
			
			$this->view->disable();
			echo 'New user created.';
		}
	}
	
	public function listAction()
	{
		$this->view->title = '用户列表';
		$this->view->users = User::find();
	}
}