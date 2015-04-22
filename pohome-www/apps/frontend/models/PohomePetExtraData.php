<?php
    
namespace Pohome\Frontend\Models;
	
use Phalcon\Mvc\Model\Validator\Numericality;
use Pohome\Validator\DatetimeValidator;
	
class PohomePetExtraData extends \Phalcon\Mvc\Model
{
	public $pet_id;
	public $entry_date;
	public $location_id;
	public $status_id;
	public $angel_id;
	public $neutered;
	public $taobao_url;
	
	public function getSource()
	{
		return 'pohome_pet_extra_data';
	}
	
	public function initialize()
	{
		$this->useDynamicUpdate(true);
	}
	
	public function getTaobaoUrl()
	{
    	if($this->taobao_url != 0) {
        	return 'http://item.taobao.com/item.htm?id=' . $this->taobao_url;
    	} else {
        	return null;
    	}
	}
	
	public function validation()
	{
		$this->validate(new DatetimeValidator(array(
			'field' => 'entry_date',
		)));
		
		if(!empty($this->angel_id)) {
			$this->validate(new Numericality(array(
				'field' => 'angel_id',
			)));
		} else {
    		$this->angel_id = null;
		}
		
		if($this->validationHasFailed() == true) {
			return false;
		}
	}
}