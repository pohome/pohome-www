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
			
			$pet->name = $this->request->getPost('name');
			$pet->species = $this->request->getPost('species');
			$pet->gender = $this->request->getPost('gender');
			$pet->breed = $this->request->getPost('breed');
			// ...
			
			$pet->create();
			$petExtraInfo->create();
			
			var_dump($_POST);
			$this->view->disable();
		}
	}
}