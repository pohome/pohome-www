<?php

namespace Pohome\Backend\Controllers;

use Pohome\Models\Pet;

//class IndexController extends \Phalcon\Mvc\Controller
class IndexController extends \Pohome\Backend\Controllers\BaseController
{
    private $colorScheme = array(
        array('#bf616a', '#c6737b'),
        array('#5B90BF', '#6d9cc6'),
        array('#d08770', '#d69783'),
        array('#ebcb8b', 'efd5a1'),
        array('#a3be8c', 'b0c79c'),
        array('#96b5b4', 'a5c0bf'),
        array('#8fa1b3', '9eaebd'),
        array('#b48ead', 'be9db8'),
        array('#ab7967', 'b48777')
    );
    
	public function indexAction()
	{
		$this->view->title = '汪汪喵呜孤儿院后台管理';
		
		$this->view->breadcrumb = array(
            array(
                'name' => '工作台',
                'active' => true
            )
        );
        
        //$this->view->disable();
        
        global $petStatus;
        
        $this->view->speciesData = $this->calculatePieData('\Pohome\Models\Pet', 'species', array(
            'D' => '汪星人',
            'C' => '喵星人'
        ));
        
        $this->view->genderData = $this->calculatePieData('\Pohome\Models\Pet', 'gender', array(
            'M' => '男孩',
            'F' => '女孩'
        ));
        
        $this->view->statusData = $this->calculatePieData('\Pohome\Models\Pet', 'status_id', $petStatus);
        
        $this->view->petViewData = $this->calculateBarData('\Pohome\Models\Pet');
	}
	
	public function testAction()
	{
    	$this->view->disable();
    	
    	$userId = $this->session->get('userId');
    	
    	var_dump($this->hasPermissions($userId, '/admin/index/'));
	}
	
	public function permissionAction()
	{
    	if($this->request->isPost()) {
        	$post = $this->request->getPost();
        	$permission = new \Pohome\Models\Permission();
        	$permission->name = $post['name'];
        	$permission->url = $post['url'];
        	$permission->description = $post['name'];
        	$permission->save();
        	
        	$rhp = new \Pohome\Models\RoleHasPermission();
        	$rhp->role_id = 1;
        	$rhp->permission_id = $permission->id;
        	$rhp->save();
    	}
	}
	
	private function calculatePieData($table, $field, $labelIndex)
	{
    	$group = $table::count(array('group' => $field));
    	$data = array();
        
        $i = 0;
        foreach($group as $row)
        {
            $count = $row->rowcount;
            $label = $row->$field;
            $data[] = array(
                'value' => $count,
                'color' => $this->colorScheme[$i][0],
                'highlight' => $this->colorScheme[$i][1],
                'label' => $labelIndex[$label]
            );
            $i++;
        }
        
        return json_encode($data, JSON_UNESCAPED_UNICODE);
	}
	
	private function calculateBarData($table)
	{
    	$pets = $table::find(array(
        	'limit' => 10,
        	'order' => 'viewed DESC'
    	));
    	
    	$label = array();
    	$viewed = array();
    	
    	foreach($pets as $pet) {
        	$label[] = $pet->name;
        	$viewed[] = $pet->viewed;
    	}
    	
    	$data = array(
        	'labels' => $label /* '[' . implode(',', $label) . ']' */,
        	'datasets' => array(
            	array(
                	'label' => '浏览量前10名的动物',
                	'fillColor' => 'rgba(151,187,205,0.5)',
                	'strokeColor' => 'rgba(151,187,205,0.8)',
                	'highlightFill' => 'rgba(151,187,205,0.75)',
                	'highlightStroke' => 'rgba(151,187,205,1)',
                	'data' => $viewed // '[' . implode(',', $viewed) . ']' 
            	)
        	)
    	);
    	
    	return json_encode($data, JSON_UNESCAPED_UNICODE);
	}
	
	public function route404Action()
	{
		$this->view->disable();
		echo '404';
	}
}