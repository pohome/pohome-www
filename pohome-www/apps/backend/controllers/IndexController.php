<?php

namespace Pohome\Backend\Controllers;

class IndexController extends \Phalcon\Mvc\Controller
{
	public function installAction()
	{
		$this->view->disable();
		
		$username = 'sieg';
		$password = 'oscar200';
		$email = 'sieg@pohome.cn';
		
		$user = new \Pohome\Backend\Models\Users;
		
		$user->username = $username;
		$user->password = $this->security->hash($password);
		$user->email = $email;
		$user->last_visit_at = date('Y-m-d H:i:s', $_SERVER['REQUEST_TIME']);
		$user->last_visit_ip = ip2long($_SERVER['REMOTE_ADDR']);
		
		if($user->save() == false) {
			foreach($user->getMessages() as $msg) {
				echo $msg;
			}
		}
	}
	
	public function route404Action()
	{
		echo 'page not found!';
		$this->view->disable();
	}
}