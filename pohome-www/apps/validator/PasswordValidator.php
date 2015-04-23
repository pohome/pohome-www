<?php
	
namespace Pohome\Validator;
	
use Phalcon\Mvc\Model\Validator,
	Phalcon\Mvc\Model\ValidatorInterface;
	
class PasswordValidator extends Validator implements ValidatorInterface
{
	public function validate(\Phalcon\Mvc\ModelInterface $model)
	{
		$field = $this->getOption('field');

		$value = $model->$field;
		
		if (preg_match('/^\$2a\$.{56}$/', $value)) {
    		return true;
		}
		
		if (preg_match('/^[a-zA-Z0-9][a-zA-Z0-9!@#\$%\^&*()_+\-=]{7,20}$/', $value) == 0 &&
		    preg_match('/^(.*?)\d+(.*?)$/', $value) == 0 &&
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