<?php
	
namespace Pohome\Backend\Models;

class Users extends \Phalcon\Mvc\Model
{
	public $id;
	public $username;
	public $password;
	public $email;
	public $mobile;
	public $realname;
	public $identity_card_num;
	public $birthday;
	public $gender;
	public $province;
	public $city;
	public $qq;
	public $weibo_id;
	public $taobao_id;
	public $weixin_id;
	public $referee_id;
	public $last_visit_at;
	public $last_visit_ip;
	
	public function initialize()
	{
		$this->skipAttributes(array('created_at'));
	}
	
	public function beforeSave()
	{
		// 在校验过非空和唯一之后才会调用这个函数
		echo 'before save';
		return true;
	}
	
	public function beforeValidationOnCreate()
	{
		echo 'before validation on create' . '<br />';
		return true;
	}
	
	public function validation()
	{
		$this->validate(new \Phalcon\Mvc\Model\Validator\Uniqueness(
			array(
				'field' => 'username',
				'message' => 'The username must be unique'
			)
		));
		
		$this->validate(new \Phalcon\Mvc\Model\Validator\Uniqueness(
			array(
				'field' => 'username',
				'message' => 'The username must be unique'
			)
		));
		
		return $this->validationHasFailed() != true;
	}
}