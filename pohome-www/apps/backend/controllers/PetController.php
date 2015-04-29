<?php
	
namespace Pohome\Backend\Controllers;

use Pohome\Models\Pet;
use Pohome\Models\PohomePetExtraData;
use Pohome\Models\PetPhoto;

class PetController extends BaseController
{
    public function initialize()
    {
        parent::initialize();
    }	
    
	public function indexAction($page = 1)
	{
		$this->view->title = '动物列表 - 汪汪喵呜孤儿院后台管理';
		
		$this->view->breadcrumb = array(
            array(
                'name' => '动物',
                'link' => '/admin/pet/index'
            ),
            array(
                'name' => '列表',
                'active' => true
            )
        );
        
		$pets = Pet::find();
		
		$paginator = new \Phalcon\Paginator\Adapter\Model(array(
            "data" => $pets,
            "limit" => 20,
            "page" => $page
        ));
        
        $this->view->page = $paginator->getPaginate();
	}
	
	public function newAction()
	{
    	global $petStatus, $petLocation;
		
		$this->view->title = '新添动物信息 - 汪汪喵呜孤儿院后台管理';
		
		$this->view->breadcrumb = array(
            array(
                'name' => '动物',
                'link' => '/admin/pet/index'
            ),
            array(
                'name' => '添加新动物信息',
                'active' => true
            )
        );
		
		$this->view->location = $petLocation;
		$this->view->status = $petStatus;
		
		// 处理提交的表单数据
		if($this->request->isPost()) {
			
			$this->view->disable();
			
			$post = $this->request->getPost();
			
			$id = gen_uuid();
						
			$pet = new Pet();
			$post['id'] = $id;
			$post['creator_id'] = $this->session->get('userId');
			if(empty($post['angel_id'])) {
    			$post['angel_id'] = null;
			}
			$this->saveData($pet, $post, 'create');
			
			$pped = new PohomePetExtraData();
			$post['pet_id'] = $id;
			$post['taobao_url'] = $this->parseTaobaoId($post['taobao_url']);
			$this->saveData($pped, $post, 'create');
			
			$this->saveImage($id);
			
			echo json_encode($this->result, JSON_UNESCAPED_UNICODE);
			
/*
			if(empty($this->result)) {
                $this->response->redirect('admin/pet/new');
			} else {
    			echo json_encode($this->result, JSON_UNESCAPED_UNICODE);
			}
*/
		}
	}
	
	public function editAction($petId)
	{
    	global $petStatus, $petLocation;
    	
		$this->view->title = '编辑动物信息 - 汪汪喵呜孤儿院后台管理';
		
		$this->view->breadcrumb = array(
            array(
                'name' => '动物',
                'link' => '/admin/pet/index'
            ),
            array(
                'name' => '编辑动物信息',
                'active' => true
            )
        );
		
		$this->view->location = $petLocation;
		$this->view->status = $petStatus;
		
		$pet = Pet::findFirst($petId);
		$pped = PohomePetExtraData::findFirst($petId);
		$this->view->pet = $pet;
		$this->view->pped = $pped;
		
		if ($this->request->isPost()) {
			
			$this->view->disable();
			
			$post = $this->request->getPost();
			$post['taobao_url'] = $this->parseTaobaoId($post['taobao_url']);
									
			$this->saveData($pet, $post, 'update');
			$this->saveData($pped, $post, 'update');
			
			echo json_encode($this->result, JSON_UNESCAPED_UNICODE);
		}
		
	}
	
	// :需要修改:
	public function favoriteAction($pet_id)
	{
    	// 要求首先用户已经登录了
    	if(!$this->session->has('userId')) {
        	$this->response->redirect('user/login');
    	} else {
        	$pet = Pet::findFirst($pet_id);
        	if($pet) {
            	$fp = new FavoritePet();
            	$fp->pet_id = $pet_id;
            	$fp->user_id = $this->session->get('userId');
            	$fp->create();
        	}        	
    	}
	}
	
	public function testAction()
	{
    	$this->view->disable();
    	$pet = Pet::findFirst('10161768801586880');
    	print_r($pet->creator->username);
	}
	
	public function photoAction($petId)
	{
    	//$this->view->disable();
    	if($this->request->isPost()) {
        	$files = $this->saveImage();
        	
        	foreach($files as $file)
        	{
            	$pp = new PetPhoto();
            	$pp->pet_id = $petId;
            	$pp->file_id = $file['id'];
            	$pp->create();
        	}
    	}    	
	}
	
	private function parseTaobaoId($url)
	{
    	if(preg_match('#^.*?id=(\d+)$#', $url, $match)) {
        	return $match[1];
    	} else {
        	return '0';
    	}
	}
}