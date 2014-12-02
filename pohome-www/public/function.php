<?php
	
// 获取用户ip
$ip = $_SERVER['REMOTE_ADDR'];
echo ip2long($ip).'<br />';


// 获取用户访问时间（MySQL数据库里，datatime类型需要用以下格式录入）
echo date('Y-m-d H:i:s', $_SERVER['REQUEST_TIME']).'<br />';

// 获取来源页面的地址
if(array_key_exists('HTTP_REFERER', $_SERVER)) {
	echo $_SERVER['HTTP_REFERER']; 
} else {
	echo 'No source page!';
}

$session = new Phalcon\Session\Adapter\Files();
$session->start();
var_dump($session->get('username'));

$result = array(
	'hasError' => true,
	'errMsg' => array('密码错误', '用户名不能为空'),
	'errField' => array('username', 'password'),
	'fieldValue' => array(
		'username' => 'sieg',
		'password' => 'oscar200'
	)
);

$result['errMsg'][] = '你好';

var_dump($result);

$form = array(
	'name' => 'newPet',
	'field' => array(
		array(
			'name' => 'name',
			'type' => 'InputText',
			'label' => '动物名',
			'attr' => array(
				'required' => true
			),
			'regex' => '{a-z}'
		),
		array(
			'name' => 'species',
			'type' => 'Radio',
			'label' => '物种',
			'data' => array(
				'汪星人' => 'D',
				'喵星人' => 'C'
			),
			'attr' => array(
				'required' => true
			)
		)
	)
);

echo json_encode($form, JSON_UNESCAPED_UNICODE) . PHP_EOL;


?>

<script type="text/javascript">
	var result = eval(<?php echo json_encode($result, JSON_UNESCAPED_UNICODE); ?>);
	console.log(result.fieldValue.username);
</script>