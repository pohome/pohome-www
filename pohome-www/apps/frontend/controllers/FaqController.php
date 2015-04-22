<?php
	
namespace Pohome\Frontend\Controllers;

use \Pohome\Frontend\Models\Faq;

class FaqController extends \Phalcon\Mvc\Controller
{
	public function indexAction()
	{
		$this->view->title = '建设中...';
		$this->view->setRenderLevel(\Phalcon\Mvc\View::LEVEL_ACTION_VIEW);
		$this->view->faqs = Faq::find();
	}
}