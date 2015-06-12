<?php
    
namespace Pohome\Backend\Controllers;

use Pohome\Models\Pet;
use Pohome\Models\AdoptionApplication;
use Pohome\Models\ApplicationComment;
use Pohome\Models\ContactRecord;
use Pohome\Models\PetAdoptionLog;

class AdoptionController extends BaseController
{   
    public function indexAction($page = 1)
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
    
    public function agreeAction($applicationId)
    {
        $this->view->disable();

        $application = AdoptionApplication::findFirst($applicationId);
        $pet = Pet::findFirst($application->pet_id);
        
        // 事务开始
        $this->db->begin();
        
        $pet->adoptable = 0;
        $pet->status_id = 6; // 已领养
        $pet->location_id = 100; // 领养家庭

        $pet->update();
                
        $pal = new PetAdoptionLog();
        $pal->pet_id = $pet->id;
        $pal->application_id = $applicationId;
        $pal->type = '领养';
        $pal->create();
        
        $application->status = 'A';
        $application->update();
        
        // 事务结束
        $this->db->commit();
        $this->response->redirect('/admin/adoption/index');
    }
    
    public function printAgreementAction($applicationId)
    {
        $this->view->setRenderLevel(\Phalcon\Mvc\View::LEVEL_ACTION_VIEW);
        
        $application = AdoptionApplication::findFirst($applicationId);
        $this->view->pal = PetAdoptionLog::findFirst("application_id = $applicationId");
        $this->view->pet = Pet::findFirst($application->pet_id);
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
            
            
            
            submail(array(
                'from' => 'no-reply@push.pohome.cn',
                'name' => '汪汪喵呜孤儿院',
                'to' => $email,
                'title' => $title,
                'html' => $content
            ));
            
            $cc = new ContactRecord();
            
            $cc->adoption_application_id = $applicationId;
            $cc->user_id = $this->session->get('userId');
            $cc->title = $title;
            $cc->content = $content;
            //$cc->message_id = $result->http_response_body->id;
            $cc->message_id = 'not available';
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