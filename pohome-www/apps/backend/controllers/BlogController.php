<?php
    
namespace Pohome\Backend\Controllers;

use \Pohome\Models\Blog;
use \Pohome\Models\Pet;
use \Pohome\Models\PetStory;
use \Pohome\Models\File;

class BlogController extends BaseController
{   
    public function indexAction($page = 1)
    {
        $this->view->title = '博文列表 - 汪汪喵呜孤儿院后台管理';
        
        $this->view->breadcrumb = array(
            array(
                'name' => '博客',
                'link' => '/admin/blog/index'
            ),
            array(
                'name' => '列表',
                'active' => true
            )
        );
        
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
        $this->view->title = '撰写新博文 - 汪汪喵呜孤儿院后台管理';
        
        $this->view->breadcrumb = array(
            array(
                'name' => '博客',
                'link' => '/admin/blog/index'
            ),
            array(
                'name' => '添加新博客',
                'active' => true
            )
        );
        
        if(!is_null($petId)) {
            $pet = Pet::findFirst($petId);
            $this->view->petName = $pet->name;
            $this->view->petId = $petId;
        }
        
        global $blogCatelog;
        $this->view->catelogs = $blogCatelog;
                        
        if ($this->request->isPost()) {
            $post = $this->request->getPost();
            $blog = new Blog();
            
            $files = $this->saveImage();
            $post['author_id'] = $this->session->get('userId');
            $post['feature_image'] = $files[0]['id'];
            
            $this->saveData($blog, $post, 'create');
            
            if (!empty($this->result)) {
                // 返回错误信息
                $this->view->errors = $this->result;
                return;
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
        $this->view->title = '编辑博客 - 汪汪喵呜孤儿院后台管理';
        
        $this->view->breadcrumb = array(
            array(
                'name' => '博客',
                'link' => '/admin/blog/index'
            ),
            array(
                'name' => '编辑博客',
                'active' => true
            )
        );
        
        global $blogCatelog;
        $this->view->catelogs = $blogCatelog;
        
        $blog = Blog::findFirst($blogId);
        $this->view->blog = $blog;
        
        // 从博文中包含的照片选择展示照片
        $content = $blog->content;
        preg_match_all('#<img src="/upload/img/blog/content/(\d+?.jpeg)".*?>#', $content, $match);
        $this->view->photos = $match[1];
        
        
        if($this->request->isPost()) {
            $post = $this->request->getPost();
 
            // 从博文中包含的照片选择展示照片
            if(array_key_exists('feature_image', $post)) {
                $root = $_SERVER['DOCUMENT_ROOT'] . '/upload/img';
                $filename = $post['feature_image'];
                $img = new \Imagick($root . '/blog/content/' . $filename);
                $img->resizeImage(240, 240, \Imagick::FILTER_CATROM, 1, true);
                $img->writeImage($root . '/blog/feature/' . $blog->id . '.jpeg');
            }
            
            $this->saveData($blog, $post, 'update');
            if(empty($this->result)) {
                $this->response->redirect('admin/blog/index/' . floor($blogId / 20));
            } else {
                $this->view->errors = $this->result;
            }
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
    	
    	$f = new \Pohome\Models\File();
                
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
    	if(mb_strlen($title) > 20) {
        	$title = mb_substr($title, 0, 20);
    	}
    	
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
	
/*
	public function updateAction()
	{
    	$this->view->disable();
    	set_time_limit(60);
    	
        $blogs = Blog::find();
        foreach($blogs as $blog)
        {
            $content = $blog->content;
            
            preg_match_all('#<p>*?<img src="/upload/image/(\d+?)/(\d+?).jpeg".*?>#', $content, $match);
            
            foreach($match[2] as $fileId)
            {
                $file = File::findFirst($fileId);
                $max_size = min($file->max_size, 1024);
                if($file->type == 'L') {
                    $w = '80%';
                } else {
                    $w = '60%';
                }
                
                $i = sprintf('#<p>*?<img src="/upload/image/(\d+?)/%s.jpeg".*?>#', $fileId);
                $r = sprintf('<p style="text-align: center;"><img src="/upload/image/%s/%s.jpeg" style="width: %s;">', $max_size, $fileId, $w);
                $content = preg_replace($i, $r, $content);
            }
            
            $blog->content = $content;
            $blog->update();
        }
	}
	
	public function updatetAction()
	{
    	$this->view->disable();
    	set_time_limit(60);
    	
        $blogs = Blog::find();
        foreach($blogs as $blog)
        {
            $content = $blog->content;
            
            $blog->content =  preg_replace('#\#*?(<p*?<img src="/upload/image/\d+?/\d+?.jpeg".*?>)*?\##', '${1}', $content);
            $blog->update();
        }
	}
*/
}