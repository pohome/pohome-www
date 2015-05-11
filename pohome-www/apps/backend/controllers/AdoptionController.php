<?php
    
namespace Pohome\Backend\Controllers;

use Pohome\Models\Pet;
use Pohome\Models\AdoptionApplication;
use Pohome\Models\ApplicationComment;
use Pohome\Models\ContactRecord;

class AdoptionController extends BaseController
{   
    public function indexAction()
    {
        $this->view->title = '领养申请表列表 - 汪汪喵呜孤儿院后台管理';
        
        $this->view->breadcrumb = array(
            array(
                'name' => '领养申请表',
                'link' => '/admin/adoption/index'
            ),
            array(
                'name' => '列表',
                'active' => true
            )
        );
        
        $applications = AdoptionApplication::find();
        
        foreach($applications as $a)
        {
            $a->application_form = json_decode($a->application_form);
            $pet = Pet::findFirst($a->pet_id);
            $a->pet_name = $pet->name;
        }
        
        $paginator = new \Phalcon\Paginator\Adapter\Model(array(
            "data" => $applications,
            "limit" => 20,
            "page" => $page
        ));
        
        $this->view->page = $paginator->getPaginate();
    }
    
    public function viewAction($applicationId)
    {
        $this->view->title = '领养申请表审核 - 汪汪喵呜孤儿院后台管理';
        
        $this->view->breadcrumb = array(
            array(
                'name' => '领养申请表',
                'link' => '/admin/adoption/index'
            ),
            array(
                'name' => '审核',
                'active' => true
            )
        );
        
        $application = AdoptionApplication::findFirst($applicationId);
        $this->view->application = $application;
        
        if($this->request->isPost()) {
            $comment = new ApplicationComment();
            
            $comment->user_id = $this->session->get('userId');
            $comment->adoption_application_id = $applicationId;
            $comment->comment = $this->request->getPost('comment');
            $comment->created_at = date('Y-m-d H:i:s');
            
            if($comment->create() == false) {
                $this->view->disable();
                var_dump($comment->getMessages());
            }
        }
        
        $this->view->comments = ApplicationComment::findByAdoptionApplicationId($applicationId);
    }
    
    public function mailAction($applicationId)
    {
        if(!$this->request->isPost()) {
            $this->view->title = '领养申请表回复邮件 - 汪汪喵呜孤儿院后台管理';
            
            $this->view->breadcrumb = array(
                array(
                    'name' => '领养申请表',
                    'link' => '/admin/adoption/index'
                ),
                array(
                    'name' => '回复邮件',
                    'active' => true
                )
            );
            
            $this->view->messages = ContactRecord::find(array(
                "adoption_application_id = '$applicationId'"
            ));
            
            $this->view->application = AdoptionApplication::findFirst($applicationId);
            
            
        } else {
            $this->view->disable();
            
            $post = $this->request->getPost();
            
            $title = $this->request->getPost('title');
            $content = $this->request->getPost('content');
            
            $aa = AdoptionApplication::findFirst($applicationId);
            $form = get_object_vars(json_decode($aa->application_form));
            $email = $form['Email'];
            
            
            
            $result = $this->mail->sendMessage('pohome.cn', array(
                'from' => '汪汪喵呜孤儿院 <contact@pohome.cn>',
                'to' => $email,
                'subject' => $title,
                'text' => $content,
                'o:tracking' => true
            ));
            
            $cc = new ContactRecord();
            $cc->adoption_application_id = $applicationId;
            $cc->user_id = $this->session->get('userId');
            $cc->title = $title;
            $cc->content = $content;
            $cc->message_id = $result->http_response_body->id;
            $cc->status = '提交';
            
            if(!$cc->create()) {
                var_dump($cc->getMessages());
            } else {
                $aa->status = 'PC';
                $aa->update();
                $this->response->redirect('admin/adoption/index');
            }
            
        }
        
    }
}