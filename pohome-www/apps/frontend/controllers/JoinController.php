<?php
	
namespace Pohome\Frontend\Controllers;

class JoinController extends \Phalcon\Mvc\Controller
{
	public function indexAction()
	{
		$this->view->title = '加入我们';
		$this->view->sectionId = 'join';
	}
}