<?php
	
namespace Pohome\Frontend\Controllers;

class AboutController extends \Phalcon\Mvc\Controller
{
	public function indexAction()
	{
		$this->view->title = '关于我们 - 汪汪喵呜孤儿院';
		$this->view->sectionId = 'about';
		
		$this->view->setRenderLevel(\Phalcon\Mvc\View::LEVEL_ACTION_VIEW);
	}
}