<?php

namespace Pohome\Models;

class Favorite extends \Phalcon\Mvc\Model
{
	public $pet_id;
	public $user_id;
	
	public function getSource()
	{
		return 'Favorite';
	}
}