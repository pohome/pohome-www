<?php
	
namespace Pohome\Backend\Controllers;

class PetController extends \Phalcon\Mvc\Controller
{
	public function newAction()
	{
		if(!$this->request->isPost()) {
			$this->view->setVar('title', '汪汪喵呜孤儿院 - 添加新动物');
		
			$form = new \Pohome\SemanticUIForm\SemanticUIForm('newPet');
			$this->view->setVar('form', $form);
		} else {
			//var_dump($_POST);
			$this->view->disable();
			
			foreach($_POST as $key => $value) {
				$fieldValidateFunctionName = $key . 'validate';
				echo $fieldValidateFunctionName . '<br />';
				//print_r(method_exists($this, 'new'));
			}
			
		}
	}
	
	public function testAction()
	{
		echo 'test'.'<br />';
		
		$pet = new \Pohome\Backend\Models\Users;
		$pet->username = 'sieg';
		
		
		$pet->password = 'oscar200';
		$pet->email = 'zhaoyan@me.com';
		$pet->last_visit_at = '1111';
		$pet->last_visit_ip = '111';
		
		
		if($pet->save() == false) {
			foreach($pet->getMessages() as $msg) {
				echo $msg->getField() . ':';
				echo $msg->getMessage() . '<br />';
			}
		}
		
		
		$this->view->disable();
	}
}