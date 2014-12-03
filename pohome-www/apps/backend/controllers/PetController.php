<?php
	
namespace Pohome\Backend\Controllers;

use Pohome\Backend\Models;

class PetController extends \Phalcon\Mvc\Controller
{
	public function newAction()
	{
		$this->view->setVar('title', '汪汪喵呜孤儿院 - 添加新动物');
		
		// 处理提交的表单数据
		if($this->request->isPost()) {
			
			$pet = new Pet();
			$petExtraInfo = new PetExtraInfo();
			
			
			var_dump($_POST);
			$this->view->disable();
		}
	}
}