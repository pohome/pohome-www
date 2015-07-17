<?php
    
namespace Pohome\Frontend\Controllers;

use \Pohome\Models\User;
use \Pohome\Models\Event;
use \Pohome\Models\EventApplication;

class EventController extends BaseController
{
    public function indexAction()
    {
        $this->view->title = '汪汪喵呜孤儿院 - 活动';
        
        $event = Event::findFirst();
        $this->view->event = $event;
        
        if($this->session->has('userId')) {
            $this->view->user = User::findFirst($this->session->get('userId'));
            $this->view->isLogin = 'true';
            $this->view->addition = '<script type="text/javascript" src="/js/jquery.form.js"></script>';
        } else {
            $this->view->isLogin = 'false';
        }
    }
    
    public function applicationAction($eventId)
    {
        $this->view->disable();
        
        if($this->request->isPost()) {
            
            if(!$this->session->has('userId')) {
                echo 'failure';
                return;
            }
            
            $post = $this->request->getPost();
            $user = User::findFirst($this->session->get('userId'));
            $application = new EventApplication();
            
            $user->mobile = $post['mobile'];
            
            $application->event_id = $eventId;
            $application->applicant_id = $user->id;
            $application->number_of_people = $post['number_of_people'];
            $application->departure_from = $post['departure_from'];
            $application->has_car = $post['has_car'];
            $application->remark = $post['remark'];
            
            $user->save();
            $application->save();
            
            foreach($application->getMessages() as $msg)
            {
                var_dump($msg);
            }
            
            echo 'success';
            
        }
    }
}