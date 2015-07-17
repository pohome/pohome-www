<?php
    
namespace Pohome\Models;

class Permission extends \Phalcon\Mvc\Model
{
    public $id;
    public $name;
    public $url;
    public $description;
    
    public function getSource()
    {
        return 'Permission';
    }
    
    public function initialize()
    {
        $this->useDynamicUpdate(true);
    }
}