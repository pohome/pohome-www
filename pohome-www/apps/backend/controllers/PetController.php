<?php
	
namespace Pohome\Backend\Controllers;

use Pohome\Backend\Models\Pet;
use Pohome\Backend\Models\PohomePetExtraData;

class PetController extends BaseController
{
    public function initialize()
    {
        parent::initialize();
    }	
    
	public function indexAction($page = 1)
	{
		$this->view->title = '汪汪喵呜孤儿院 - 全部动物列表';
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
		$this->view->title = '汪汪喵呜孤儿院 - 新添动物信息';
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
			$this->saveData($pet, $post, 'create');
			
			$pped = new PohomePetExtraData();
			$post['pet_id'] = $id;
			$this->saveData($pped, $post, 'create');
			
			$this->saveImage($id);
						
			echo json_encode($this->result, JSON_UNESCAPED_UNICODE);
		}
	}
	
	public function editAction($petId)
	{
    	global $petStatus, $petLocation;
		$this->view->title = '汪汪喵呜孤儿院 - 编辑动物信息';
		
		$this->view->location = $petLocation;
		$this->view->status = $petStatus;
		
		$pet = Pet::findFirst($petId);
		$pped = PohomePetExtraData::findFirst($petId);
		$this->view->pet = $pet;
		$this->view->pped = $pped;
		
		if ($this->request->isPost()) {
			
			$this->view->disable();
			
			$post = $this->request->getPost();
									
			$this->saveData($pet, $post, 'update');
			$this->saveData($pped, $post, 'update');
			
			echo json_encode($this->result, JSON_UNESCAPED_UNICODE);
		}
		
	}
	
	public function photoAction($petId)
	{
		$this->view->title = '动物照片管理';
				
		if($this->request->isPost()) {
			// 更新照片顺序
			foreach($_POST as $photoId => $priority) {
				$match = array();
				if(preg_match('/^photo_(\d+)$/', $photoId, $match)) {
					$photoId = $match[1];
					$photo = \Pohome\Backend\Models\PetPhoto::findFirst($photoId);
					$photo->priority = $priority;
					$photo->save();
				} elseif(preg_match('/^delete_photo_(\d+)$/', $photoId, $match)) {
					if($priority == 'on') {
						$photoId = $match[1];
						$photo = \Pohome\Backend\Models\PetPhoto::findFirst($photoId);
						$filename = $photo->filename;
						$path = $_SERVER['DOCUMENT_ROOT'] . '/upload/pet/photo/';
						
						// 删除文件
						unlink($path . $filename);
						unlink($path . '/thumbnail/' . $filename);
						$tmp = explode('.', $filename);
						$filename = $tmp[0] . '@2x.' . $tmp[1];
						unlink($path . $filename);
						unlink($path . '/thumbnail/' . $filename);
						
						// 删除数据库信息
						$photo->delete();
					}
					
				}
			}
			
			$this->savePetPhoto($petId);
		}
		
		$this->view->petPhotos = \Pohome\Backend\Models\PetPhoto::find(array(
			"conditions" => "pet_id = $petId",
			"order" => "priority ASC",
		));
	}
	
	public function storyAction($action, $petId)
	{
		$this->view->title = '动物故事管理';
		
		if($action == 'list') {
			
		}
		
		if($action == 'new') {
			
		}
	}
}