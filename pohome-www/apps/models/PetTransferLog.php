<?php
    
namespace Pohome\Models;

use Phalcon\Mvc\Model\Validator\StringLength;

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
        return 'PetTransferLog';
    }
    
    public function initialize()
    {
        $this->belongsTo('pet_id', '\Pohome\Models\Pet', 'id', array('alias' => 'pet'));
    }
    
    public function beforeValidationOnCreate()
    {
        $this->created_at = date('Y-m-d H:i:s');
    }
    
    public function validate()
    {
        $this->validate(new StringLength(array(
			'field' => 'description',
			'max' => 400,
		)));
		
		if($this->validationHasFailed() == true) {
			return false;
		}
    }
}