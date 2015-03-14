<?php
	
namespace Pohome\Backend\Models;

use Phalcon\Mvc\Model\Validator\Numericality;
use Phalcon\Mvc\Model\Validator\StringLength;

class EventApplication extends \Phalcon\Mvc\Model
{
	public $id;
	public $event_id;
	public $applicant_id;
	public $number_of_people;
	public $departure_from;
	public $has_car;
	public $remark;
	public $applied_at;
	public $contacted;
	public $approved;
	public $discard;
	
	public function getSource()
	{
		return 'event_application';
	}
	
	public function initialize()
	{
		$this->useDynamicUpdate(true);
	}
	
	public function setRemark($remark)
	{
		$this->remark = strip_tags($remark);
	}
	
	public function validation()
	{
		$this->validate(new Numericality(array(
			'field' => 'number_of_people',
		)));
		
		$this->validate(new StringLength(array(
			'field' => 'departure_from',
			'max' => 40,
		)));
		
		$this->validate(new StringLenght(array(
			'field' => 'remark',
			'max' => 400
		)));
		
		if($this->validationHasFailed() == true) {
			return false;
		}
	}
	
	public function beforeValidationOnCreate()
	{
		$this->applicant_id = $this->session->get('userId');
		$this->applied_at = date('Y-m-d H:i:s');
		$this->contacted = false;
		$this->approved = false;
		$this->discard = false;
	}
}