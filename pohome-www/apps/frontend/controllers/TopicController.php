<?php
    
namespace Pohome\Frontend\Controllers;

class TopicController extends BaseController
{
    public function indexAction($topicName)
    {
        switch($topicName)
        {
            case '/ying-jia-jun':
                $this->yingjiajun();
                break;
        }
    }
    
    public function waterfallAction($page)
    {
        $this->view->setRenderLevel(\Phalcon\Mvc\View::LEVEL_ACTION_VIEW);
        
        $query = $this->modelsManager->createQuery("SELECT Pet.name, PetPhoto.file_id FROM \Pohome\Models\Pet Pet inner join \Pohome\Models\PetPhoto PetPhoto on Pet.id = PetPhoto.pet_id WHERE Pet.name LIKE '瀛%'");
        $files = $query->execute();
        
        //$files = \Pohome\Models\File::find(array('order' => 'uploaded_at DESC'));
        
        $paginator = new \Phalcon\Paginator\Adapter\Model(array(
            'data' => $files,
            'limit' => 12,
            'page' => $page
        ));
        
        $this->view->page = $paginator->getPaginate();
    }
    
    private function yingjiajun()
    {
        $this->view->pick('topic/ying-jia-jun');
        $this->view->pets = \Pohome\Models\Pet::find("name LIKE '瀛%'");
        $this->view->addition = '<link rel="stylesheet" type="text/css" href="/css/yingjiajun.css"><script type="text/javascript" src="/js/waterfall.min.js"></script>';
    }
}