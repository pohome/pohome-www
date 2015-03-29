<?php
	
namespace Pohome\Frontend\Controllers;

use \Phalcon\Mvc\View;
use \Pohome\Frontend\Models\Blog;

class BlogController extends BaseController
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
		global $blogCatelog;
		$this->view->catelogs = $blogCatelog;
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
		global $blogCatelog;
		$this->view->catelogs = $blogCatelog;
	}
	
	public function catelogAction($catelogId)
	{
    	$this->view->disable();
    	return;
		$catelog = Catelog::findFirst($catelogId);
		$this->view->title = '博客 - ' . $catelog->name;
		$this->view->blogs = Blog::find(array('conditions' => "catelog_id = $catelogId"));
		
		// 生成最热5篇博文
		$this->view->hotStories = Blog::find(array(
			"limit" => 5,
			"order" => "viewed DESC",
		));
		
		// 生成博文分类数据		
		$this->view->catelogs = Catelog::find();
	}
}