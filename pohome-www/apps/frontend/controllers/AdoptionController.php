<?php
    
namespace Pohome\Frontend\Controllers;

use Pohome\Frontend\Models\Pet;
use Pohome\Frontend\Models\AdoptionApplication;

class AdoptionController extends BaseController
{
    private $formContent;
    
    public function applicationAction($petId)
    {
        $this->view->setRenderLevel(\Phalcon\Mvc\View::LEVEL_ACTION_VIEW);
        
        $pet = Pet::findFirst($petId);
        
        // 核验申请的动物是否存在
        if($pet == null) {
            $this->view->disable();
            echo '抱歉，您要领养的动物不存在！';
            return;
        }
        
        // 核验申请的动物是否接受领养
        if(!$pet->adoptable) {
            $this->view->disable();
            echo '抱歉，目前' . $pet->name . '不接受领养';
            return;
        }
        
        // 核验用户是否已经登录
        if(!$this->session->has('userId')) {
            $this->session->set('returnURL', $_SERVER["REQUEST_URI"]);
            $this->response->redirect('user/login');
        }
        
        $this->view->title = '领养申请表 - ' . $pet->name;
        
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
            } else {
                echo 'fail';
            }
        }
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
        $this->formContent .= sprintf("<div class=\"inline fields\">\n");
        $this->formContent .= sprintf("\t<label>%s</label>\n", $field->name);
        $this->formContent .= sprintf("\t<div class=\"fields\">\n");
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
        $this->formContent .= sprintf("\t</div>\n</div>\n\n");
    }
    
    private function checkboxField(&$field)
    {
        $this->formContent .= sprintf("<div class=\"inline fields\">\n");
        $this->formContent .= sprintf("\t<label>%s</label>\n", $field->name);
        $this->formContent .= sprintf("\t<div class=\"fields\">\n");
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