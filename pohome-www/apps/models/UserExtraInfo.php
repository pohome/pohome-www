<?php

namespace Pohome\Models;

use Pohome\Validator\DatetimeValidator;
use Phalcon\Mvc\Model\Validator\StringLength;

class UserExtraInfo extends \Phalcon\Mvc\Model
{
	public $user_id;
	public $realname;
	public $id_card_num;
	public $birthday;
	public $gender;
	public $level_one_district;
	public $level_two_district;
	public $level_three_district;
	public $street;
	public $qq;
	public $weibo;
	public $taobao;
	public $has_car;
	public $referee_id;
	
	public function getSource()
	{
		return 'user_extra_info';
	}
	
	public function initialize()
	{
		$this->useDynamicUpdate(true);
		
		$this->belongsTo('user_id', '\Pohome\Models\User', 'id', array('alias' => 'user'));
	}
	
	public function validation()
	{
		if(!empty($this->realname)) {
			$this->validate(new RealnameValidator(array(
				'field' => 'realname',
				'min' => 2,
				'max' => 15,
			)));
		}
		
		if(!empty($this->id_card_num)) {
			$this->validate(new IdCardValidator(array(
				'field' => 'id_card_num',
			)));
		}
		
		if(!empty($this->birthday)) {
			$this->validate(new DatetimeValidator(array(
				'field' => 'birthday',
			)));
		}
		
		if(!empty($this->street)) {
			$this->validate(new StringLength(array(
				'field' => 'street',
				'max' => 60,
			)));
		}
		
		if(!empty($this->qq)) {
			$this->validate(new Numericality(array(
				'field' => 'qq',
			)));
		}
		
		if(!empty($this->weibo)) {
			
		}
		
		if(!empty($this->taobao)) {
			
		}
		
		if($this->validationHasFailed() == true) {
			return false;
		}
	}
}