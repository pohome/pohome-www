<?php

namespace Pohome\Validator;
	
use Phalcon\Mvc\Model\Validator,
	Phalcon\Mvc\Model\ValidatorInterface;
	
class UsernameValidator extends Validator implements ValidatorInterface
{
	public function validate(\Phalcon\Mvc\EntityInterface $model)
	{
		$field = $this->getOption('field');

		$min = $this->getOption('min');
		$max = $this->getOption('max');

		$value = $model->$field;

		$exp = sprintf('/^[a-zA-Z0-9_\x{4e00}-\x{9fa5}]{%d,%d}$/u', $min, $max);

		if(preg_match($exp, $value) == 0) {
			$this->appendMessage(
				'Invalid username format.',
				$field,
				'UsernameValidator'
			);
			return false;
		}
		return true;
	}
}