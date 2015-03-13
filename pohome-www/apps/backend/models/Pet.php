<?php
	
namespace Pohome\Backend\Models;

use Phalcon\Mvc\Model\Validator\StringLength;
use Phalcon\Mvc\Model\Validator\Numericality;

class Pet extends \Phalcon\Mvc\Model
{
	public $id;
	public $name;
	public $species;
	public $gender;
	public $breed;
	public $size;
	public $birthday;
	public $friendly_index;
	public $energy_index;
	public $adaptability_index;
	public $notice;
	public $story;
	public $draft;
	public $creator_id;
	public $belongs_to_pohome;
	public $viewed;
	public $adoptable;
	public $created_at;
	public $modified_at;
	
	public function getSource()
	{
		return 'pet';
	}
	
	public function initialize()
	{
		$this->useDynamicUpdate(true);
	}
	
	public function getAge()
	{
		$today = new \DateTime();
		$birthday = new \DateTime($this->birthday);
		$interval = $today->diff($birthday);
		$age = '';
		if($interval->y > 0) {
			$age .= $interval->y . '岁';
		}
		
		if($interval->m > 0) {
			$age .= $interval->m . '个月';
		}
		
		if($interval->d > 0) {
			$age .= $interval->d . '天';
		}
		
		return $age;
	}
	
	public function getSpecies()
	{
		if($this->species == 'D') {
			return '狗';
		} elseif($this->species == 'C') {
			return '猫';
		} else {
			return '未知';
		}
	}
	
	public function getGender()
	{
		if($this->gender == 'M') {
			return '雄性';
		} elseif($this->gender == 'F') {
			return '雌性';
		} else {
			return '未知';
		}
	}
	
	public function setBirthday($birthday)
	{
		if(preg_match("/^d{4}-d{1,2}-d{1,2}$/", $str)) {
			$this->birthday = $birthday;
		} else {
			$this->birthday = $this->parseAge($birthday);
		}
	}

	public function beforeValidationOnUpdate()
	{
		$this->modified_at = date('Y-m-d H:i:s');
	}
	
	public function beforeValidationOnCreate()
	{
		$this->creator_id = $this->session->get('userID');
		$this->created_at = date('Y-m-d H:i:s');
		$this->modified_at = date('Y-m-d H:i:s');
		$this->viewed = 0;
	}
	
	public function validation()
	{
		$this->validate(new PetnameValidator(array(
			'field' => 'name',
			'min' => 2,
			'max' => 20,
		)));
		
		$this->validate(new StringLength(array(
			'field' => 'breed',
			'max' => 20,
		)));
		
		$this->validate(new StringLength(array(
			'field' => 'notice',
			'max' => 400,
		)));
		
		$this->validate(new Numericality(array(
			'field' => 'friendly_index',
		)));
		
		$this->validate(new Numericality(array(
			'field' => 'energy_index',
		)));
		
		$this->validate(new Numericality(array(
			'field' => 'adaptability_index',
		)));
		
		$this->validate(new DatetimeValidator(array(
			'field' => 'birthday',
		)));
		
		
		if($this->validationHasFailed() == true) {
			return false;
		}
	}
	
	public function parseAge($str)
	{
		$match = array();
		$year = 0;
		$month = 0;
		
		// XX岁的格式
		if(preg_match("/^(\d{1,2})岁$/", $str, $match)) {
			$year = $match[1];
		} else if(preg_match("/^(\d{1,2})个月$/", $str, $match)) {
			$month = $match[1];
		} else if(preg_match("/^(\d{1,2})岁零(\d{1,2})个月$/", $str, $match)) {
			$year = $match[1];
			$month = $match[2];
		} else {
			return false;
		}
		
		$date = new \DateTime();
		$interval = new \DateInterval('P' . $year . 'Y' . $month . 'M');
		$date->sub($interval);
		return $date->format('Y-m-d');
	}
}