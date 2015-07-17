<?php
    
namespace Pohome\Models;

class PetAdoptionLog extends \Phalcon\Mvc\Model
{
    public $id;
    public $pet_id;
    public $application_id;
    public $type;
    public $datetime;
    public $agreement_id;
    
    public function getSource()
    {
        return 'PetAdoptionLog';
    }
    
    public function initialize()
    {
        $this->useDynamicUpdate(true);
        
        $this->belongsTo('pet_id', '\Pohome\Models\Pet', 'id', array('alias' => 'pet'));
        $this->belongsTo('application_id', '\Pohome\Models\AdoptionApplication', 'id', array('alias' => 'application'));
    }
    
    public function beforeValidationOnCreate()
    {
        $this->datetime = date('Y-m-d H:i:s');
        $this->agreement_id = $this->generateAgreementId();
    }
    
    private function generateAgreementId()
    {
        $year = date('Y');
        
    	$begin_date = sprintf("%d-1-1", $year);
    	$end_date = sprintf("%d-1-1", $year + 1);
    	
    	$count = PetAdoptionLog::count("datetime > '$begin_date' AND datetime < '$end_date'");
    	return sprintf("%d%05d", $year, $count + 1);
    }
}