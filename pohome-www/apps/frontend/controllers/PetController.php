<?php

namespace Pohome\Frontend\Controllers;

use Pohome\Frontend\Models\Pet;
use Pohome\Frontend\Models\PetExtraInfo;

class PetController extends \Phalcon\Mvc\Controller
{
	public function indexAction()
	{
		$this->view->title = '等待领养的动物';
		
		if(!$this->request->isPost()) {
			$this->view->pets = Pet::find(array("limit" => 20));
			$this->view->hotPets = Pet::find(array("limit" => 6));
			$this->view->species = 'ALL';
			$this->view->gender = 'ALL';
			$this->view->body_size = 'ALL';
		}
	}
	
	public function viewAction($petId)
	{
		//$this->view->disable();
		$pet = Pet::findFirst($petId);
		$this->view->pet = $pet;
		$this->view->title = $pet->name;
		$this->view->recommends = Pet::find(array("order" => "rand()", "limit" => 5));
		/*
foreach($this->view->recommends as $p)
		{
			echo $p->name;
		}
*/
	}
}