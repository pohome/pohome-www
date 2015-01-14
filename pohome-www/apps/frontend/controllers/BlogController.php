<?php
	
namespace Pohome\Frontend\Controllers;

use \Pohome\Frontend\Models\Blog;

class BlogController extends \Phalcon\Mvc\Controller
{
	public function indexAction()
	{
		$this->view->title = '汪汪喵呜孤儿院 - 博客';
		$this->view->blogs = Blog::find();
		
	}
	
	public function viewAction($blogId)
	{
		$blog = Blog::findFirst($blogId);
		$this->view->title = $blog->title;
		$this->view->blog = $blog;
	}
}