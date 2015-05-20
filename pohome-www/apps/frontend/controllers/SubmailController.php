<?php
    
namespace Pohome\Frontend\Controllers;

//use Pohome\Models\ContactRecord;

class SubmailController extends \Phalcon\Mvc\Controller
{
    public function subhookAction()
    {
        $this->view->disable();
        
        $post = $this->request->getPost();
        
        $key = '6689e6a3560772af1d93581f8a0734d5';
        
        if($this->verify($post['token'], $post['signature'])) {
            $this->debug->log($post['events']);
            $this->debug->log($post['message_id']);
        }
/*
        if($this->verify($post['token'], $post['timestamp'], $post['signature'])) {
            $this->debug->log('receive mailgun webhook call:'.$post['event']);
            $msgId = $post['Message-Id'];
            $event = $post['event'];
                    
            switch($event) {
                case 'opened':
                    $status = '已阅';
                    $msgId = '<' . $post['message-id'] . '>';
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
                    if($cc->update() == false) {
                        $this->debug->log(json_encode($cc->getMessages()), \Phalcon\Logger::ERROR);
                    }
                } else {
                    $this->debug->log($msgId);
                    foreach($post as $k => $v) {
                        $this->debug->log($k . ' => ' . $v);
                    }
                }
            }
        }
*/
    }
    
    private function verify($token, $signature)
    {
        $key = '6689e6a3560772af1d93581f8a0734d5';
        return md5($token.$key) == $signature;
    }
}