<?php

namespace Pohome\Validator;
	
use Phalcon\Mvc\Model\Validator,
	Phalcon\Mvc\Model\ValidatorInterface;
	
class PetnameValidator extends Validator implements ValidatorInterface
{
	public function validate(\Phalcon\Mvc\EntityInterface $model)
	{
		$field = $this->getOption('field');

		$min = $this->getOption('min');
		$max = $this->getOption('max');

		$value = $model->$field;

		$exp = sprintf('/^[a-zA-Z \x{4e00}-\x{9fa5}]{%d,%d}$/u', $min, $max);

		if(preg_match($exp, $value) == 0) {
			$this->appendMessage(
				'Invalid pet name format.',
				$field,
				'PetnameValidator'
			);
			return false;
		}
		return true;
	}
}