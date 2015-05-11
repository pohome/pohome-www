<?php
	
namespace Pohome\Models;

class ContactRecord extends \Phalcon\Mvc\Model
{
	public $user_id;
	public $adoption_application_id;
	public $title;
	public $content;
	public $sent_at;
	public $message_id;
	public $status;
	
	public function getSource()
	{
		return 'contact_record';
	}
	
	public function initialize()
	{
		$this->useDynamicUpdate(true);
		$this->belongsTo('user_id', '\Pohome\Models\User', 'id', array('alias' => 'user'));
		$this->belongsTo('adoption_application_id', '\Pohome\Models\AdoptionApplication', 'id', array('alias' => 'application'));
	}
	
	public function beforeValidationOnCreate()
	{
		$this->sent_at = date('Y-m-d H:i:s');
	}
	
	public function validation()
	{	
		if($this->validationHasFailed() == true) {
			return false;
		}
	}
}