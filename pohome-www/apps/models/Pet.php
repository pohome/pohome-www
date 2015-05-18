<?php
	
namespace Pohome\Models;

use Phalcon\Mvc\Model\Validator\StringLength;
use Phalcon\Mvc\Model\Validator\Numericality;
use Pohome\Validator\PetnameValidator;
use Pohome\Validator\DatetimeValidator;

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
	public $entry_date;
	public $location_id;
	public $status_id;
	public $angel_id;
	public $neutered;
	public $taobao_url;
	public $draft;
	public $creator_id;
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
		
		$this->belongsTo('creator_id', '\Pohome\Models\User', 'id', array('alias' => 'creator'));
		$this->hasMany('id', '\Pohome\Models\PetTransferLog', 'pet_id', array('alias' => 'transferLog'));
		$this->hasMany('id', '\Pohome\Models\PetStatusChangeLog', 'pet_id', array('alias' => 'statusChangeLog'));
		$this->hasMany('id', '\Pohome\Models\MedicalRecord', 'pet_id', array('alias' => 'medicalRecord'));
		$this->hasMany('id', '\Pohome\Models\AdoptionApplication', 'pet_id', array('alias' => 'application'));
	}
	
	public function setName($name)
	{
    	$this->name = strip_tags($name);
	}
	
	public function setBreed($breed)
	{
    	$this->breed = strip_tags($breed);
	}
	
	public function setNotice($notice)
	{
    	$this->notice = strip_tags($notice);
	}
		
	public function getAge()
	{
		$today = new \DateTime();
		$birthday = new \DateTime($this->birthday);
		$interval = $today->diff($birthday);
		$age = '';
		if($interval->y > 0) {
			$age .= $interval->y . '岁';
		} elseif($interval->m > 0) {
			$age .= $interval->m . '个月';
		} elseif($interval->d > 0) {
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
	
	public function setStory($story)
	{
    	$this->story = $this->cleanTags($story);
	}
	
	public function setBirthday($birthday)
	{
		if(preg_match("/^\d{4}-\d{1,2}-\d{1,2}$/", $birthday)) {
			$this->birthday = $birthday;
		} else {
			$this->birthday = $this->parseAge($birthday);
		}
	}
	
	public function beforeValidationOnCreate()
	{
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
	
	private function cleanTags($str)
    {
        return strip_tags($str, '<code><span><div><label><a><br><p><b><i><del><strike><u><img><video><audio><iframe><object><embed><param><blockquote><mark><cite><small><ul><ol><li><hr><dl><dt><dd><sup><sub><big><pre><code><figure><figcaption><strong><em><table><tr><td><th><tbody><thead><tfoot><h1><h2><h3><h4><h5><h6>');
    }
}