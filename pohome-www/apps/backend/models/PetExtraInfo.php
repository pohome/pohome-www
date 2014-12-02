<?php

namespace Pohome\Backend\Models;

class PetExtraInfo extends \Phalcon\Mvc\Model
{
	public $pet_id;
	public $character;
	public $health;
	public $notice;
	public $entry_date;
	public $neuter_date;
	public $last_immune_date;
	public $angel_id

	public function nextImmuneDate()
	{
		return $this->last_immune_date;
	}
}