<?php
	
namespace Pohome\Models;

use Phalcon\Mvc\Model\Validator\StringLength;

class Blog extends \Phalcon\Mvc\Model
{
	public $user_id;
	public $adoption_application_id;
	public $type;
	public $opinion;
	public $created_at;
	
	public function getSource()
	{
		return 'contact_record';
	}
	
	public function initialize()
	{
		$this->useDynamicUpdate(true);
	}
	
	public function setOpinion($opinion)
	{
		$this->opinion = strip_tags($opinion);
	}
	
	public function beforeValidationOnCreate()
	{
		$this->user_id = $this->session->get('userId');
		$this->created_at = date('Y-m-d H:i:s');
	}
	
	public function validation()
	{
		$this->validate(new StringLength(array(
			'field' => 'opinion'
		)));
		
		if($this->validationHasFailed() == true) {
			return false;
		}
	}
}