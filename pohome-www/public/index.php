<?php
    
require '../library/mailgun-php/vendor/autoload.php';
require '../library/function.php';
require '../library/global.php';

use Phalcon\Logger\Adapter\File as FileAdapter;

$config = new \Phalcon\Config\Adapter\Ini('../apps/config/config.ini');
        
$di = new \Phalcon\DI\FactoryDefault();

$di->set('router', function() {
    $router = new \Phalcon\Mvc\Router();

    $router->add('/:controller', array(
        'module' => 'frontend',
        'controller' => 1,
        'action' => 'index',
    ));

    $router->add('/', array(
        'module' => 'frontend',
        'controller' => 'index',
        'action' => 'index',
    ));
    
    
    
    $router->add('/:controller/:action/:params', array(
        'module' => 'frontend',
        'controller' => 1,
        'action' => 2,
        'params' => 3
    ));
    
    $router->add('/:controller/:int', array(
        'module' => 'frontend',
        'controller' => 1,
        'action' => 'view',
        'params' => 2
    ));
    
    $router->add('/blog/catelog/:int', array(
        'module' => 'frontend',
        'controller' => 'blog',
        'action' => 'catelog',
        'catelogId' => 1
    ));
    
    $router->add('/blog/:int', array(
        'module' => 'frontend',
        'controller' => 'blog',
        'action' => 'view',
        'blogId' => 1
    ));
    
    $router->add('/blog/p/:int', array(
        'module' => 'frontend',
        'controller' => 'blog',
        'action' => 'index',
        'page' => 1
    ));
    
    $router->add('/pet/p/(\d+?)', array(
        'module' => 'frontend',
        'controller' => 'pet',
        'action' => 'index',
        'petId' => 1
    ));
    
    
    $router->add('/pet/:int', array(
        'module' => 'frontend',
        'controller' => 'pet',
        'action' => 'view',
        'petId' => 1
    ));
    
    $router->add('/user/verify-email/(.*?)/(.*?)', array(
        'module' => 'frontend',
        'controller' => 'user',
        'action' => 'verifyEmail',
        'userId' => 1,
        'verifyCode' => 2
    ));
    
    $router->add('/admin/:controller/:action/:params', array(
        'module' => 'backend',
        'controller' => 1,
        'action' => 2,
        'params' => 3
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
    $session = new \Phalcon\Session\Adapter\Redis(array('path' => 'tcp://127.0.0.1:6379?weight=1'));
    $session->start();
    
    return $session;
});


// 配置Redis服务器
// TODO:需要考虑长链接的问题
$di->setShared('redis', function() {
    $redis = new Redis();
    $redis->open('127.0.0.1', 6379);    
    
    return $redis;
});

$di->set('cookies', function() {
    $cookies = new \Phalcon\Http\Response\Cookies;
    $cookies->useEncryption(false);
    return $cookies;
});

$di->set('mail', function() {
    return new \Mailgun\Mailgun('key-aae0bf1cde210918f71cee58ce5b2485');
});

$di->set('debug', function() {
    $logger = new FileAdapter('../apps/logs/debug.log');
    return $logger;
});

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