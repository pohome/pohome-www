<?php
    
namespace Pohome\Models;

class PetTransferLog extends \Phalcon\Mvc\Model
{
    public $id;
    public $pet_id;
    public $from;
    public $destination;
    public $creator_id;
    public $created_at;
    
    public function getSource()
    {
        return 'pet_transfer_log';
    }
    
    public function initialize()
    {
        $this->belongsTo('pet_id', '\Pohome\Models\Pet', 'id', array('alias' => 'pet'));
    }
    
}