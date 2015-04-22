<?php

namespace Pohome\Frontend\Models;

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