<?php

$config = new \Phalcon\Config\Adapter\Ini('../apps/config/config.ini');
		
$di = new \Phalcon\DI\FactoryDefault();

$di->set('router', function() {
	$router = new \Phalcon\Mvc\Router();
	
	$router->add('/:controller', array(
		'module' => 'frontend',
		'controller' => 1,
		'action' => 'index'
	));
	
	$router->add('/pet/:int', array(
		'module' => 'frontend',
		'controller' => 'pet',
		'action' => 'view',
		'petId' => 1
	));
	
	$router->add('/login', array(
		'module' => 'frontend',
		'controller' => 'user',
		'action' => 'login',
	));
		
	$router->add('/blog/:int', array(
		'module' => 'frontend',
		'controller' => 'blog',
		'action' => 'view',
		'blogId' => 1,
	));
	
	$router->add('/admin/:controller', array(
		'module' => 'backend',
		'controller' => 1,
		'action' => 'index'
	));
	
	$router->add('/admin/login', array(
		'module' => 'backend',
		'controller' => 'auth',
		'action' => 'login'
	));
	
	$router->add('/admin/:controller/:action/:params', array(
		'module' => 'backend',
		'controller' => 1,
		'action' => 2,
		'params' => 3
	));
	
	$router->add('/admin/install', array(
		'module' => 'backend',
		'controller' => 'index',
		'action' => 'install'
	));
	
	$router->add('/admin', array(
		'module' => 'backend',
		'controller' => 'index',
		'action' => 'index',
	));
	
	$router->add('/', array(
		'module' => 'frontend',
		'controller' => 'index',
		'action' => 'index',
	));
	
	$router->notFound(array(
		'module' => 'backend',
	    'controller' => 'index',
	    'action' => 'route404'
	));
	
	return $router;
});


// 配置Mysql数据库信息，优先使用环境变量中保存的信息
$di->set('db', function() use ($config) {
	return new \Phalcon\Db\Adapter\Pdo\Mysql(array(
		'host' => getenv('DB_HOST')? getenv('DB_HOST') : $config->database->host,
		'username' => getenv('DB_USER')? getenv('DB_USER') : $config->database->username,
		'password' => getenv('DB_PASSWORD')? getenv('DB_PASSWORD') : $config->database->password,
		'dbname' => $config->database->dbname
	));
});

// 配置session使用Redis适配器
$di->setShared('session', function() {

/*
	$session = new \Phalcon\Session\Adapter\Redis(array(
		'path' => 'tcp://127.0.0.1:6379?weight=1'
	));
*/
	$session = new Phalcon\Session\Adapter\Files();
	$session->start();
	
	return $session;
});

$di->set('logger', function() {
	return new \Phalcon\Logger\Adapter\File('../apps/log/debug.log');
}, true);

$app = new \Phalcon\Mvc\Application($di);

$app->registerModules(array(
	'frontend' => array(
		'className' => 'Pohome\Frontend\Module',
		'path' => '../apps/frontend/Module.php'
	),
	'backend' => array(
		'className' => 'Pohome\Backend\Module',
		'path' => '../apps/backend/Module.php'
	)
));

echo $app->handle()->getContent();