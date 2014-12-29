<?php
	
namespace Pohome\Backend\Controllers;

class PetController extends \Phalcon\Mvc\Controller
{
	public function initialize()
	{
		// 通过判断session中有没有userId项来判断用户是否已登录
		echo $this->session->get('userId');
		
	}
	
	private function cleanTags($str)
	{
		return strip_tags($str, '<code><span><div><label><a><br><p><b><i><del><strike><u><img><video><audio><iframe><object><embed><param><blockquote><mark><cite><small><ul><ol><li><hr><dl><dt><dd><sup><sub><big><pre><code><figure><figcaption><strong><em><table><tr><td><th><tbody><thead><tfoot><h1><h2><h3><h4><h5><h6>');
	}
	
	private function checkPermission($userId, $permission)
	{
		// 首先检查session中是否保存了userId
		if(is_null($this->session->get('userId'))) {
			// 跳转到登录页面
			$this->response->redirect('admin/auth/login');
		} else {
			$userId = $this->session->get('userId');
			$p = $this->session->get('permissions');
			
			// 如果session中尚无权限信息，则从数据库中取出该用户拥有的全部权限
			if(is_null($p)) {
				$p = $this->getAllPermissions($userId);
				$this->session-set('permissions', $p);
			}
			
			return in_array($permission, $p);
		}
		
	}
	
	private function getAllPermissions($userId)
	{
		$permissions = array();
		
		$sql = "select name from permissions where permissions.id in (select permission_id from role_has_permissions where role_id in (select role_id from user_has_roles where user_id=$userId))";
		$resultset = $this->db->query($sql);
		
		foreach($resultset->fetchAll() as $r) {
			array_push($permissions, $r['name']);
		}
		
		return $permissions;
	}
}