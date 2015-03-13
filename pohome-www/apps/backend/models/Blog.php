<?php

namespace Pohome\Backend\Models;

use Phalcon\Mvc\Model\Validator\StringLength;

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
	public $modified_at;
	public $viewed;
	
	public function getSource()
	{
		return 'blog';
	}
	
	public function initialize()
	{
		$this->useDynamicUpdate(true);
	}
	
	public function validation()
	{
		$this->validate(new StringLength(array(
			'field' => 'title',
			'max' => 20,
		)));
		
		$this->validate(new StringLength(array(
			'field' => 'abstract',
			'max' => 400,
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
		$this->author_id = $this->session->get('userId');
		$this->created_at = date('Y-m-d H:i:s');
		$this->modified_at = date('Y-m-d H:i:s');
		$this->viewed = 0;
	}
		
	public function author()
	{
		return \Pohome\Backend\Models\User::findFirst($this->author_id);
	}
}