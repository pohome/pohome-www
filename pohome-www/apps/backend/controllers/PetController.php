<?php
	
namespace Pohome\Backend\Controllers;

use Pohome\Backend\Models\Pet;
use Pohome\Backend\Models\PetExtraInfo;

class PetController extends BaseController
{
	public function initialize()
	{
/*
		if(!$this->checkPermission(array('登录后台', '添加新动物信息'))) {
			$this->response->redirect('admin/auth/permission-denied');
		}
*/
	}
	
	public function indexAction()
	{
		$this->view->title = '全部动物列表';
		$this->view->pets = Pet::find();
	}
	
	public function newAction()
	{
		$this->view->setVar('title', '汪汪喵呜孤儿院 - 添加新动物');
		
		// 处理提交的表单数据
		if($this->request->isPost()) {
			
			$this->view->disable();
			$result = new FormResult();
			
			$this->db->begin();
			
			$pet = new Pet();
			$petExtraInfo = new PetExtraInfo();
						
			$pet->name = $this->request->getPost('name');
			$pet->species = $this->request->getPost('species');
			$pet->gender = $this->request->getPost('gender');
			$pet->breed = $this->request->getPost('breed');
			
			// 处理年龄
			$birthday = $this->request->getPost('birthday');
			if(preg_match('/^\d{4}-\d{1,2}-\d{1,2}$/', $birthday)) {
				$pet->birthday = $birthday;
			} else {
				$pet->birthday = $pet->parseAge($birthday);
			}
			
			if($pet->birthday == false) {
				$result->add('birthday', '生日的格式错误');
				$result->show();
				return;
			}
			
			$pet->body_size = $this->request->getPost('body_size');
			$pet->avatar = $this->saveAvatar();
			$pet->neutered = $this->request->getPost('neutered');
			$pet->location = $this->request->getPost('location');
			$pet->status = $this->request->getPost('status');
			$pet->adoptable = $this->request->getPost('adoptable');
			$pet->draft = $this->request->getPost('draft');
			
			if($pet->create() == false) {
				foreach ($pet->getMessages() as $message) {
					echo $message, "\n";
				}
				
				$this->db->rollback();
				return;
			}
			
			$petExtraInfo->pet_id = $pet->id;
			$petExtraInfo->character = $this->request->getPost('character');
			$petExtraInfo->health = $this->request->getPost('health');
			$petExtraInfo->notice = $this->request->getPost('notice');
			$petExtraInfo->entry_date = $this->request->getPost('entry_date');
			
			if($petExtraInfo->create() == false) {
				foreach($petExtraInfo->getMessages() as $message) {
					echo $message, "\n";
				}
				
				$this->db->rollback();
				return;
			}
			
			$this->db->commit();
			$result->show();
		}
	}
	
	public function editAction($petId)
	{
		$this->view->title = '编辑动物信息';
		
		if(!$this->request->isPost()) {
			$this->view->pet = Pet::findFirstById($petId);
			$this->view->petExtraInfo = PetExtraInfo::findFirstByPetId($petId);
		} else {
			$this->view->disable();
			$result = new FormResult();
			
			$this->db->begin();
			
			$pet = Pet::findFirstById($petId);
			$petExtraInfo = PetExtraInfo::findFirstByPetId($petId);
						
			$pet->name = $this->request->getPost('name');
			$pet->species = $this->request->getPost('species');
			$pet->gender = $this->request->getPost('gender');
			$pet->breed = $this->request->getPost('breed');
			
			// 处理年龄
			$birthday = $this->request->getPost('birthday');
			if(preg_match('/^\d{4}-\d{1,2}-\d{1,2}$/', $birthday)) {
				$pet->birthday = $birthday;
			} else {
				$pet->birthday = $pet->parseAge($birthday);
			}
			
			if($pet->birthday == false) {
				$result->add('birthday', '生日的格式错误');
				$result->show();
				return;
			}
			
			$pet->body_size = $this->request->getPost('body_size');
			
			if($this->request->hasFiles()) {
				// 删除旧的头像文件
				$oldAvatar = $pet->avatar;
				$path = $_SERVER['DOCUMENT_ROOT'] . '/upload/pet/avatar/';
				unlink($path . $oldAvatar);
				unlink($path . 'thumbnail/'. $oldAvatar);
				
				// 删除旧的高清头像文件
				$filename = explode('.', $oldAvatar);
				$oldAvatar = $filename[0] . '@2x.' . $filename[1];
				unlink($path . $oldAvatar);
				unlink($path . 'thumbnail/'. $oldAvatar);
				
				$pet->avatar = $this->saveAvatar();
			}
			
			$pet->neutered = $this->request->getPost('neutered');
			$pet->location = $this->request->getPost('location');
			$pet->status = $this->request->getPost('status');
			$pet->adoptable = $this->request->getPost('adoptable');
			$pet->draft = $this->request->getPost('draft');
			
			if($pet->update() == false) {
				foreach ($pet->getMessages() as $message) {
					echo $message, "\n";
				}
				
				$this->db->rollback();
				return;
			}
			
			$petExtraInfo->pet_id = $pet->id;
			$petExtraInfo->character = $this->request->getPost('character');
			$petExtraInfo->health = $this->request->getPost('health');
			$petExtraInfo->notice = $this->request->getPost('notice');
			$petExtraInfo->entry_date = $this->request->getPost('entry_date');
			
			if($petExtraInfo->update() == false) {
				foreach($petExtraInfo->getMessages() as $message) {
					echo $message, "\n";
				}
				
				$this->db->rollback();
				return;
			}
			
			$this->db->commit();
			$result->show();
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
	
	public function savePetPhoto($petId)
	{
		if($this->request->hasFiles() == true) {
			//$this->view->disable();
			
			foreach($this->request->getUploadedFiles() as $file) {
				// 检查文件类型是否为JPEG图片
				if(preg_match('/image/', $file->getType()) == 0) {
					echo 'wrong type';
					return;
				}
				
				$filename = date('Ymdhis') . rand(100, 999);
				$extension = $file->getExtension();
				
				$img = new \Imagick();
				$img->readImage($file->getTempName());
				
				//去除图片附加的exif等信息，以防止诸如gps坐标等敏感信息外泄
				$img->stripImage();
				
				// 处理图片的尺寸
				$imgSize = $img->getImageGeometry();
				
				if($imgSize['width'] >= 1440 && $imgSize['height'] >= 960) {
					$img->resizeImage(1440, 960, \Imagick::FILTER_CATROM, 0.95, true);
					$img->writeImage($_SERVER['DOCUMENT_ROOT'].'/upload/pet/photo/' . $filename . '@2x.' . $extension);
					
					$img->resizeImage(528, 352, \Imagick::FILTER_CATROM, 0.95, true);
					$img->writeImage($_SERVER['DOCUMENT_ROOT'].'/upload/pet/photo/thumbnail/' . $filename . '@2x.' . $extension);
				}
					
				$img->resizeImage(720, 480, \Imagick::FILTER_CATROM, 0.95, true);
				$img->writeImage($_SERVER['DOCUMENT_ROOT'].'/upload/pet/photo/' . $filename . '.' . $extension);
				
				$img->resizeImage(264, 176, \Imagick::FILTER_CATROM, 0.95, true);
				$img->writeImage($_SERVER['DOCUMENT_ROOT'].'/upload/pet/photo/thumbnail/' . $filename . '.' . $extension);
					
				$img->destroy();
				
				// 处理数据库
				$petPhoto = new \Pohome\Backend\Models\PetPhoto();
				$petPhoto->pet_id = $petId;
				$petPhoto->filename = $filename . '.' . $extension;
				$petPhoto->priority = \Pohome\Backend\Models\PetPhoto::maximum(array(
					"column" => "priority",
					"conditions" => "pet_id = '$petId'"
				)) + 1;
				$petPhoto->create();
			}
		}
	}
	
	public function saveAvatar()
	{
		if($this->request->hasFiles() == true) {
			foreach($this->request->getUploadedFiles() as $file) {
				// 检查文件类型是否为JPEG图片
				if(preg_match('/image/', $file->getType()) == 0) {
					echo 'wrong type';
					return;
				}
				
				$filename = date('Ymdhis') . rand(100, 999);
				$extension = $file->getExtension();
				
				// 按照前台的需求处理头像照片的尺寸
				$img = new \Imagick();
				$img->readImage($file->getTempName());
				
				
				$imgSize = $img->getImageGeometry();
				
				// 如果上传的照片尺寸够大，则生成对应retina显示器的版本
				if($imgSize['width'] >= 624 && $imgSize['height'] >= 624) {
					$img->resizeImage(624, 624, \Imagick::FILTER_CATROM, 0.95, true);
					$img->writeImage($_SERVER['DOCUMENT_ROOT'].'/upload/pet/avatar/' . $filename . '@2x.' . $extension);
					
					$img->resizeImage(420, 420, \Imagick::FILTER_CATROM, 0.95, true);
					$img->writeImage($_SERVER['DOCUMENT_ROOT'].'/upload/pet/avatar/thumbnail/' . $filename . '@2x.' . $extension);
				}
					
				$img->resizeImage(312, 312, \Imagick::FILTER_CATROM, 0.95, true);
				$img->writeImage($_SERVER['DOCUMENT_ROOT'].'/upload/pet/avatar/' . $filename . '.' . $extension);
				
				$img->resizeImage(210, 210, \Imagick::FILTER_CATROM, 0.95, true);
				$img->writeImage($_SERVER['DOCUMENT_ROOT'].'/upload/pet/avatar/thumbnail/' . $filename . '.' . $extension);
					
				
				$img->destroy();
				
				unlink($file->getTempName());
			}
		}
		
		return $filename . '.' . $extension;
	}
}

class FormResult
{
	public $hasErr = false;
	public $errMsg = array();
	
	public function add($field, $msg)
	{
		$this->hasErr = true;
		array_push($this->errMsg, array($field => $msg));
	}
	
	public function show()
	{
		$result = array('hasError' => $this->hasErr, 'errMsg' => $this->errMsg);
		echo json_encode($result, JSON_UNESCAPED_UNICODE);
	}
}