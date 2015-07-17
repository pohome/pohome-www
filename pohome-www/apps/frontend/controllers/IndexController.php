<?php
	
namespace Pohome\Frontend\Controllers;

use Pohome\Models\Blog;
use Pohome\Models\Pet;

class IndexController extends BaseController
{
	public function indexAction()
	{
		$this->view->title = '汪汪喵呜孤儿院';
		$this->view->menu_frontpage = true;
		
		$this->view->blogs = Blog::find(array(
			"limit" => 5,
			"order" => "published_at DESC",
			"draft = 0"
		));
		
		$this->view->adoptionStory = Blog::findFirst(array(
    		"catelog_id = 1",
    		"order" => "published_at DESC"
		));
		
		$this->view->pets = Pet::find(array(
		    "limit" => 9, 
		    "order" => "created_at DESC",
		    "status_id < 6 AND adoptable = 1",
	    ));
	}
}