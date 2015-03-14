<?php
    
namespace Pohome\Backend\Controllers;

use Pohome\Backend\Models\User;

class UserController extends \Phalcon\Mvc\Controller
{
    public function newAction()
    {
        if($this->request->isPost()) {
            $user = new User();
            $post = $this->request->getPost();
            
            $user->id = uniqid();
            $user->username = $post['username'];
            $user->password = $this->security->hash($post['password']);
            $user->email = $post['email'];
            
            
            // TODO: 处理用户权限的问题
            
            $user->create();
            
            $this->view->disable();
            echo 'New user created.';
        }
    }
    
    public function listAction()
    {
        $this->view->title = '用户列表';
        $this->view->users = User::find();
    }
    
    public function loginAction()
    {
        if ($this->request->isPost()) {
            $post = $this->request->getPost();
            $username = $post['username'];
            $password = $post['password'];
            
            $user = User::findFirstByUsername($username);
            
            if (!$user) {
                $result = array('field' => 'username', 'type' => '用户名不存在', 'value' => '');
            } else {
                if (!$this->security->checkHash($password, $user->password)) {
                    $result = array('field' => 'password', 'type' => '密码错误', 'value' => '');
                } else {
                    $this->session->set('userId', $user->id);
                    $this->session->set('username', $user->name);
                    $this->session->set('permission', $user->permission);
                    
                    $user->update();
                    
                    $this->response->redirect('/admin');
                }
            }
            
            $this->view->result = $result;
        }
    }
    
    public function logoutAction()
    {
        $this->session->remove('userId');
        $this->session->remove('username');
        $this->session->remove('permission');
        
        $this->response->redirect('/');
    }
}