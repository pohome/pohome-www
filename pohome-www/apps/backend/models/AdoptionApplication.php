<?php
	
namespace Pohome\Backend\Models;

class AdoptionApplication extends \Phalcon\Mvc\Model
{
	public $id;
	public $pet_id;
	public $applicant_id;
	public $application_form;
	public $applied_at;
	public $status;
	public $closed;
	
	public function getSource()
	{
		return 'adoption_application';
	}
	
	public function initialize()
	{
		$this->useDynamicUpdate(true);
	}
	
	public function beforeValidationOnCreate()
	{
		$this->applicant_id = $this->session->get('userId');
		$this->applied_at = date('Y-m-d H:i:s');
		$this->status = 'S';
		$this->closed = false;
	}
}