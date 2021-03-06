<?php
	
namespace Pohome\Backend;

class Module implements \Phalcon\Mvc\ModuleDefinitionInterface
{
	public function registerAutoloaders(\Phalcon\DiInterface $dependencyInjector = null)
	{
		$loader = new \Phalcon\Loader();
		
		$loader->registerNamespaces(array(
			'Pohome\Backend\Controllers' => '../apps/backend/controllers/',
			'Pohome\Models' => '../apps/models/',
			'Pohome' => '../library/',
			'Phalcon' => '../library/Phalcon/',
			'Pohome\Validator' => '../apps/validator/'
		));
		
		$loader->register();
	}
	
	public function registerServices(\Phalcon\DiInterface $di)
	{
		$di->set('view', function() {
			$view = new \Phalcon\Mvc\View();
			$view->setViewsDir('../apps/backend/views');
			$view->registerEngines(array(
				'.volt' => function($view, $di) {
					$volt = new \Phalcon\Mvc\View\Engine\Volt($view, $di);
					$volt->setOptions(array(
						'compiledPath' => '../apps/backend/views/compiled/',
						'compileAlways' => false
					));
					return $volt;
				}
			));
			
			return $view;
		});
		
		$di->set('dispatcher', function() {
			$dispatcher = new \Phalcon\Mvc\Dispatcher();
			$eventManager = new \Phalcon\Events\Manager();
			
			// 将以"-"分割的action转换为以驼峰法命名的action
			$eventManager->attach('dispatch:beforeDispatchLoop', function($event, $dispatcher) {
				$action = $dispatcher->getActionName();
				if(strpos($action, '-')) {
					$dispatcher->setActionName(\Phalcon\Text::camelize($action));
				}
			});
			
			// 将未吻合的route重定向到404页面
			$eventManager->attach('dispatch:beforeException', function($event, $dispatcher, $exception) {
				if($exception instanceof Phalcon\Mvc\Dispatcher\Exception) {
					$dispatcher->forward(array('module' => 'backend', 'controller' => 'index', 'action' => 'route404'));
					return false;
				}
				
				if ($event->getType() == 'beforeException') {
		            switch ($exception->getCode()) {
		                case \Phalcon\Dispatcher::EXCEPTION_HANDLER_NOT_FOUND:
		                case \Phalcon\Dispatcher::EXCEPTION_ACTION_NOT_FOUND:
		                    $dispatcher->forward(array(
		                        'controller' => 'index',
		                        'action' => 'route404'
		                    ));
		                    return false;
		            }
		        }
			});
			
			$dispatcher->setEventsManager($eventManager);
			$dispatcher->setDefaultNamespace('Pohome\Backend\Controllers');
			
			return $dispatcher;
		});
	}
}