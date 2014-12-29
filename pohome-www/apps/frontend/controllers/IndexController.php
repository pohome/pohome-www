<?php
	
namespace Pohome\Frontend\Controllers;

class IndexController extends \Phalcon\Mvc\Controller
{
	public function indexAction()
	{
		$this->view->title = '汪汪喵呜孤儿院';
	}
}