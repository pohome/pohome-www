<?php

namespace Pohome\Frontend\Models;

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

	public function getFilename()
	{
    	return $this->id . '.' . $this->file_type;
	}
	
	public function deleteRealFile()
	{
    	$baseUrl = $_SERVER['DOCUMENT_ROOT'] . '/upload/image/';
    	
    	for ($i = 64; $i <= 2048; $i *= 2) {
        	$filename = $baseUrl . $i . '/' . $this->getFilename();
        	if (file_exists($filename)) {
            	unlink($filename);
        	}
    	}
	}

	public function beforeValidationOnCreate()
	{
		$this->uploaded_at = date('Y-m-d H:i:s');
	}
}