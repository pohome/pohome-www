<?php
	
namespace Pohome\Frontend;

class Module implements \Phalcon\Mvc\ModuleDefinitionInterface
{
	public function registerAutoloaders()
	{
		$loader = new \Phalcon\Loader();
		
		$loader->registerNamespaces(array(
			'Pohome\Frontend\Controllers' => '../apps/frontend/controllers',
			'Pohome\Frontend\Models' => '../apps/frontend/models',
			'Phalcon' => '../library/Phalcon/',
		));
		
		$loader->register();
	}
	
	public function registerServices($di)
	{
		$di->set('view', function() {
			$view = new \Phalcon\Mvc\View();
			
			$view->setViewsDir('../apps/frontend/views');
			$view->registerEngines(array(
				'.volt' => function($view, $di) {
					$volt = new \Phalcon\Mvc\View\Engine\Volt($view, $di);
					$volt->setOptions(array(
						'compiledPath' => '../apps/frontend/views/compiled/',
						'compileAlways' => true
					));
					
					return $volt;
				}
			));
			
			return $view;
		});
		
		$di->set('dispatcher', function() {
			$dispatcher = new \Phalcon\Mvc\Dispatcher();
			$eventManager = new \Phalcon\Events\Manager();
	
			$eventManager->attach('dispatch:beforeDispatchLoop', function($event, $dispatcher) {
				$action = $dispatcher->getActionName();
				if(strpos($action, '-')) {
					$dispatcher->setActionName(\Phalcon\Text::camelize($action));
				}
			});
			
			$eventManager->attach('dispatch:beforeException', function($event, $dispatcher, $exception) {
				if($exception instanceof Phalcon\Mvc\Dispatcher\Exception) {
					//$dispatcher->forward(array('module' => 'backend', 'controller' => 'index', 'action' => 'route404'));
					var_dump($exception);
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
			$dispatcher->setDefaultNamespace('Pohome\Frontend\Controllers');
			
			return $dispatcher;
		});
	}
}