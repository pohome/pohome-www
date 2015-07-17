<?php
	
namespace Pohome\Frontend\Controllers;

class AboutController extends BaseController
{
	public function indexAction()
	{
		$this->view->title = '关于我们 - 汪汪喵呜孤儿院';
	}
}