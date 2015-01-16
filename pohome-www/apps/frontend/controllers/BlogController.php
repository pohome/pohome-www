<?php
	
namespace Pohome\Frontend\Controllers;

use \Pohome\Frontend\Models\Blog;
use \Pohome\Frontend\Models\Catelog;

class BlogController extends \Phalcon\Mvc\Controller
{
	public function indexAction()
	{
		$this->view->title = '博客';
		$this->view->blogs = Blog::find(array(
			"limit" => 10,
			"order" => "published_at DESC"
		));
		
		// 生成最热5篇博文
		$this->view->hotStories = Blog::find(array(
			"limit" => 5,
			"order" => "viewed DESC",
		));
		
		
		// 生成博文分类数据		
		$this->view->catelogs = Catelog::find();
	}
	
	public function viewAction($blogId)
	{
		$blog = Blog::findFirst($blogId);
		
		// 更新博客阅读量
		$blog->viewed++;
		$blog->update();
		
		$this->view->title = $blog->title;
		$this->view->blog = $blog;
		
		// 生成最热5篇博文
		$this->view->hotStories = Blog::find(array(
			"limit" => 5,
			"order" => "viewed DESC",
		));
		
		
		// 生成博文分类数据		
		$this->view->catelogs = Catelog::find();
	}
}