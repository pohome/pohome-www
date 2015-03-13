<?php
	
namespace Pohome\Frontend\Controllers;

class ContactController extends \Phalcon\Mvc\Controller
{
	public function indexAction()
	{
		$this->view->title = '联系我们';
		$this->view->sectionId = 'contact';
		
		if($this->request->isPost())
		{
			
		}
	}
}