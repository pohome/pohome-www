<?php
    
namespace Pohome\Frontend\Controllers;

use Pohome\Models\Pet;
use Pohome\Models\AdoptionApplication;
use Phalcon\Mvc\View\Simple as SimpleView;

class AdoptionController extends BaseController
{
    private $formContent;
    
    public function applicationAction($petId)
    {
        $this->view->addition = '<script type="text/javascript" src="/js/jquery.form.js"></script>';
        
        $pet = Pet::findFirst($petId);
        
        // 核验申请的动物是否存在
        if($pet == null) {
            $this->view->setRenderLevel(\Phalcon\Mvc\View::LEVEL_ACTION_VIEW);
            $this->view->pick('adoption/error');
            $this->view->title = '您要领养的动物不存在';
            $this->view->msg = '抱歉，您要领养的动物不存在！';
            return;
        }
        
        // 核验申请的动物是否接受领养
        if(!$pet->adoptable || $pet->status_id > 5) {
            $this->view->disable();
            
            switch($pet->status_id) {
                case 6:
                    echo '抱歉，' . $pet->name . '已被成功领养。';
                    break;
                case 9:
                    echo '抱歉，目前' . $pet->name . '已有预订领养人，近期即将进入新家庭。';
                    break;
                    
                default:
                    echo '抱歉，目前' . $pet->name . '不接受领养';
                    break;
            }
            
            return;
        }
        
        // 核验用户是否已经登录
        if(!$this->session->has('userId')) {
            $this->session->set('returnURL', $_SERVER["REQUEST_URI"]);
            $this->response->redirect('user/login');
        }
        
        $this->view->title = '领养申请 - ' . $pet->name;
        $this->view->pet = $pet;
        
        $path = dirname(__FILE__) . '/../../config/';
        $data = json_decode(file_get_contents($path . '/application.json'));
        
        foreach($data as $sectionName => $sectionFields)
        {
            $this->formContent .= sprintf("<div class=\"ui horizontal divider\">%s</div>\n", $sectionName);
            foreach($sectionFields as $field)
            {
                $func = $field->type . 'Field';
                $this->$func($field);
            }
            
        }
        
        $this->view->formContent = $this->formContent;

        if($this->request->isPost()) {
            $this->view->disable();
            
            $form = json_encode($_POST, JSON_UNESCAPED_UNICODE);
            
            $aa = new AdoptionApplication();
            $aa->applicant_id = $this->session->get('userId');
            $aa->pet_id = $petId;
            $aa->application_form = $form;
            
            $result = $aa->create();
            
            if($result) {
                echo 'success';
                
                // 发送领养申请通知到pohome01@163.net
                $this->sendNofiticationEmail($aa);
            } else {
                echo 'fail';
            }
        }
    }
    
    public function testAction()
    {
        $this->sendNofiticationEmail();
    }
    
    private function sendNofiticationEmail(&$a)
    {
        $pet = Pet::findFirst($a->pet_id);
        $form = get_object_vars(json_decode($a->application_form));
                
        $title = $form['姓名'] . '申请领养' . $pet->name;
        $title = sprintf("『%s』申请领养『%s』 [#%d]", $form['姓名'], $pet->name, 991 + $a->id);
                        
        $view = new SimpleView();
        $view->setViewsDir('../apps/frontend/views/');
        $view->setVars(array(
            'title' => $title,
            'pet' => $pet,
            'form' => $form,
            'id' => $a->id
        ));

        $html = $view->render('adoption/notification');
        
        submail(array(
            'to' => 'pohome01@163.com',
            'from' => 'no-reply@push.pohome.cn',
            'name' => '领养申请',
            'reply' => 'info@pohome.cn',
            'title' => $title,
            'html' => $html
        ));
    }
    
    private function textField(&$field)
    {
        $this->formContent .= sprintf("<div class=\"inline field\">\n");
        $this->formContent .= sprintf("\t<label>%s</label>\n", $field->name);
        $this->formContent .= sprintf("\t<input type=\"%s\" name=\"%s\" />\n", $field->type, $field->name);
        $this->formContent .= sprintf("</div>\n\n");
    }
    
    private function radioField(&$field)
    {
        $fieldId = 'field_' . strip_tags($field->name);
        $this->formContent .= sprintf("<div class=\"inline fields\" id=\"$fieldId\">\n");
        $this->formContent .= sprintf("\t<label>%s</label>\n", $field->name);
        $this->formContent .= sprintf("\t<div class=\"box\">\n");
        foreach($field->option as $o)
        {
            if(property_exists($field, 'multi-line')) {
                $this->formContent .= sprintf("\t\t<div class=\"block field\">\n");
            } else {
                $this->formContent .= sprintf("\t\t<div class=\"field\">\n");
            }
            
            $this->formContent .= sprintf("\t\t\t<div class=\"ui radio checkbox\">\n");
            $this->formContent .= sprintf("\t\t\t\t<input type=\"radio\" name=\"%s\" value=\"%s\" /><label>%s</label>\n", $field->name, $o, $o);
            $this->formContent .= sprintf("\t\t\t</div>\n\t\t</div>\n");
        }
        $this->formContent .= sprintf("\n</div></div>\n\n");
    }
    
    private function checkboxField(&$field)
    {
        $this->formContent .= sprintf("<div class=\"inline fields\">\n");
        $this->formContent .= sprintf("\t<label>%s</label>\n", $field->name);
        $this->formContent .= sprintf("\t<div class=\"box\">\n");
        foreach($field->option as $o)
        {
            $this->formContent .= sprintf("\t\t<div class=\"field\">\n");
            $this->formContent .= sprintf("\t\t\t<div class=\"ui checkbox\">\n");
            $this->formContent .= sprintf("\t\t\t\t<input type=\"checkbox\" name=\"%s[]\" value=\"%s\" /><label>%s</label>\n", $field->name, $o, $o);
            $this->formContent .= sprintf("\t\t\t</div>\n\t\t</div>\n");
        }
        $this->formContent .= sprintf("\t</div>\n</div>\n\n");
    }
    
    private function textareaField(&$field)
    {
        $this->formContent .= sprintf("<div class=\"inline field\">\n");
        $this->formContent .= sprintf("\t<label>%s</label>\n", $field->name);
        $this->formContent .= sprintf("\t<textarea name=\"%s\"></textarea>\n", $field->name);
        $this->formContent .= sprintf("</div>\n\n");
    }
}