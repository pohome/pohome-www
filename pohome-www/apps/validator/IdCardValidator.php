<?php
	
namespace Pohome\Validator;
	
use Phalcon\Mvc\Model\Validator,
	Phalcon\Mvc\Model\validatorInterface;
	
class IdCardValidator extends Validator implements ValidatorInterface
{
	public function validate($model)
	{
		$field = $this->getOption('field');
		
		$value = $model->$field;
		
		if($this->checkIdCardNumber($value)) {
			$this->appendMessage(
				'Invalid ID card format',
				$field,
				'IdCardValidator'
			);
			return false;
		}
		return true;
	}
	
	private function checkIdCardNumber($num)
	{
		$district = substr($num, 0, 6);
		$birthday = substr($num, 6, 8);
		$checksum = $num[17];
		
		if(strtotime($birthday) == false) {
			return false;
		}
		
		if($checksum <> $this->calculateChecksum($num)) {
			return false;
		}
	}
	
	private function calculateChecksum($num)
	{
		$factor = array(7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2);
		$checksum = array(1, 0, 'X', 9, 8, 7, 6, 5, 4, 3, 2);
		$sum = 0;
		
		for($i = 0; $i < 17; $i++)
		{
			$sum += $factor[$i] * $id_num[$i];
		}
		
		return $checksum[$sum % 11];
	}
}