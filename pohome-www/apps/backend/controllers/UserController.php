<?php
    
namespace Pohome\Backend\Controllers;

use Pohome\Backend\Models\User;


class UserController extends BaseController
{
    public function registerAction()
    {        
        if($this->request->isPost()) {
            $user = new User();
            $post = $this->request->getPost();
                        
            //$post['user_type'] = 'individual';
            $this->saveData($user, $post, 'create');
            
            $this->view->disable();
            echo json_encode($this->result, JSON_UNESCAPED_UNICODE);
        }
    }
    
    public function indexAction($page = 1)
    {
        $this->view->title = '用户列表 - 汪汪喵呜孤儿院';
        
        $this->view->breadcrumb = array(
            array(
                'name' => '用户',
                'link' => '/admin/event/index'
            ),
            array(
                'name' => '列表',
                'active' => true
            )
        );
        
        $paginator = new \Phalcon\Paginator\Adapter\Model(array(
            'data' => User::find(),
            'limit' => 10,
            'page' => $page,
        ));
        
        $this->view->page = $paginator->getPaginate();
    }
    
    public function loginAction()
    {
        $this->view->setRenderLevel(\Phalcon\Mvc\View::LEVEL_ACTION_VIEW);
        
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
                    $this->session->set('username', $user->username);
                    $this->session->set('permission', $user->permission);
                    
                    $user->update();
                    
                    if ($this->session->has('_url')) {
                        
                        $url = substr($this->session->get('_url'), 1);
                        $this->session->remove('_url');
                        $this->response->redirect($url);
                        
                    } else {
                        
                        $this->response->redirect('admin/pet/new');
                    }
                }
            }
            
            //$this->view->result = $result;
            $this->view->disable();
            echo json_encode($result, JSON_UNESCAPED_UNICODE);
        }
    }
    
    public function logoutAction()
    {
        $this->session->remove('userId');
        $this->session->remove('username');
        $this->session->remove('permission');
        
        $this->response->redirect('admin/user/login');
    }
}