<?php
    
namespace Pohome\Models;

use Phalcon\Mvc\Model\Validator\Uniqueness;
use Phalcon\Mvc\Model\Validator\Email;
use Pohome\Validator\MobileValidator;
use Pohome\Validator\UsernameValidator;
use Pohome\Validator\PasswordValidator;

class User extends \Phalcon\Mvc\Model
{
    public $id;
    public $username;
    public $password;
    public $email;
    public $mobile;
    public $user_type;
    public $email_verified;
    public $mobile_verified;
    public $contribution_intension;
    public $permission;
    public $max_allowed_pet_application_num;
    public $max_allowed_pet_post_num;
    public $created_at;
    public $last_login_at;
    public $last_login_ip;
    
    public function getSource()
    {
        return 'User';
    }
    
    public function initialize()
    {
        $this->useDynamicUpdate(true);
        
        $this->hasOne('id', '\Pohome\Models\UserExtraInfo', 'user_id', array('alias' => 'extra'));
        $this->hasMany('id', '\Pohome\Models\UserHasRole', 'user_id', array('alias' => 'role'));
    }
    
    public function hasIntension($intensionId)
    {
        $intension = ServiceIntension::findFirst(array("user_id = $this->id AND intension_id = $intensionId"));
        
        if($intension == false) {
            return false;
        } else {
            return true;
        }
    }
    
    public function validation()
    {
        $this->validate(new Uniqueness(array(
            'field' => 'username',
        )));
        
        $this->validate(new UsernameValidator(array(
            'field' => 'username',
            'min' => 2,
            'max' => 15,
        )));
        
        $this->validate(new PasswordValidator(array(
            'field' => 'password',
        )));
        
        if(!empty($this->email)) {
            
            $this->validate(new Uniqueness(array(
                'field' => 'email',
            )));
            
            $this->validate(new Email(array(
                'field' => 'email'
            )));
        }
        
        if(!empty($this->mobile)) {
            
            $this->validate(new Uniqueness(array(
                'field' => 'mobile',
            )));
            
            $this->validate(new MobileValidator(array(
                'field' => 'mobile',
            )));
        }
        
        if($this->validationHasFailed() == true) {
            return false;
        }
    }
    
    public function beforeValidationOnCreate()
    {
        $this->id = gen_uuid();
        $this->email_verified = 0;
        $this->mobile_verified = 0;
        $this->contribution_intension = 0;
        $this->permission = 0;
        $this->max_allowed_pet_application_num = 3;
        $this->max_allowed_pet_post_num = 3;
        $this->created_at = date('Y-m-d H:i:s');
        $this->last_login_ip = ip2long($_SERVER['REMOTE_ADDR']);
        $this->last_login_at = date('Y-m-d H:i:s');
    }
    
    public function beforeValidationOnUpdate()
    {
        // TODO: 确认是否可以直接用$this->request->getClientAddress(true)来获得访问者的ip地址
        $this->last_login_ip = ip2long($_SERVER['REMOTE_ADDR']);
        $this->last_login_at = date('Y-m-d H:i:s');
    }
    
    public function afterValidation()
    {
        if (preg_match('/^\$2a\$.{56}$/', $this->password) == 0) {
    		$di = \Phalcon\DI::getDefault();
            $this->password = $di->get('security')->hash($this->password);
		}
    }
}