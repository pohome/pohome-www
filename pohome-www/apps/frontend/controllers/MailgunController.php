<?php
    
namespace Pohome\Frontend\Controllers;

use Pohome\Models\ContactRecord;

class MailgunController extends \Phalcon\Mvc\Controller
{
    public function webhookAction()
    {
        $this->view->disable();
        $post = $this->request->getPost();
        
        if($this->verify($post['token'], $post['timestamp'], $post['signature'])) {
            $msgId = $post['Message-Id'];
            $event = $post['event'];
                    
            switch($event) {
                case 'opened':
                    $status = '已阅';
                    break;
                
                case 'bounced':
                    $status = '退回';
                    break;
                    
                case 'dropped':
                    $status = '失败';
                    break;
                    
                case 'delivered':
                    $status = '投递成功';
                    break;
            }
                    
            if(!empty($status)) {
                $cc = ContactRecord::findFirst(array(
                    "message_id = '$msgId'"
                ));
                
                if($cc) {
                    $cc->status = $status;
                    $cc->update();
                }
            }
        }
    }
    
    private function verify($token, $timestamp, $signature)
    {
        $data = $timestamp . $token;
        
        // TODO:需要把Mailgun的API KEY保存到统一的位置
        return hash_hmac('sha256', $data, 'key-aae0bf1cde210918f71cee58ce5b2485') == $signature;
    }
}