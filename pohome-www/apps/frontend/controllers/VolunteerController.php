<?php
	
namespace Pohome\Frontend\Controllers;

class VolunteerController extends \Phalcon\Mvc\Controller
{
	public function indexAction()
	{
		$this->view->title = '建设中...';
		$this->view->setRenderLevel(\Phalcon\Mvc\View::LEVEL_ACTION_VIEW);
	}
}