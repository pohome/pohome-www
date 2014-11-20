<?php
	
namespace Pohome\Backend\Models;

class Pets extends \Phalcon\Mvc\Model
{
	public $id;
	public $name;
	public $avatar;
	public $species;
	public $gender;
	public $breed;
	public $birthday;
	public $body_size;
	public $character;
	public $health;
	public $neutered;
	public $adoption_notice;
	public $adoptable;
	public $draft;
	public $viewed;
	public $favorite;
	public $creator_id;
	public $created_at;
	public $modified_at;
	
	public function validation()
	{
		
	}
}