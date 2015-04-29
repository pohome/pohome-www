<?php
	
namespace Pohome\Models;

class MedicalRecord extends \Phalcon\Mvc\Model
{
	public $id;
	public $pet_id;
	public $type;
	public $description;
	public $location_id;
	public $happened_at;
	public $creator_id;
	public $created_at;
	
	public function getSource()
	{
		return 'medical_record';
	}
	
	public function initialize()
	{
		$this->useDynamicUpdate(true);
	}
	
	public function validation()
	{
		$this->validate(new DatetimeValidator(array(
			'field' => 'happend_at',
		)));
		
		if($this->validationHasFailed() == true) {
			return false;
		}
	}
	
	public function beforeValidationOnCreate()
	{
		$this->creator_id = $this->session->get('userId');
		$this->created_at = date('Y-m-d H:i:s');
	}
}