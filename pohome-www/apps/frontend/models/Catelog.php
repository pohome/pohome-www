<?php
	
namespace Pohome\Frontend\Models;

class Catelog extends \Phalcon\Mvc\Model
{
	public $id;
	public $name;
	
	public function countBlog()
	{
		return Blog::count(array("catelog_id = $this->id"));
	}
}