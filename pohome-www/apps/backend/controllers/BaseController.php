<?php
	
namespace Pohome\Backend\Controllers;

class BaseController extends \Phalcon\Mvc\Controller
{
	public $result = array();
	
	public function initialize()
	{
		
	}
	
	private function saveData(&$model, &$post, $type)
	{
		if($model->$type($post) == false)
		{
			foreach($model->getMessages() as $msg)
			{
				$field = $msg->getField();
				$this->result[] = array('field' => $field, 'type' => $msg->getType(), 'value' => $post[$field]);
			}
		}
	}
	
	private function saveImage($id = null)
	{
		if($this->request->hasFile())
		{
			foreach($this->request->getUploadedFiles() as $file)
			{
				$fileType = $file->getRealType();
				
				if(preg_match("/^image\/(jpeg|png|gif)$/", $fileType, $matches) == 0) {
					continue;
				}
				
				// 生成文件名的uuid	
				if(is_null($id)) {
					$fileId = gen_uuid();
				}
				
				$filename = $id . '.' . $matches[1];
				
				$img = new \Imagick($file->getTempName());
				resizeImage($img, $filename);				
								
				$f = new \Pohome\Backend\Models\File();
				$f->id = $filename;
				$f->original_filename = $file->getName();
				$f->file_type = $matches[1];
				$f->file_size = $file->getSize();
			}
		}
	}
	
	private function resizeImage(&$img, $filename)
	{
		$basePath = '/upload/image/';
		
		$size = $img->getImageGeometry();
		$width = $size['width'];
		$height = $size['height'];
		
		for($d = 2048; $d >= 64; $d /= 2)
		{
			if($width < $d && $height < $d) {
				continue;
			}
			
			$img->resizeImage($d, $d, \Imagick::FILTER_CATROM, 0.95, true);
			$img->writeImage($basePath . $d . '/' . $filename);
		}
		
	}
	
	private function cleanTags($str)
	{
		return strip_tags($str, '<code><span><div><label><a><br><p><b><i><del><strike><u><img><video><audio><iframe><object><embed><param><blockquote><mark><cite><small><ul><ol><li><hr><dl><dt><dd><sup><sub><big><pre><code><figure><figcaption><strong><em><table><tr><td><th><tbody><thead><tfoot><h1><h2><h3><h4><h5><h6>');
	}
	
	protected function checkPermission($permission)
	{
		
	}
	
	private function getAllPermissions($userId)
	{
		
	}
}