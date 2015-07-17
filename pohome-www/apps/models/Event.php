<?php
	
namespace Pohome\Models;

use Phalcon\Mvc\Model\Validator\StringLength;
use Phalcon\Mvc\Model\Validator\Numericality;
use Pohome\Validator\DatetimeValidator;

class Event extends \Phalcon\Mvc\Model
{
	public $id;
	public $title;
	public $begin_at;
	public $end_at;
	public $deadline;
	public $location;
	public $content;
	public $member_limit;
	public $event_type_id;
	public $creator_id;
	public $created_at;
	
	public function getSource()
	{
		return 'Event';
	}
	
	public function initialize()
	{
		$this->useDynamicUpdate(true);
		
		$this->belongsTo('creator_id', '\Pohome\Models\User', 'id', array('alias' => 'creator'));
	}
	
	public function getDeadlineDate()
	{
    	return date('Y.n.j', strtotime($this->deadline));
	}
	
	public function getEventMonth()
	{
    	return date('M', strtotime($this->begin_at));
	}
	
	public function getEventTime()
	{
    	$date = date('Y年n月j日', strtotime($this->begin_at));
    	$beginAt = date('G:i', strtotime($this->begin_at));
    	$endAt = date('G:i', strtotime($this->end_at));
    	
    	return $date . ' ' . $beginAt . ' - ' . $endAt;
	}
		
	public function deadlinePassed()
	{
    	$deadline = strtotime($this->deadline);
    	if(time() > $deadline) {
        	return 1;
    	} else {
        	return 0;
    	}
	}
	
	public function passed()
	{
    	if(time() > strtotime($this->end_at)) {
        	return 1;
    	} else {
        	return 0;
    	}
	}
	
	public function isFull()
	{
    	if(!empty($this->member_limit)) {
        	$approved = EventApplication::count("event_id = $this->id AND approved = 1");
            if($approved >= $this->member_limit) {
                return 1;
            } else {
                return 0;
            }
    	} else {
        	return 0;
    	}
	}
	
	public function applied($userId)
	{
    	if(EventApplication::findFirst("applicant_id = $userId AND event_id = $this->id")) {
        	return 1;
    	} else {
    	    return 0;
	    }
	}
		
	public function creator()
	{
    	$user = User::findFirst($this->creator_id);
    	return $user->username;
	}
	
	private function validation()
	{
		$this->validate(new StringLength(array(
			'field' => 'title',
			'max' => 20,
		)));
		
		$this->validate(new DatetimeValidator(array(
			'field' => 'begin_at'
		)));
		
		$this->validate(new DatetimeValidator(array(
			'field' => 'end_at'
		)));
		
		$this->validate(new DatetimeValidator(array(
			'field' => 'deadline'
		)));
		
		$this->validate(new StringLength(array(
			'field' => 'location',
			'max' => 20,
		)));
		
		$this->validate(new Numericality(array(
			'field' => 'member_limit'
		)));
		
		if($this->validationHasFailed() == true) {
			return false;
		}
	}
	
	private function beforeValidationOnCreate()
	{
		$this->content = strip_tags($this->content, '<code><span><div><label><a><br><p><b><i><del><strike><u><img><video><audio><iframe><object><embed><param><blockquote><mark><cite><small><ul><ol><li><hr><dl><dt><dd><sup><sub><big><pre><code><figure><figcaption><strong><em><table><tr><td><th><tbody><thead><tfoot><h1><h2><h3><h4><h5><h6>');
		$this->created_at = date('Y-m-d H:i:s');
	}
}