<?php
    
namespace Pohome\Frontend\Controllers;

use \Pohome\Models\Event;

class EventController extends \Phalcon\Mvc\Controller
{
    public function indexAction()
    {
        $this->view->title = '汪汪喵呜孤儿院 - 活动';
        
        $event = Event::findFirst();
        $this->view->currentEvent = $event;
    }
}