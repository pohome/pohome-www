<?php
	
namespace Pohome\Frontend;

class Module implements \Phalcon\Mvc\ModuleDefinitionInterface
{
	public function registerAutoloaders()
	{
		$loader = new \Phalcon\Loader();
		
		$loader->registerNamespaces(array(
			'\Pohome\Frontend\Controllers' => '../apps/frontend/controllers',
			'\Pohome\Frontend\Models' => '../apps/frontend/models',
			'Phalcon' => '../library/Phalcon/',
		));
		
		$loader->register();
	}
	
	public function registerServices($di)
	{
		$di->set('dispatcher', function() {
			$dispatcher = new \Phalcon\Mvc\Dispatcher();
			$dispatcher->setDefaultNamespace('\Pohome\Frontend\Controllders');
			return $dispatcher;
		});
		
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
	}
}