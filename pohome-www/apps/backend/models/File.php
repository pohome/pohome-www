<?php

namespace \Pohome\Bakcend\Models;

class File extends \Phalcon\Mvc\Model
{
	public $id;
	public $filename;
	public $path;
	public $size;
	public $uploader_id;
	public $upload_at;

	public function beforeCreate()
	{
		$this->upload_at = date('Y-m-d H:i:s');
		$this->uploader_id = $this->session->get('userId');
	}
}