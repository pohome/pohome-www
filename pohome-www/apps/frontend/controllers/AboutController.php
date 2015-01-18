<?php
	
namespace Pohome\Frontend\Controllers;

class AboutController extends \Phalcon\Mvc\Controller
{
	public function indexAction()
	{
		$this->view->title = '关于我们';
		$this->view->sectionId = 'about';
	}
}