<?php
error_reporting(E_ALL);	
$config = new \Phalcon\Config\Adapter\Ini('../apps/config/config.ini');
		
$di = new \Phalcon\DI\FactoryDefault();

$di['router'] = function() {
	$router = new \Phalcon\Mvc\Router();

	$router->add('/admin/install', array(
		'module' => 'backend',
		'controller' => 'index',
		'action' => 'install'
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
	
	$router->notFound(array(
		'module' => 'backend',
	    'controller' => 'index',
	    'action' => 'route404'
	));
	
	return $router;
};

$di->set('db', function() use ($config) {
	return new \Phalcon\Db\Adapter\Pdo\Mysql(array(
		'host' => getenv('DB_HOST')? getenv('DB_HOST') : $config->database->host,
		'username' => getenv('DB_USER')? getenv('DB_USER') : $config->database->username,
		'password' => getenv('DB_PASSWORD')? getenv('DB_PASSWORD') : $config->database->password,
		'dbname' => $config->database->dbname
	));
});

$di->setShared('session', function() {
	$session = new \Phalcon\Session\Adapter\Files();
	$session->start();
	return $session;
});

$di->set('logger', function() {
	return new \Phalcon\Logger\Adapter\File('../apps/debug.log');
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