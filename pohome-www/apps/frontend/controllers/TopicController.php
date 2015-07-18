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
                
        $handle = opendir($_SERVER['DOCUMENT_ROOT'] . '/image/yingjiajun/photo/');
        
        $count = 1;
        $fileArray = array();
        while ( false !== ($file = readdir ( $handle )) ) {
            if($file != '.' && $file != '..') {
                array_push($fileArray, array('name' => $file));
                $count++;
            }
        }
        
        closedir($handle);
        
        sort($fileArray);
        
        $paginator = new \Phalcon\Paginator\Adapter\NativeArray(array(
            'data' => $fileArray,
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