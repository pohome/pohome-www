<?php
	
namespace Pohome\Backend\Controllers;

use \Pohome\Backend\Models\Blog;
use \Pohome\Backend\Models\Pet;
use \Pohome\Backend\Models\Catelog;
use \Pohome\Backend\Models\Tag;
use \Pohome\Backend\Models\BlogWithTag;

class BlogController extends BaseController
{
	
	public function initialize()
	{
		if(!$this->checkPermission(array())) {
			$this->response->redirect('admin/auth/permission-denied');
		}
	}
	
	public function indexAction()
	{
		$this->view->title = '博文列表';
		$this->view->blog = \Pohome\Backend\Models\Blog::find();
	}
	
	public function newAction($petId = null)
	{
		$this->view->title = '撰写新博文';
		
		if(!is_null($petId)) {
			$pet = \Pohome\Backend\Models\Pet::findFirst($petId);
			$this->view->petName = $pet->name;
			$this->view->petId = $petId;
		}
		
		// 读取博文分类
		$this->view->catelogs = Catelog::find();
				
		if($this->request->isPost()) {
			$this->view->disable();
			
			$post = $this->request->getPost();
			
			$blog = new \Pohome\Backend\Models\Blog();
			$blog->title = $post['title'];
			$blog->abstract = $post['abstract'];
			$blog->content = $post['content'];
			$blog->catelog_id = $post['catelog'];
			$blog->draft = $post['draft'];
			$blog->feature_image = $this->saveFeatureImage();
			$blog->author_id = $this->session->get('userId');
			$blog->published_at = $post['published_at'];
			
			$this->db->begin();
			
			if($blog->create() == false) {
				foreach($blog->getMessages() as $message) {
					echo $message, "\n";
				}
				$this->db->rollback();
				return;
			}
			
			// 处理标签
			if(!empty($post['tag'])) {
				$tags = explode(' ', $post['tag']);
				foreach($tags as $tag) {
					$tagId = Tag::findFirstByName($tag);
						
					if(!empty($tagId)) {
						echo $tagId->id, "\n";
						$blogWithTag = new BlogWithTag();
						$blogWithTag->blog_id = $blog->id;
						$blogWithTag->tag_id = $tagId->id;
						
						if($blogWithTag->create() == false) {
							echo '???';
							foreach($blogWithTag->getMessages() as $message) {
								echo $message, "\n";
							}
							$this->db->rollback();
							return;
						}
					} else {
						$newTag = new Tag();
						$newTag->name = $tag;
						if($newTag->save() == false) {
							foreach($newTag->getMessages() as $msg) {
								echo $msg, "\n";
							}
							$this->db->rollback();
							return;
						}
						
						$blogWithTag = new BlogWithTag();
						$blogWithTag->blog_id = $blog->id;
						$blogWithTag->tag_id = $newTag->id;
						
						if($blogWithTag->save() == false) {
							foreach($blogWithTag->getMessages() as $msg) {
								echo $msg, "\n";
							}
							$this->db->rollback();
							return;
						}
					}
				}
			}
			
			if(array_key_exists('pet_id', $post)) {
				$blogStory = new \Pohome\Backend\Models\PetStory();
				$blogStory->pet_id = $post['pet_id'];
				$blogStory->blog_id = $blog->id;
				if($blogStory->create() == false) {
					foreach($blog->getMessages() as $message) {
						echo $message, "\n";
					}
					$this->db->rollback();
					return;
				}
			}
			
			$this->db->commit();
		}
	}
	
	public function editAction($blogId)
	{
		//$this->view->disable();
		
		$blog = \Pohome\Backend\Models\Blog::findFirstById($blogId);
		$this->view->blog = $blog;
		
		if($this->request->isPost()) {
			$post = $this->request->getPost();
			
			$blog = \Pohome\Backend\Models\Blog::findFirst($blogId);
			
			$blog->title = $post['title'];
			$blog->abstract = $post['abstract'];
			$blog->content = $post['content'];
			$blog->catelog_id = $post['catelog'];
			$blog->draft = $post['draft'];
			$blog->author_id = 1;
			$blog->published_at = $post['published_at'];
			
			if($blog->update() == false) {
				foreach($blog->getMessages() as $message) {
					echo $message, "\n";
				}
				
				return;
			}
			
			$this->view->disable();
			echo 'blog updated!';
		}
	}
	
	public function uploadAction()
	{
		$this->view->disable();
		
		if($this->request->hasFiles()) {
			foreach($this->request->getUploadedFiles() as $file) {
				// 检查文件类型是否为JPEG图片
				if(preg_match('/image/', $file->getType()) == 0) {
					echo 'wrong type';
					return;
				}
				
				$filename = date('Ymdhis') . rand(100, 999);
				$extension = $file->getExtension();
				
				// 处理图片的尺寸
				$img = new \Imagick();
				$img->readImage($file->getTempName());
				
				$imgSize = $img->getImageGeometry();
				
				if($imgSize['width'] >= 1440 && $imgSize['height'] >= 960) {
					$img->resizeImage(1440, 960, \Imagick::FILTER_CATROM, 0.95, true);
					$img->writeImage($_SERVER['DOCUMENT_ROOT'].'/upload/blog/photo/' . $filename . '@2x.' . $extension);
				}
					
				$img->resizeImage(720, 480, \Imagick::FILTER_CATROM, 0.95, true);
				$img->writeImage($_SERVER['DOCUMENT_ROOT'].'/upload/blog/photo/' . $filename . '.' . $extension);
					
				$img->destroy();
				
				$a = array('filelink' => '/upload/blog/photo/' . $filename . '.' . $extension);
				echo stripslashes(json_encode($a));
			}
		}
	}
	
	private function saveFeatureImage()
	{
		$normal = array('width' => 788, 'height' => 526);
		$retina = array('width' => 265, 'height' => 177);
		return $this->resizeImage($normal, $retina, '/upload/blog/feature/');
	}
	
	public function resizeImage($normal, $thumbnail, $path)
	{
		if($this->request->hasFiles()) {
			foreach($this->request->getUploadedFiles() as $file) {
				// 检查文件类型是否为JPEG图片
				if(preg_match('/image/', $file->getType()) == 0) {
					echo 'wrong type';
					return;
				}
				
				// 生成随机产生的文件名和对应的高清文件名
				$filename = date('Ymdhis') . rand(100, 999);
				$extension = $file->getExtension();
				$retinaFilename = $filename . '@2x.' . $extension;
				$filename = $filename . '.' . $extension;
				
				// 处理图片的尺寸
				$img = new \Imagick();
				$img->readImage($file->getTempName());
				
				$imgSize = $img->getImageGeometry();
				
				if($imgSize['width'] >= $normal['width'] * 2 && $imgSize['height'] >= $normal['height'] * 2) {
					$img->resizeImage($normal['width'] * 2, $normal['height'] * 2, \Imagick::FILTER_CATROM, 0.95, true);
					$img->writeImage($_SERVER['DOCUMENT_ROOT'] . $path . $retinaFilename);
				}
					
				$img->resizeImage($normal['width'], $normal['height'], \Imagick::FILTER_CATROM, 0.95, true);
				$img->writeImage($_SERVER['DOCUMENT_ROOT'] . $path . $filename);
				
				if($normal['width'] >= $thumbnail['width'] *2 && $normal['height'] >= $thumbnail['height']) {
					$img->resizeImage($thumbnail['width'] * 2, $thumbnail['height'] * 2, \Imagick::FILTER_CATROM, 0.95, true);
					$img->writeImage($_SERVER['DOCUMENT_ROOT'] . $path . 'thumbnail/' . $retinaFilename);
				}
				
				$img->resizeImage($thumbnail['width'], $thumbnail['height'], \Imagick::FILTER_CATROM, 0.95, true);
				$img->writeImage($_SERVER['DOCUMENT_ROOT'] . $path . 'thumbnail/' . $filename);
					
				$img->destroy();
				
				//unlink($file->getTempFile());
				return $filename;
			}
		}
	}
	
}