<?php

namespace Pohome\Frontend\Controllers;

use Pohome\Frontend\Models\Pet;
use Pohome\Frontend\Models\PetExtraInfo;

class PetController extends \Phalcon\Mvc\Controller
{
	public function indexAction()
	{
		$this->view->title = '等待领养的动物';
		$this->view->pets = Pet::find(array("limit" => 20));
		$this->view->hotPets = Pet::find(array("limit" => 6));
	}
}