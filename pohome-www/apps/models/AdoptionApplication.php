<?php
	
namespace Pohome\Models;

class AdoptionApplication extends \Phalcon\Mvc\Model
{
	public $id;
	public $pet_id;
	public $applicant_id;
	public $application_form;
	public $applied_at;
	public $status;
	public $closed;
	public $form;
	
	public function getSource()
	{
		return 'AdoptionApplication';
	}
	
	public function initialize()
	{
		$this->useDynamicUpdate(true);
		
		$this->belongsTo('pet_id', '\Pohome\Models\Pet', 'id', array('alias' => 'pet'));
		$this->belongsTo('applicant', '\Pohome\Model\User', 'id', array('alias' => 'applicant'));
	}
	
	public function getPet()
	{
    	return Pet::findFirst($this->pet_id);
	}
	
	public function getForm()
	{
    	if(is_null($this->form)) {
        	$this->form = get_object_vars(json_decode($this->application_form));
    	}
    	
    	return $this->form;
	}
	
	public function getStatus()
	{
    	switch($this->status)
    	{
        	case 'S':
        	    return '提交';
            
            case 'PC':
                return '电话沟通';
                
            case 'I':
                return '面试';
                
            case 'A':
                return '接受';
                
            case 'D':
                return '回绝';
    	}
	}
	
	public function beforeValidationOnCreate()
	{
		$this->applied_at = date('Y-m-d H:i:s');
		$this->status = 'S';
		$this->closed = 0;
	}
}