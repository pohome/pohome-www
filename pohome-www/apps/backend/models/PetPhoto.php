<?php

namespace Pohome\Backend\Models;

class PetPhoto extends \Phalcon\Mvc\Model
{
	public $pet_id;
	public $filename;
	
	public function getSource()
	{
		return 'pet_photo';
	}
}