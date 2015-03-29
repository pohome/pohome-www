<?php
    
namespace Pohome\Backend\Controllers;

use \Pohome\Backend\Models\Blog;
use \Pohome\Backend\Models\Pet;
use \Pohome\Backend\Models\PetStory;
use \Pohome\Backend\Models\File;

class BlogController extends BaseController
{   
    public function indexAction($page = 1)
    {
        $this->view->title = '博文列表 - 汪汪喵呜孤儿院';
        $blogs = Blog::find(array(
            "order" => "published_at DESC"
        ));
        
        $paginator = new \Phalcon\Paginator\Adapter\Model(array(
            "data" => $blogs,
            "limit" => 20,
            "page" => $page
        ));
        
        $this->view->page = $paginator->getPaginate();
    }
    
    public function newAction($petId = null)
    {
        $this->view->title = '撰写新博文 - 汪汪喵呜孤儿院';
        
        if(!is_null($petId)) {
            $pet = \Pohome\Backend\Models\Pet::findFirst($petId);
            $this->view->petName = $pet->name;
            $this->view->petId = $petId;
        }
        
        global $blogCatelog;
        $this->view->catelogs = $blogCatelog;
                        
        if ($this->request->isPost()) {
            $this->view->disable();
            
            $post = $this->request->getPost();
            $blog = new Blog();
            
            $files = $this->saveImage();
            $post['author_id'] = $this->session->get('userId');
            $post['feature_image'] = $files[0]['id'];
            
            $this->saveData($blog, $post, 'create');
            
            if (!empty($this->result)) {
                // 删除已上传的文件
            }
            
            if (!is_null($petId)) {
                $petStory = new PetStory();
                $data['pet_id'] = $petId;
                $data['blog_id'] = $blog->id;
                $this->saveData($petStory, $data, 'create');
            }
        }
    }
    
    public function editAction($blogId)
    {
        //$this->view->disable();
        global $blogCatelog;
        $this->view->catelogs = $blogCatelog;
        
        $blog = Blog::findFirst($blogId);
        $this->view->blog = $blog;
        
        if($this->request->isPost()) {
            
            $this->view->disable();
            $post = $this->request->getPost();
            
            //$files = $this->saveImage();
            //$post['author_id'] = $this->session->get('userId');
            //$post['feature_image'] = $files[0]['id'];
            
            $this->saveData($blog, $post, 'update');
        }
    }
    
    public function deleteAction($blogId)
    {
        // 需要在删除数据库中指定博文前，将其博文内容中包含的照片都删除掉
        $this->view->disable();
        
        $blog = Blog::findFirst($blogId);
        
        // 删除feature image
        $featureImage = $blog->feature_image;
        $file = File::findFirst($featureImage);
        
        if ($file) {
            $file->deleteRealFile();
            $file->delete();
        }
        
        // 删除正文中包含的图片
        
        
        // 删除博文数据库记录
        //$result = $blog->delete();

        //$this->response-redirect('/admin/blog/index');
    }
    
    public function importAction($action = null)
    {
        // 导入新浪博客上的历史博文
       // $this->view->disable();
       
       if ($this->request->isPost()) {
           $this->view->disable();
           if ($this->request->getPost('action') == 'generate') {
               // 生成全部博文列表
               $result = array();
               for($page = 1; $page < 22; $page++)
               {
                    $url = 'http://blog.sina.com.cn/s/articlelist_1340306694_0_' . $page . '.html';
                    $html = file_get_contents($url);
                    $html = str_replace("\n", '', $html);
                    
                    preg_match_all("#<span class=\"atc_title\".*?href=\"(http.*?html).*?span>#", $html, $match);
                    $result = array_merge($result, $match[1]);
               }
               echo json_encode($result);
           } else {
               $this->importBlog($this->request->getPost('url'));
               echo json_encode($this->request->getPost());
           }
       }
    }
    
    private function importImage($url)
	{
    	$fileId = gen_uuid();
    	$filename = $fileId . '.jpeg';
    	
    	$img = new \Imagick($url);
    	
    	$this->resizeImage($img, $filename);
    	
    	$f = new \Pohome\Backend\Models\File();
                
        $post = array(
            'id' => $fileId,
            'original_filename' => $filename,
            'file_type' => 'jpeg',
            'file_size' => $img->getImageLength(),
            'uploader_id' => $this->session->get('userId')
        );
        
        $this->saveData($f, $post, 'create');
        
        return $filename;
	}
	
	private function importBlog($url)
	{
    	ini_set('max_execution_time', '0');
    	$html = file_get_contents($url);
	
    	$begin = strpos($html, '<h2');
    	$end = strpos($html, '</h2>');
    	
    	$title = substr($html, $begin, $end - $begin + 1);
    	preg_match("/>(.*?)</", $title, $match);
    	$title = $match[1];
    	
    	preg_match("/<span class=\"time SG_txtc\">\((.*?)\)<\/span>/", $html, $match);
    	$published_at = $match[1];
    	
    	$begin = strpos($html, '<!-- 正文开始 -->');
    	$end = strpos($html, '<!-- 正文结束 -->');
    	
    	$content = substr($html, $begin, $end - $begin + 1);
    	$content = strip_tags($content,'<a>');
    	
    	// 获取博文中包含的图像链接
    	preg_match_all("/<a.*?url=(http:.*?)\".*?a>/i", $content, $match);
    	
    	$a = $match[0];
    	$images = $match[1];
    	
    	for ($i = 0; $i < count($images); $i++)
    	{
        	$filename = $this->importImage($images[$i]);
        	$images[$i] = '<p><img src="/upload/image/' . $this->getImageMaxSize($filename) .'/' . $filename . '"></p>';
    	}
    	
    	$content = str_replace('&nbsp;', '', $content);
    	$content = str_ireplace($a, $images, $content, $count);
    	
    	$blog = new Blog();
    	$blog->title = $title;
    	$blog->feature_image = 0;
    	$blog->abstract = mb_substr(strip_tags($content), 0, 400);
    	$blog->content = $content;
    	$blog->catelog_id = 8;
    	$blog->published_at = $published_at;
    	$blog->draft = 1;
    	$blog->author_id = $this->session->get('userId');
    	if($blog->create() == false) {
        	$msg = $blog->getMessages();
        	var_dump($msg);
    	}
	}
	
	private function getImageMaxSize($filename)
	{
    	$baseUrl = $_SERVER['DOCUMENT_ROOT'] . '/upload/image/';
    	
    	for($i = 1024; $i >= 64; $i /= 2)
    	{
            if(file_exists($baseUrl . $i . '/' . $filename)) {
                return $i;
            }	
    	}
	}
}