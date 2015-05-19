<?php
	
namespace Pohome\Models;

use Pohome\Validator\DatetimeValidator;

class MedicalRecord extends \Phalcon\Mvc\Model
{
	public $id;
	public $pet_id;
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
		
		$this->belongsTo('pet_id', '\Pohome\Models\Pet', 'id', array('alias' => 'pet'));
		$this->belongsTo('creator_id', '\Pohome\Models\User', 'id', array('alias' => 'creator'));
	}
	
	public function validation()
	{
		$this->validate(new DatetimeValidator(array(
			'field' => 'happened_at',
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