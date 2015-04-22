<?php

namespace Pohome\Frontend\Models;

use Pohome\Frontend\Models\File;

class PetPhoto extends \Phalcon\Mvc\Model
{
	public $pet_id;
	public $file_id;
	
	public function getSource()
	{
		return 'pet_photo';
	}
	
	public function getPhotoUrl($size)
	{
    	$file = File::findFirst($this->file_id);
    	return sprintf('/upload/image/%s/%s.%s', $size, $file->id, $file->file_type);
	}
}