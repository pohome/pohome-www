<?php

namespace Pohome\Backend\Models;

class PetPhoto extends \Phalcon\Mvc\Model
{
	public $id;
	public $pet_id;
	public $filename;
	public $priority;
}