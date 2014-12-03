<?php
	
namespace Pohome\Backend\Controllers;
	
class AuthController extends \Phalcon\Mvc\Controller
{
	public function loginAction()
	{
				
		if($this->request->isPost()) {

			$this->view->disable();
						
			$result = array(
				'hasError' => false,
				'errorMsg' => array(),
				'errorField' => array(),
				'url' => ''
			);
			
			// 防止跨脚本攻击
			if(!$this->security->checkToken()) {
				echo '请不要非法攻击我们！';
				die();
			}
			
			// 验证用户信息
			$username = $this->request->getPost('username');
			$password = $this->request->getPost('password');
			
			// 检查用户名是否存在
			$user = \Pohome\Backend\Models\Users::findFirstByUsername($username);
						
			if(!$user) {
				// 用户不存在
				$result['hasError'] = true;
				array_push($result['errorMsg'], '未找到指定用户信息，请检查您是否正确输入了用户名！');
				array_push($result['errorField'], 'username');

				echo json_encode($result);
				return;
			} 

			if(!$this->security->checkHash($password, $user->password)) {
				// 密码错误
				$result['hasError'] = true;
				array_push($result['errorMsg'], '用户名和密码错误，请检查您的输入。');
				$result['errorField'] = array('username', 'password');
				
				echo json_encode($result);
				return;
			} 

			// 用户名密码正确
			$result['hasError'] = false;
			$result['url'] = '/function.php';
			
			$user->update();
			
			$this->session->set('userId', $user->id);
			$this->session->set('username', $user->username);
			
			echo json_encode($result);
			
		} else {
			
			$this->view->setRenderLevel(\Phalcon\Mvc\View::LEVEL_ACTION_VIEW);
			$this->view->setVar('title', '汪汪喵呜孤儿院 - 后台管理系统');
			
			// 表单防跨域攻击
			$this->view->setVar('tokenKey', $this->security->getTokenKey());
			$this->view->setVar('token', $this->security->getToken());
			
		}
	}
	
	public function logoutAction()
	{
		
	}
}