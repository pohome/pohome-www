<?php

namespace \Pohome\Bakcend\Models;

class Log extends \Phalcon\Mvc\Model
{
	public $id;
	public $type;
	public $sub_type;
	public $datetime;
	public $creator_id;
	public $content;

	public function beforeCreate()
	{
		$this->datetime = date('Y-m-d H:i:s');
		$this->creator_id = $this->session->get('userId');
	}
}