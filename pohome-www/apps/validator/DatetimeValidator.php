<?php
	
namespace Pohome\Validator;
	
use Phalcon\Mvc\Model\Validator,
	Phalcon\Mvc\Model\validatorInterface;
	
class DatetimeValidator extends Validator implements ValidatorInterface
{
	public function validate(\Phalcon\Mvc\EntityInterface $model)
	{
		$field = $this->getOption('field');
		
		$value = $model->$field;
		
		if(strtotime($value) == false) {
			$this->appendMessage(
				'Invalid datetime format',
				$field,
				'DatetimeValidator'
			);
			return false;
		}
		return true;
	}
}