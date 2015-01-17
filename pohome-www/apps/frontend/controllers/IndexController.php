<?php
	
namespace Pohome\Frontend\Controllers;

use Pohome\Frontend\Models\Blog;
use Pohome\Frontend\Models\Pet;

class IndexController extends \Phalcon\Mvc\Controller
{
	public function indexAction()
	{
		$this->view->title = '汪汪喵呜孤儿院';
		$this->view->blogs = Blog::find(array(
			"limit" => 2,
			"order" => "published_at DESC"
		));
		$this->view->adoptionStory = Blog::findFirst(array("catelog_id = 3"));
		$this->view->pets = Pet::find(array("limit" =>10));
	}
}