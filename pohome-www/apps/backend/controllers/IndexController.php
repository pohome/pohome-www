<?php

namespace Pohome\Backend\Controllers;

class IndexController extends \Phalcon\Mvc\Controller
{
	public function indexAction()
	{
		$this->view->title = '汪汪喵呜孤儿院后台管理';
		$this->view->breadcrumb = array();
	}
	
	public function route404Action()
	{
		$this->view->disable();
		echo '404';
	}
}