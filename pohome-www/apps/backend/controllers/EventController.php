<?php
    
namespace Pohome\Backend\Controllers;

use Pohome\Backend\Models\Event;

class EventController extends BaseController
{
    public function indexAction()
    {
        $this->view->title = '活动列表 - 汪汪喵呜孤儿院后台管理';
                
        $this->view->breadcrumb = array(
            array(
                'name' => '活动',
                'link' => '/admin/event/index'
            ),
            array(
                'name' => '列表',
                'active' => true
            )
        );
        
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
        $this->view->title = '添加新活动 - 汪汪喵呜孤儿院后台管理';
        
        $this->view->breadcrumb = array(
            array(
                'name' => '活动',
                'link' => '/admin/event/index'
            ),
            array(
                'name' => '添加新活动',
                'active' => true
            )
        );
        
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
    
    public function editAction($eventId)
    {
        $this->view->title = '编辑活动 - 汪汪喵呜孤儿院后台管理';
        
        $this->view->breadcrumb = array(
            array(
                'name' => '活动',
                'link' => '/admin/event/index'
            ),
            array(
                'name' => '编辑活动',
                'active' => true
            )
        );
        
        global $eventType;
        $this->view->eventType = $eventType;
        $this->view->event = Event::findFirst($eventId);
        
        if ($this->request->isPost()) {
            
            $this->view->disable();
            
            $post = $this->request->getPost();
            $event = Event::findFirst($eventId);
            $this->saveData($event, $post, 'update');
        }
    }
}