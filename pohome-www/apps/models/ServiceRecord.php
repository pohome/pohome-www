<?php
	
namespace Pohome\Models;

use Phalcon\Mvc\Model\Validator\StringLength;
use Phalcon\Mvc\Model\Validator\Numericality;
use Pohome\Validator\DatetimeValidator;
	
class ServiceRecord extends \Phalcon\Mvc\Model
{
	public $id;
	public $user_id;
	public $description;
	public $date;
	public $contribution_hour;
	public $creator_id;
	public $created_at;
	
	public function getSource()
	{
		return 'ServiceRecord';
	}
	
	public function initialize()
	{
		$this->useDynamicUpdate(true);
		
		$this->belongsTo('user_id', '\Pohome\Models\User', 'id', array('alias' => 'user'));
		$this->belongsTo('creator_id', '\Pohome\Models\User', 'id', array('alias' => 'creator'));
	}
	
	public function beforeValidationOnCreate()
	{
		$this->creator_id = $this->session->get('userId');
		$this->created_at = date('Y-m-d H:i:s');
	}
	
	public function validation()
	{
		$this->validate(new StringLength(array(
			'field' => 'description',
			'max' => 50,
		)));
		
		$this->validate(new DatetimeValidator(array(
			'field' => 'date'
		)));
		
		$this->validate(new Numericality(array(
			'field' => 'contribution_hour',
		)));
		
		if($this->validationHasFailed() == true) {
			return false;
		}
	}
}