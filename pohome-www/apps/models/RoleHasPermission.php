<?php
    
namespace Pohome\Models;

class RoleHasPermission extends \Phalcon\Mvc\Model
{
    public $permission_id;
    public $role_id;
    
    public function getSource()
    {
        return 'RoleHasPermission';
    }
    
    public function initialize()
    {
        $this->useDynamicUpdate(true);        
    }
}