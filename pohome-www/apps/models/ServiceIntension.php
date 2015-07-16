<?php
    
namespace Pohome\Models;

class ServiceIntension extends \Phalcon\Mvc\Model
{
    public $user_id;
    public $intension_id;

    public function getSource()
    {
        return 'ServiceIntension';
    }
    
    public function initialize()
    {
        $this->useDynamicUpdate(true);
    }
}