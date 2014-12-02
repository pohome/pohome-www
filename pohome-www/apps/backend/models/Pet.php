<?php
	
namespace Pohome\Backend\Models;

class Pet extends \Phalcon\Mvc\Model
{
	public $id;
	public $name;
	public $species;
	public $gender;
	public $breed;
	public $birthday;
	public $body_size;
	public $neutered;
	public $location;
	public $status;
	public $adoptable;
	public $draft;
	public $viewed;
	public $favorite;
	public $creator_id;
	public $created_at;
	public $modified_at;

	public function beforeCreate()
	{
		$this->creator_id = $this->session->get('userId');
		$this->created_at = date('Y-m-d H:i:s');
		$this->viewed = 0;
		$this->favorite = 0;
	}

	public function beforeUpdate()
	{
		$this->modified_at = date('Y-m-d H:i:s');
	}
}