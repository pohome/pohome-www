<?php
	
namespace Pohome\Frontend\Controllers;

use \Phalcon\Mvc\View;
use \Pohome\Models\Blog;

class BlogController extends BaseController
{
	public function indexAction($page = 1)
	{
		$this->view->title = '汪汪喵呜孤儿院 - 博客列表';
		$this->view->menu_blog = true;
		
		$blogs = Blog::find(array(
     		"draft = false",
			"order" => "published_at DESC"
		));
		
		$paginator = new \Phalcon\Paginator\Adapter\Model(array(
    		'data' => $blogs,
    		'limit' => 20,
    		'page' => $page
		));
		
		$this->view->page = $paginator->getPaginate();
		
		// 生成最热5篇博文
		$this->view->hotStories = Blog::find(array(
			"limit" => 5,
			"order" => "viewed DESC",
		));
		
		// 生成博文分类数据
		global $blogCatelog;
		$this->view->catelogs = $blogCatelog;
		
		if($this->session->has('username')) {
    		$this->view->userId = $this->session->get('userId');
    		$this->view->username = $this->session->get('username');
		}
	}
	
	public function viewAction($blogId)
	{
		$blog = Blog::findFirst($blogId);
				
		// 更新博客阅读量
		$blog->viewed++;
		$blog->update();
		
		$this->view->title = $blog->title;
		$this->view->menu_blog = true;
		$this->view->blog = $blog;
		
		// 生成最热5篇博文
		$this->view->hotStories = Blog::find(array(
			"limit" => 5,
			"order" => "viewed DESC",
		));
		
		
		// 生成博文分类数据		
		global $blogCatelog;
		$this->view->catelogs = $blogCatelog;
		
		if($this->session->has('username')) {
    		$this->view->userId = $this->session->get('userId');
    		$this->view->username = $this->session->get('username');
		}
	}
	
	public function catelogAction($catelogId)
	{
    	global $blogCatelog;
    	
		$this->view->title = '博客 - ' . $blogCatelog[$catelogId];
		$this->view->menu_blog = true;
		
		$this->view->blogs = Blog::find(array(
		    "catelog_id = $catelogId"
        ));
		
		// 生成最热5篇博文
		$this->view->hotStories = Blog::find(array(
			"limit" => 5,
			"order" => "viewed DESC",
		));
		
		// 生成博文分类数据		
		$this->view->catelogs = $blogCatelog;
		
		if($this->session->has('username')) {
    		$this->view->userId = $this->session->get('userId');
    		$this->view->username = $this->session->get('username');
		}
	}
}