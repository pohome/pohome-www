<?php
	
namespace Pohome\Backend\Controllers;
	
class AuthController extends \Phalcon\Mvc\Controller
{
	public function loginAction()
	{
				
		if($this->request->isPost()) {
						
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
			
			// 防止暴力破解
			// TODO: 完成随机验证码机制
			if($this->session->has('wrongPasswordTimes') && 
			   $this->session->get('wrongPasswordTimes') > 5) {
				
				// 超过5次输入错误则需要额外输入验证码
				
			}
			
			// 验证用户信息
			$username = $this->request->getPost('username');
			$password = $this->request->getPost('password');
			
			// 用户名和密码不能为空
			if(empty($username)) {
				$result['hasError'] = true;
				array_push($result['errorMsg'], '用户名不能为空，请检查您的输入！');
				array_push($result['errorField'], 'username');
			}
			
			if(empty($password)) {
				$result['hasError'] = true;
				array_push($result['errorMsg'], '密码不能为空，请检查您的输入！');
				array_push($result['errorField'], 'password');
			}
			
			if($result['hasError']) {
				echo json_encode($result);
				$this->view->disable();
				return;
			}
						
			$user = \Pohome\Backend\Models\Users::findFirstByUsername($username);
						
			if(!$user) {
				// 用户不存在
				$result['hasError'] = true;
				array_push($result['errorMsg'], '未找到指定用户信息，请检查您是否正确输入了用户名！');
				array_push($result['errorField'], 'username');
				echo json_encode($result);
				$this->view->disable();
				return;
			} else {
				if(!$this->security->checkHash($password, $user->password)) {
					// 密码错误
					$result['hasError'] = true;
					array_push($result['errorMsg'], '用户名和密码错误，请检查您的输入。');
					$result['errorField'] = array('username', 'password');
					
					echo json_encode($result);
					$this->view->disable();
					return;
				} else {
					// 用户名密码正确
					$result['hasError'] = false;
					$result['url'] = '/function.php';
					
					// 更新用的最后登录时间和ip
					$user->last_visit_at = date('Y-m-d H:i:s', $_SERVER['REQUEST_TIME']);
					$user->last_visit_ip = ip2long($_SERVER['REMOTE_ADDR']);
					
					$user->save();
					
					$this->session->set('userId', $user->id);
					$this->session->set('username', $user->username);
					
					echo json_encode($result);
					$this->view->disable();
					return;
				}
			}
			
			$this->view->disable();
			return;
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