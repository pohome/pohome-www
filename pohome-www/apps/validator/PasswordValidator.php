<?php
	
namespace Pohome\Validator;
	
use Phalcon\Mvc\Model\Validator,
	Phalcon\Mvc\Model\ValidatorInterface;
	
class PasswordValidator extends Validator implements ValidatorInterface
{
	public function validate($model)
	{
		$field = $this->getOption('field');

		$value = $model->$field;
		
//		echo $value;

		if(preg_match('/^[a-zA-Z0-9][a-zA-Z0-9!@#\$%\^&*()_+\-=]{7,20}$/', $value) == 0 ||
		   preg_match('/^(.*?)\d+(.*?)$/', $value) == 0 ||
		   preg_match('/^(.*?)[a-zA-Z]+(.*?)$/', $value) == 0) {
			$this->appendMessage(
				'Invalid password format.',
				$field,
				'PasswordValidator'
			);
			return false;
		}
		return true;
	}
}