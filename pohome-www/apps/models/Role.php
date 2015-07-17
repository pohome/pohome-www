<?php
    
namespace Pohome\Models;

class Role extends \Phalcon\Mvc\Model
{
    public $id;
    public $title;
    public $description;
    
    public function getSource()
    {
        return 'Role';
    }
    
    public function initialize()
    {
        $this->useDynamicUpdate(true);
    }
}