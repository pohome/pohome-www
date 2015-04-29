<?php

namespace Pohome\Models;
    
class ApplicationComment extends \Phalcon\Mvc\Model
{
    public $id;
    public $user_id;
    public $adoption_application_id;
    public $comment;
    public $created_at;
    
    public function getUsername()
    {
        $user = User::findFirst($this->user_id);
        return $user->username;
    }
    
    public function getTimePassed()
    {
        $datetime = new \DateTime($this->created_at);
        $now = new \DateTime();
        $interval = $datetime->diff($now);
        $str = '';
       
        if($interval->y > 0) {
            $str .= $interval->y . '年';
        }
        
        if($interval->m > 0) {
            $str .= $interval->m . '月';
        }
        
        if($interval->d > 0) {
            $str .= $interval->d . '天';
        }
        
        if($interval->h > 0) {
            $str .= $interval->h . '小时';
        }
        
        if($interval->i > 0) {
            $str .= $interval->i . '分钟';
        }
        
        if($interval->s > 0) {
            $str .= $interval->s . '秒前';
        }
        
        return $str;
    }
}