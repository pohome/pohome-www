<?php
	
namespace Pohome\Frontend\Controllers;

use Pohome\Frontend\Models\Blog;
use Pohome\Frontend\Models\Pet;

class IndexController extends BaseController
{
	public function indexAction()
	{
		$this->view->title = '汪汪喵呜孤儿院';
		$this->view->blogs = Blog::find(array(
			"limit" => 2,
			"order" => "published_at DESC"
		));
		$this->view->adoptionStory = Blog::findFirst();
		$this->view->pets = Pet::find(array("limit" =>5));
	}
}