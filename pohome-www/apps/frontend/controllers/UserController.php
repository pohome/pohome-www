<?php
	
namespace Pohome\Frontend\Controllers;

class UserController extends \Phalcon\Mvc\Controller
{
	public function loginAction()
	{
		$this->view->setRenderLevel(\Phalcon\Mvc\View::LEVEL_ACTION_VIEW);
	}
}