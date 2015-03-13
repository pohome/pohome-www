<?php
	
namespace Pohome\Validator;
	
use Phalcon\Mvc\Model\Validator,
	Phalcon\Mvc\Model\validatorInterface;
	
class MobileValidator extends Validator implements ValidatorInterface
{
	public function validate($model)
	{
		$field = $this->getOption('field');
		
		$value = $model->$field;
		
		if(preg_match('/^1[0-9]{10}$/', $value) == 0) {
			$this->appendMessage(
				'invalid mobile number.',
				$field,
				'MobileValidator'
			);
			return false;
		}
		return true;
	}
}