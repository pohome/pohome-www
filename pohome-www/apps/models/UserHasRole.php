<?php
    
namespace Pohome\Models;

class UserHasRole extends \Phalcon\Mvc\Model
{
    public $user_id;
    public $role_id;
    
    public function getSource()
    {
        return 'UserHasRole';
    }
    
    public function initialize()
    {
        $this->useDynamicUpdate(true);        
    }
}