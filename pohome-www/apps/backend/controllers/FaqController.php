<?php

namespace Pohome\Backend\Controllers;

use Pohome\Backend\Models\Faq;

class FaqController extends BaseController
{
    public function indexAction($page = 1)
    {
        $this->view->title = '常见问答 - 汪汪喵呜孤儿院后台管理';
        
        $this->view->breadcrumb = array(
            array(
                'name' => '常见问答',
                'link' => '/admin/faq/index'
            ),
            array(
                'name' => '列表',
                'active' => true
            )
        );
        
        $faqs = Faq::find();
        
        $paginator = new \Phalcon\Paginator\Adapter\Model(array(
            "data" => $faqs,
            "limit" => 20,
            "page" => $page
        ));
        
        $this->view->page = $paginator->getPaginate();
    }
    
    public function newAction()
    {
        global $faqCatelog;
        $this->view->catelogs = $faqCatelog;
        
        $this->view->title = '添加常见问答 - 汪汪喵呜孤儿院管理后台';
        
        $this->view->breadcrumb = array(
            array(
                'name' => '常见问答',
                'link' => '/admin/faq/index'
            ),
            array(
                'name' => '添加新问答',
                'active' => true
            )
        );
        
        if($this->request->isPost()) {
            $post = $this->request->getPost();
            
            $post['creator_id'] = $this->session->get('userId');
            $faq = new Faq();
            $this->saveData($faq, $post, 'create');
            
            $this->view->disable();
            echo json_encode($this->result, JSON_UNESCAPED_UNICODE);
        }
    }
    
    public function editAction($faqId)
    {
        $this->view->title = '编辑问答 - 汪汪喵呜孤儿院';
        
        $this->view->breadcrumb = array(
            array(
                'name' => '常见问答',
                'link' => '/admin/faq/index'
            ),
            array(
                'name' => '编辑问答',
                'active' => true
            )
        );
        
        global $faqCatelog;
        $this->view->catelogs = $faqCatelog;
        
        
        $faq = Faq::findFirst($faqId);
        $this->view->faq = $faq;
        
        if($this->request->isPost()) {
            $post = $this->request->getPost();
            
            $this->saveData($faq, $post, 'update');
            
            $this->view->disable();
            var_dump($this->result);
        }
    }
    
    public function deleteAction($faqId)
    {
        $faq = Faq::findFirst($faqId);
        $faq->delete();
        $this->response->redirect('admin/faq/index');
    }
}