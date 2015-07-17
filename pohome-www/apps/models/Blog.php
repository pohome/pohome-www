<?php

namespace Pohome\Models;

use Phalcon\Mvc\Model\Validator\StringLength;
use Pohome\Validator\DatetimeValidator;

class Blog extends \Phalcon\Mvc\Model
{
	public $id;
	public $title;
	public $content;
	public $abstract;
	public $feature_image;
	public $author_id;
	public $catelog_id;
	public $draft;
	public $created_at;
	public $published_at;   // 显示出来的是published_at记录的日期
	public $modified_at;
	public $viewed;
	
	public function getSource()
	{
		return 'Blog';
	}
	
	public function initialize()
	{
		$this->useDynamicUpdate(true);
		
		$this->belongsTo('author_id', '\Pohome\Models\User', 'id', array('alias' => 'author'));
	}
	
	public function validation()
	{
		$this->validate(new StringLength(array(
			'field' => 'title',
			'max' => 50,
		)));
		
		$this->validate(new StringLength(array(
			'field' => 'abstract',
			'max' => 400,
		)));
		
		$this->validate(new DatetimeValidator(array(
    		'field' => 'published_at'
		)));
		
		if($this->validationHasFailed() == true) {
			return false;
		}
	}
	
	public function beforeValidationOnCreate()
	{
		// TODO: 对于正文的安全处理还需要进一步完善
		$this->abstract = strip_tags($this->abstract);
		$this->content = strip_tags($this->content, '<code><span><div><label><a><br><p><b><i><del><strike><u><img><video><audio><iframe><object><embed><param><blockquote><mark><cite><small><ul><ol><li><hr><dl><dt><dd><sup><sub><big><pre><code><figure><figcaption><strong><em><table><tr><td><th><tbody><thead><tfoot><h1><h2><h3><h4><h5><h6>');
		$this->created_at = date('Y-m-d H:i:s');
		$this->modified_at = date('Y-m-d H:i:s');
		$this->viewed = 0;
	}
		
	public function author()
	{
		return \Pohome\Models\User::findFirst($this->author_id);
	}
}