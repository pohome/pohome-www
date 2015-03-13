<?php
	
use Phalcon\Mvc\Model\Validator\Numericality;
	
class PohomePetExtraData extends \Phalcon\Mvc\Model
{
	public $pet_id;
	public $entry_date;
	public $location_id;
	public $status_id;
	public $angel_id;
	
	public function getSource()
	{
		return 'pohome_pet_extra_data';
	}
	
	public function initialize()
	{
		$this->useDynamicUpdate(true);
	}
	
	public function validation()
	{
		$this->validate(new DatetimeValidator(array(
			'field' => 'entry_data',
		)));
		
		if(!empty($this->angel_id)) {
			$this->validate(new Numericality(array(
				'field' => 'angel_id',
			)));
		}
		
		if($this->validationHasFailed() == true) {
			return false;
		}
	}
}