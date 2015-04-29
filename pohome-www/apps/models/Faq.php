<?php

namespace Pohome\Models;

use Phalcon\Mvc\Model\Validator\StringLength;

class Faq extends \Phalcon\Mvc\Model
{
	public $id;
	public $question;
	public $answer;
	public $catelog_id;
	public $creator_id;
	public $created_at;
	
	public function getSource()
	{
		return 'faq';
	}
	
	public function initialize()
	{
		$this->useDynamicUpdate(true);
		
		$this->belongsTo('creator_id', '\Pohome\Models\User', 'id', array('alias' => 'creator'));
	}
	
	public function getCatelogName()
	{
    	global $faqCatelog;
    	return $faqCatelog[$this->catelog_id];
	}
	
	public function validation()
	{
		$this->validate(new StringLength(array(
			'field' => 'question',
			'max' => 100,
		)));
		
		$this->validate(new StringLength(array(
			'field' => 'answer',
			'max' => 400,
		)));
		
		if($this->validationHasFailed() == true) {
			return false;
		}
	}
	
	public function beforeValidationOnCreate()
	{
		$this->created_at = date('Y-m-d H:i:s');
	}
}