<?php
	
namespace Pohome\Backend\Controllers;

use Pohome\Models\Pet;
use Pohome\Models\HealthcareRecord;
use Pohome\Models\MedicalRecord;
use Pohome\Models\PetTransferLog;
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
        
		$pets = Pet::find(array('order' => 'created_at DESC'));
		
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
			$post['taobao_url'] = $this->parseTaobaoId($post['taobao_url']);
			$post['creator_id'] = $this->session->get('userId');
			
			if(empty($post['angel_id'])) {
    			$post['angel_id'] = null;
			}
			
			$this->saveData($pet, $post, 'create');
			
			// 保存动物头像
			$this->saveImage(array(
			array(
    			'width' => 360,
    			'height' => 360,
    			'path' => '/pet/avatar/large/',
    			'crop' => true
			), array(
    			'width' => 280,
    			'height' => 280,
    			'path' => '/pet/avatar/small/',
    			'crop' => true
			)), $id);
			
			echo json_encode($this->result, JSON_UNESCAPED_UNICODE);
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
		$this->view->pet = $pet;
		
		if ($this->request->isPost()) {
			
			$this->view->disable();
			
			$post = $this->request->getPost();
			$post['taobao_url'] = $this->parseTaobaoId($post['taobao_url']);
									
			$this->saveData($pet, $post, 'update');
            
            $this->saveImage(array(
            array(
    			'width' => 360,
    			'height' => 360,
    			'path' => '/pet/avatar/large/',
    			'crop' => true
			), array(
    			'width' => 280,
    			'height' => 280,
    			'path' => '/pet/avatar/small/',
    			'crop' => true
			)), $petId);
			
			//echo $this->result;
			echo json_encode($this->result, JSON_UNESCAPED_UNICODE);
		}
		
	}
	
	public function deleteAction($petId)
	{
    	$this->view->disable();
    	
    	$photos = PetPhoto::find(array("pet_id='$petId'"));
    	
    	foreach($photos as $photo)
    	{
        	var_dump($photo->pet_id);
    	}
    	
    	$pet = Pet::findFirst($petId);
    	if($pet->delete() == false) {
        	foreach($pet->getMessages() as $m) {
            	echo $m . "\n";
        	}
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
	
	public function transferAction($petId)
	{   
    	if(!$this->request->isPost()) {
        	
        	global $petLocation;
    	
        	$this->view->title = '动物转移 - 汪汪喵呜孤儿院后台管理';
    		
    		$this->view->breadcrumb = array(
                array(
                    'name' => '动物',
                    'link' => '/admin/pet/index'
                ),
                array(
                    'name' => '转移',
                    'active' => true
                )
            );
            
            $this->view->pet = Pet::findFirst($petId);
            $this->view->location = $petLocation;
            $this->view->today = date('Y-m-d');
    	} else {
        	
        	$pet = Pet::findFirst($petId);
        	$post = $this->request->getPost();
        	
        	$pet->location_id = $post['destination'];
        	$pet->update();
        	
        	$tl = new PetTransferLog();
        	$tl->pet_id = $petId;
        	$tl->from = $post['from'];
        	$tl->destination = $post['destination'];
        	$tl->description = $post['description'];
        	$tl->creator_id = $this->session->get('userId');
        	
        	$tl->create();
        	
        	$this->view->disable();
        	
        	if($pet == false || $tl == false) {
            	echo 'F';
        	} else {
            	echo 'S';
        	}
    	}
	}
	
	public function healthcareAction($petId)
	{
    	if(!$this->request->isPost())
    	{
        	$this->view->title = '动物健康护理 - 汪汪喵呜孤儿院后台管理';
    		
    		$this->view->breadcrumb = array(
                array(
                    'name' => '动物',
                    'link' => '/admin/pet/index'
                ),
                array(
                    'name' => '健康护理',
                    'active' => true
                )
            );
            
            $this->view->pet = Pet::findFirst($petId);
            $this->view->today = date('Y-m-d');
        } else {
        	$this->view->disable();
        	
        	$pet = Pet::findFirst($petId);
        	$post = $this->request->getPost();
        	$hr = new HealthcareRecord();
        	
        	$hr->pet_id = $petId;
        	$hr->type = $post['type'];
        	$hr->product = $post['product'];
        	$hr->happened_at = $post['happened_at'];
        	$hr->creator_id = $this->session->get('userId');
        	
        	$hr->create();
        	echo 'S';
    	}
	}
	
	public function batchHealthcareAction()
	{
    	if(!$this->request->isPost())
    	{
        	global $petLocation;
        	$this->view->title = '批量动物健康护理 - 汪汪喵呜孤儿院后台管理';
    		
    		$this->view->breadcrumb = array(
                array(
                    'name' => '动物',
                    'link' => '/admin/pet/index'
                ),
                array(
                    'name' => '批量健康护理',
                    'active' => true
                )
            );
            
            $this->view->pets = Pet::find(array(
                "location_id = 1 AND species = 'D'"
            ));
            $this->view->today = date('Y-m-d');
            $this->view->location = $petLocation;
            $this->view->pick('pet/batchHealthcare');
            
        } else {
        	$this->view->disable();
        	
        	$post = $this->request->getPost();
        	
        	if(!array_key_exists('selected_pets', $post)) {
            	return 'F';
        	}
        	
        	$result = array('success' => 0, 'failure' => 0);
        	
        	foreach($post['selected_pets'] as $petId)
        	{
            	$pet = Pet::findFirst($petId);
            	$hr = new HealthcareRecord();
            	
            	$hr->pet_id = $petId;
            	$hr->type = $post['type'];
            	$hr->product = $post['product'];
            	$hr->happened_at = $post['happened_at'];
            	$hr->creator_id = $this->session->get('userId');
            	
            	
            	if($hr->create()) {
                	$result['success']++;
            	}
        	}
        	
        	echo json_encode($result);
    	}
	}
	
	public function medicalAction($petId)
	{
    	if(!$this->request->isPost())
    	{
        	global $petLocation;
        	
        	$this->view->title = '动物健康护理 - 汪汪喵呜孤儿院后台管理';
    		
    		$this->view->breadcrumb = array(
                array(
                    'name' => '动物',
                    'link' => '/admin/pet/index'
                ),
                array(
                    'name' => '医疗',
                    'active' => true
                )
            );
            
            $this->view->pet = Pet::findFirst($petId);
            $this->view->location = $petLocation;
            $this->view->today = date('Y-m-d');
        } else {
        	$this->view->disable();
        	
        	$pet = Pet::findFirst($petId);
        	$post = $this->request->getPost();
        	$mr = new MedicalRecord();
        	
        	$mr->pet_id = $petId;
        	$mr->description = $post['description'];
        	$mr->location_id = $post['location'];
        	$mr->happened_at = $post['happened_at'];
        	$mr->creator_id = $this->session->get('userId');
        	    	
        	if($mr->create()) {
            	echo 'S';
        	} else {
            	var_dump($mr->getMessages());
        	}        	
    	}
	}
	
	public function photoAction($petId)
	{
    	$this->view->title = '添加动物照片 - 汪汪喵呜孤儿院后台管理';
		
		$this->view->breadcrumb = array(
            array(
                'name' => '动物',
                'link' => '/admin/pet/index'
            ),
            array(
                'name' => '添加照片',
                'active' => true
            )
        );
        
    	if($this->request->isPost()) {
        	$files = $this->saveImage(array(
            	array(
                	'width' => 1080,
        			'height' => 1080,
        			'path' => '/pet/photo/full/',
        			'crop' => false
            	), array(
    			'width' => 180,
    			'height' => 180,
    			'path' => '/pet/photo/thumbnail/',
    			'crop' => false
			)));
        	//$files = $this->saveImage();
        	
        	//var_dump($files);
        	
        	foreach($files as $file)
        	{
            	$pp = new PetPhoto();
            	$pp->pet_id = $petId;
            	$pp->file_id = $file['id'];
            	$pp->create();
        	}
    	}    	
	}
	
	public function getProductAction()
	{
    	$this->view->disable();
    	
    	$products = array();
    	$post = $this->request->getPost();
    	
    	switch($post['type']) {
        	case '疾病免疫':
        	    if($post['species'] == 'C') {
            	    echo '["辉瑞 妙三多", "英特威 Nobivac Tricat", "英特威 Nobivac 1-HCP"]';
        	    } else {
            	    echo '["辉瑞 卫佳5", "辉瑞 卫佳8", "英特威 Nobivac Puppy DP", "英特威 Nobivac DHPPi + Lepto"]';
        	    }
        	    break;
    	    
    	    case '狂犬免疫':
    	        echo '["英特威 Rabies", "勃林格殷格翰 Rabvac 3"]';
    	        break;
    	        
            case '体内驱虫':
                if($post['species'] == 'C') {
                    echo '["保灵 体虫清"]';
                } else {
                    echo '["拜耳 拜宠清", "诺华 汽巴100", "诺华 汽巴500", "保灵 内虫清"]';
                }
                break;
                
            case '体外驱虫':
                echo '["辉瑞 大宠爱", "福来恩"]';
                break;
                
            case '洗澡':
                echo '["无"]';
                break;
    	}
	}
	
	public function filterAction()
	{
    	if($this->request->isPost())
    	{
        	$this->view->disable();
        	
        	$post = $this->request->getPost();
        	$location_id = $post['location'];
        	$species = $post['species'];
        	
        	$pets = Pet::find(array(
            	"location_id = '$location_id' AND species = '$species'"
        	));
        	
        	$filtered_pets = array();
        	
        	foreach($pets as $pet)
        	{
            	$filtered_pets[$pet->id] = $pet->name;
        	}
        	
        	echo json_encode($filtered_pets, JSON_UNESCAPED_UNICODE);
    	}
	}
	
	private function parseTaobaoId($url)
	{
    	//if(preg_match('#^.*?id=(\d+)$#', $url, $match)) {
    	if(preg_match('#^.*?itemID=(\d+)$#', $url, $match)) {
        	return $match[1];
    	} else {
        	return '0';
    	}
	}
}