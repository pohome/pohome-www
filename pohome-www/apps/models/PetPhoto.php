<?php

namespace Pohome\Models;

class PetPhoto extends \Phalcon\Mvc\Model
{
	public $pet_id;
	public $file_id;
	
	public function getSource()
	{
		return 'pet_photo';
	}
}