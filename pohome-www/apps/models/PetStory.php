<?php

namespace Pohome\Models;

class PetStory extends \Phalcon\Mvc\Model
{
	public $pet_id;
	public $blog_id;
	
	public function getSource()
	{
		return 'PetStory';
	}
}