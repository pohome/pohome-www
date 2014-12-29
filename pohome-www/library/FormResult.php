<?php

namespace Pohome;

class FormResult
{
	public $hasErr = false;
	public $errField = array();
	public $errMsg = array();
	
	public function add($field, $msg)
	{
		$this->hasErr = true;

		$tmp = explode(',', $field);
		foreach($tmp as $f) {
			array_push($this->errField, $f);
		}
		
		array_push($this->errMsg, $msg);
	}
}