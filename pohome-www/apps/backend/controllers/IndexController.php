<?php

namespace Pohome\Backend\Controllers;

class IndexController extends \Phalcon\Mvc\Controller
{
	public function indexAction()
	{
		
	}
	
	public function route404Action()
	{
		$this->view->disable();
		echo '404';
	}
}