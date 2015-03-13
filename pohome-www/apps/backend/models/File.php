<?php

namespace Pohome\Bakcend\Models;

class File extends \Phalcon\Mvc\Model
{
	public $id;
	public $original_filename;
	public $file_type;
	public $file_size;
	public $uploader_id;
	public $uploaded_at;
	
	public function getSource()
	{
		return 'file';
	}
	
	public function initialize()
	{
		$this->useDynamicUpdate(true);
	}

	public function beforeValidationOnCreate()
	{
		$this->upload_at = date('Y-m-d H:i:s');
		$this->uploader_id = $this->session->get('userId');
	}
}