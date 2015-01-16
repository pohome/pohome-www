<?php
	
namespace Pohome\Frontend\Controllers;

use Pohome\Frontend\Models\Blog;

class IndexController extends \Phalcon\Mvc\Controller
{
	public function indexAction()
	{
		$this->view->title = '汪汪喵呜孤儿院';
		$this->view->blogs = Blog::find(array(
			"limit" => 2,
			"order" => "published_at DESC"
		));
		
	}
}