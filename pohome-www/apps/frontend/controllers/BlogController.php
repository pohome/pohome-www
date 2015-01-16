<?php
	
namespace Pohome\Frontend\Controllers;

use \Pohome\Frontend\Models\Blog;
use \Pohome\Frontend\Models\Catelog;

class BlogController extends \Phalcon\Mvc\Controller
{
	public function indexAction()
	{
		//$this->view->disable();
		
		$this->view->title = '汪汪喵呜孤儿院 - 博客';
		$this->view->blogs = Blog::find(array(
			"limit" => 10,
			"order" => "published_at DESC"
		));
		
		$this->view->hotStories = Blog::find(array(
			"limit" => 5,
			"order" => "viewed DESC",
		));
		
		
		// 生成博文分类数据
		$catelogs = Catelog::find();
		$catelogStats = array();
		
		foreach($catelogs as $catelog)
		{
			$name = $catelog->name;
			$id = $catelog->id;
			$count = Blog::count(array(
				"catelog_id = $id"
			));
			$c['id'] = $id;
			$c['name'] = $name;
			$c['count'] = $count;
			
			array_push($catelogStats, $c);
		}
		
		$this->view->catelogs = $catelogStats;
	}
	
	public function viewAction($blogId)
	{
		$blog = Blog::findFirst($blogId);
		$this->view->title = $blog->title;
		$this->view->blog = $blog;
	}
}