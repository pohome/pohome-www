<?php
	
namespace Pohome\Frontend\Controllers;

class BaseController extends \Phalcon\Mvc\Controller
{
	public function initialize()
	{
		if(!empty($this->session->get('userId'))) {
			$this->view->userId = $this->session->get('userId');
			$this->view->username = $this->session->get('username');
		}
	}
}