<?php
    
namespace Pohome\Models;

class PetStatusChangeLog extends \Phalcon\Mvc\Model
{
    public $id;
    public $pet_id;
    public $creator_id;
    public $old_status;
    public $new_status;
    public $created_at;
    
    public function getSource()
    {
        return 'PetStatusChangeLog';
    }
    
    public function initialize()
    {
        $this->belongsTo('pet_id', '\Pohome\Models\Pet', 'id', array('alias' => 'pet'));
    }
}