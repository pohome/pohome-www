<?php

namespace Pohome\Frontend\Models;

class Blog extends \Phalcon\Mvc\Model
{
	public $id;
	public $title;
	public $abstract;
	public $content;
	public $feature_image;
	public $catelog_id;
	public $author_id;
	public $draft;
	public $created_at;
	public $published_at;
	public $viewed;
	
	public function beforeValidationOnCreate()
	{
		// TODO: 对于正文的安全处理还需要进一步完善
		$this->abstract = strip_tags($this->abstract);
		$this->content = strip_tags($this->content, '<code><span><div><label><a><br><p><b><i><del><strike><u><img><video><audio><iframe><object><embed><param><blockquote><mark><cite><small><ul><ol><li><hr><dl><dt><dd><sup><sub><big><pre><code><figure><figcaption><strong><em><table><tr><td><th><tbody><thead><tfoot><h1><h2><h3><h4><h5><h6>');
		//$this->author_id = $this->session->get('userId');
		$this->created_at = date('Y-m-d H:i:s');
		$this->viewed = 0;
	}
	
	public function beforeValidationOnUpdate()
	{
		
	}
	
	public function author()
	{
		$user = \Pohome\Backend\Models\User::findFirst("id='$this->author_id'");
		return $user->username;
	}
}