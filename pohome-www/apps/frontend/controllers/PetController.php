<?php

namespace Pohome\Frontend\Controllers;

use Pohome\Models\Pet;
use Pohome\Models\PetPhoto;
use Pohome\Models\Faq;

class PetController extends BaseController
{
	public function indexAction($page = 1)
	{
		$this->view->title = '汪汪喵呜孤儿院 - 动物列表';
		
		if($this->request->isGet()) {
    		$query = $this->request->getQuery();
    		$this->view->condition = json_encode($query, JSON_UNESCAPED_UNICODE);
    		
    		$uri = $this->request->getUri();
    		$pos = strpos($uri, '?');
    		if($pos) {
        		$this->view->queryString = substr($uri, $pos);
    		} else {
        		$this->view->queryString = '?';
    		}
            
            $conditions = array();
    		$body_color = 0;
    		$eye_color = 0;
    		
    		foreach($query as $k => $v)
    		{
        		if($k != '_url') {
            		if($k == 'body_color') {
                		foreach($v as $c)
                		{
                    		$body_color = $body_color | $c;
                		}            		
            		} elseif($k == 'eye_color') {
                		foreach($v as $c) {
                    		$eye_color |= $c;
                		}
            		} else {
                		if($v != 'ALL') {
                    		array_push($conditions, $k . '="' . $v . '"');
                		}
            		}
        		}
    		}
		}
		
		array_push($conditions, "status_id < 6 OR status_id = 6 OR status_id = 9");
				
		if(!array_key_exists('sort_by', $query)) {
    		$this->view->sort_by = 'created_at';
    		$sort_by = 'created_at';
		} else {
    		$sort_by = $query['sort_by'];
    		$this->view->sort_by = $sort_by;
		}

		$pets = Pet::find(array(
            join($conditions, ' AND '), 
		    "order" => sprintf('%s DESC', $sort_by)
	    ));	
		
		$paginator = new \Phalcon\Paginator\Adapter\Model(array(
			'data' => $pets,
			'limit' => 9,
			'page' => $page
		));
		
		$this->view->page = $paginator->getPaginate();
	}
	
	public function viewAction($petId)
	{
		$this->view->menu_pet = true;
		
		$pet = Pet::findFirst($petId);
		
		$pp = PetPhoto::find(array("pet_id = '$petId'"));
		
		$pet->viewed++;
		$pet->update();
		
		$this->view->pet = $pet;
		$this->view->pp = $pp;
		
		$this->view->title = $pet->name;
		$this->view->recommends = Pet::find(array("order" => "rand()", "limit" => 6));
		
		if($this->session->has('username')) {
    		$this->view->userId = $this->session->get('userId');
    		$this->view->username = $this->session->get('username');
		}
	}
}