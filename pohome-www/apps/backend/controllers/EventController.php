<?php
    
namespace Pohome\Backend\Controllers;

use Pohome\Backend\Models\Event;

class EventController extends BaseController
{
    public function indexAction()
    {
        $this->view->title = '活动列表 - 汪汪喵呜孤儿院';
        $events = Event::find(array(
            'order' => 'created_at DESC'
        ));
        
        $paginator = new \Phalcon\Paginator\Adapter\Model(array(
            "data" => $events,
            "limit" => 20,
            "page" => $page
        ));
        
        $this->view->page = $paginator->getPaginate();
    }
    
    public function newAction()
    {
        global $eventType;
        $this->view->eventType = $eventType;
        
        if ($this->request->isPost()) {
            
            $this->view->disable();
            
            $post = $this->request->getPost();
            $post['creator_id'] = $this->session->get('userId');
            $event = new Event();
            
            $this->saveData($event, $post, 'create');
        }
    }
    
    public function editAction()
    {
        
    }
}