<?php
	
namespace Pohome\Backend\Models;

class User extends \Phalcon\Mvc\Model
{
	public $id;
	public $username;
	public $password;
	public $email;
	public $mobile;
	public $created_at;
	public $last_visit_at;
	public $last_visit_ip;
	
	public function beforeValidationOnCreate()
	{
		$this->id = uniqid();
		$this->created_at = date('Y-m-d H:i:s');
		$this->last_visit_ip = ip2long($_SERVER['REMOTE_ADDR']);
		$this->last_visit_at = date('Y-m-d H:i:s');
	}
	
	public function beforeValidationOnUpdate()
	{
		// TODO: 确认是否可以直接用$this->request->getClientAddress(true)来获得访问者的ip地址
		$this->last_visit_ip = ip2long($_SERVER['REMOTE_ADDR']);
		$this->last_visit_at = date('Y-m-d H:i:s');
	}
}