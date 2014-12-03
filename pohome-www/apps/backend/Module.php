<?php
	
namespace Pohome\Backend;

class Module implements \Phalcon\Mvc\ModuleDefinitionInterface
{
	public function registerAutoloaders()
	{
		$loader = new \Phalcon\Loader();
		
		$loader->registerNamespaces(array(
			'Pohome\Backend\Controllers' => '../apps/backend/controllers/',
			'Pohome\Backend\Models' => '../apps/backend/models/',
			'Pohome\SemanticUIForm' => '../library/',
			'Phalcon' => '../library/Phalcon/',
		));
		
		$loader->register();
	}
	
	public function registerServices($di)
	{
		$di->set('dispatcher', function() {
			$dispatcher = new \Phalcon\Mvc\Dispatcher();
			
			$dispatcher->setDefaultNamespace('Pohome\Backend\Controllers');
			return $dispatcher;
		});
		
		$di->set('view', function() {
			$view = new \Phalcon\Mvc\View();
			$view->setViewsDir('../apps/backend/views');
			$view->registerEngines(array(
				'.volt' => function($view, $di) {
					$volt = new \Phalcon\Mvc\View\Engine\Volt($view, $di);
					$volt->setOptions(array(
						'compiledPath' => '../apps/backend/views/compiled/',
						'compileAlways' => true
					));
					return $volt;
				}
			));
			
			return $view;
		});
	}
}