<?php
	
namespace Pohome\Backend\Models;

class Event extends \Phalcon\Mvc\Model
{
	public $id;
	public $title;
	public $begin_at;
	public $end_at;
	public $deadline；
	public $location;
	public $content;
	public $member_limit;
	public $event_type_id;
	public $creator_id;
	public $created_at;
	
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
		
		$this->validate(new DatetimeValidator(array(
			'field' => 'begin_at'
		)));
		
		$this->validate(new DatetimeValidator(array(
			'field' => 'end_at'
		)));
		
		$this->validate(new DatetimeValidator(array(
			'field' => 'deadline'
		)));
		
		$this->validate(new StringLength(array(
			'field' => 'location',
			'max' => 20,
		)));
		
		$this->validate(new Numericality(array(
			'field' => 'member_limit'
		)));
		
		if($this->validationHasFailed() == true) {
			return false;
		}
	}
	
	public function beforeValidationOnCreate()
	{
		$this->content = strip_tags($this->content, '<code><span><div><label><a><br><p><b><i><del><strike><u><img><video><audio><iframe><object><embed><param><blockquote><mark><cite><small><ul><ol><li><hr><dl><dt><dd><sup><sub><big><pre><code><figure><figcaption><strong><em><table><tr><td><th><tbody><thead><tfoot><h1><h2><h3><h4><h5><h6>');
		$this->creator_id = $this->session->get('userId');
		$this->created_at = date('Y-m-d H:i:s');
	}
}