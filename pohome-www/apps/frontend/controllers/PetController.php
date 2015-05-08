<?php

namespace Pohome\Frontend\Controllers;

use Pohome\Models\Pet;
use Pohome\Models\PohomePetExtraData;
use Pohome\Models\PetPhoto;
use Pohome\Models\Faq;

class PetController extends BaseController
{
	public function indexAction($page = 1)
	{
		$this->view->title = '汪汪喵呜孤儿院 - 动物列表';
		$this->view->menu_pet = true;
		
		$a = array();
    		
		$query = $this->request->getQuery();
		
		if(!array_key_exists('sort_by', $query)) {
    		$this->view->sort_by = 'created_at';
		} else {
    		$sort_by = $query['sort_by'];
    		$this->view->sort_by = $sort_by;
		}
		
		if(!array_key_exists('species', $query) || $query['species'] == 'ALL') {
    		$this->view->species = 'ALL';
		} else {
    		$species = $query['species'];
    		$a[] = sprintf('species = "%s"', $species);
    		$this->view->species = $species;
		}
		
		if(!array_key_exists('gender', $query) || $query['gender'] == 'ALL') {
    		$this->view->gender = 'ALL';
		} else {
    		$gender = $query['gender'];
    		$a[] = sprintf('gender = "%s"', $gender);
    		$this->view->gender = $gender;
		}
		
		if(!array_key_exists('size', $query) || $query['size'] == 'ALL') {
    		$this->view->size = 'ALL';
		} else {
    		$size = $query['size'];
    		$a[] = sprintf('size = "%s"', $size);
    		$this->view->size = $size;
		}

		$pets = Pet::find(array(join($a, ' AND '), "order" => sprintf('%s DESC', $sort_by)));

		$uri = $this->request->getURI();
		$i = strpos($uri, '?');
		if($i) {
    		$this->view->query = substr($uri, $i);
		} else {
    		$this->view->query = '';
		}		
		
		$paginator = new \Phalcon\Paginator\Adapter\Model(array(
			'data' => $pets,
			'limit' => 10,
			'page' => $page
		));
		
		$this->view->page = $paginator->getPaginate();
		$this->view->hotPets = Pet::find(array("limit" => 6));
		
		$this->view->faqs = Faq::find(array(
            'limit' => 10
        ));
		
		if($this->session->has('username')) {
    		$this->view->userId = $this->session->get('userId');
    		$this->view->username = $this->session->get('username');
		}
	}
	
	public function viewAction($petId)
	{
		$this->view->menu_pet = true;
		
		$pet = Pet::findFirst($petId);
		$pped = PohomePetExtraData::findFirst($petId);
		
		$pp = PetPhoto::findByPetId($petId);
		
		$pet->viewed++;
		$pet->update();
		
		$this->view->pet = $pet;
		$this->view->pped = $pped;
		$this->view->pp = $pp;
		
		$this->view->title = $pet->name;
		$this->view->recommends = Pet::find(array("order" => "rand()", "limit" => 5));
		
		if($this->session->has('username')) {
    		$this->view->userId = $this->session->get('userId');
    		$this->view->username = $this->session->get('username');
		}
	}
}