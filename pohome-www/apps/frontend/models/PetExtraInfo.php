<?php

namespace Pohome\Frontend\Models;

class PetExtraInfo extends \Phalcon\Mvc\Model
{
	public $pet_id;
	public $character;
	public $health;
	public $notice;
	public $entry_date;
	public $neuter_date;
	public $last_immune_date;
	public $last_kill_insect_date;
	public $last_bath_date;
	public $angel_id;
	
	public function initialize()
	{
		$this->belongsTo("pet_id", "Pohome\Frontend\Models\Pet", "id");
	}

	public function nextImmuneDate()
	{
		return $this->last_immune_date;
	}
	
	public function beforeValidationOnCreate()
	{
		if(empty($this->angel_id))
			$this->angel_id = 0;
	}
}