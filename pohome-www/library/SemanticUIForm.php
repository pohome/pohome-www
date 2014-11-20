<?php
	
namespace Pohome\SemanticUIForm;
	
class SemanticUIForm
{
	protected $name;
	protected $fields = array();
	protected $button = array();
	
	public function __construct($formName)
	{
		$filename = '../apps/backend/forms/' . $formName . '.json';
		$fs = json_decode(file_get_contents($filename), true); // file string
		
		if(is_null($fs)) {
			echo 'Error found in JSON file.';
			die();
		}
		
		$this->name = 'form_' . $formName;
		$this->fields = $fs['fields'];
		$this->buttons = $fs['buttons'];
	}
	
	public function html()
	{
		echo '<form class="ui form segment" id="ajaxForm" method="post" enctype="multipart/form-data">';
		
		foreach($this->fields as $f)
		{
			switch($f['type'])
			{
				case 'inputText':
					$this->inputText($f['name'], $f['label'], $f['attr']);
					break;
					
				case 'radio':
					$this->radio($f['name'], $f['label'], $f['data']);
					break;
					
				case 'CheckBox':
					$this->checkbox($f['name'], $f['label'], $f['data']);
					break;
					
				case 'dropdown':
					$this->dropdown($f['name'], $f['label'], $f['default'], $f['data']);
					break;
					
				case 'FileUpload':
					$this->fileUpload($f['name'], $f['label']);
					break;
					
				case 'textarea':
					$this->textarea($f['name'], $f['label'], $f['width'] = 40);
					break;
				
				case 'redactorEditor':
					$this->radio($f['name'], $f['label']);
					break;
					
				case 'ImagesUpload':
					$this->imagesUpload($f['name'], $f['label']);
					break;
			}
		}
		
		foreach($this->buttons as $b)
		{
			$this->button($b['name'], $b['label'], $b['color'], $b['submit']);
		}
		
		echo '</form>';
	}
	
	public function validate($post, &$result)
	{
		foreach($this->fields as $f)
		{
			$name = $f['name'];
			
			if(array_key_exists($name, $post)) {
				
				// 非空
				if(array_key_exists('required', $f) && $f['required'] && empty($post['name'])) {
					
					$result['hasError'] = true;
					array_push($result['errorMsg'], $f['label'] . '不能为空');
					array_push($result['errorField'], $f['name']);
				}
				
				// 最大长度
				if(array_key_exists('max_length', $f)) {
					$maxLength = $f['max_length'];
					if(mb_strlen($post['name']) > $maxLength) {
						$result['hasError'] = true;
						$result['errorMsg'][] = $f['label'] . '的长度超过了' . $maxLength;
						if(array_key_exists($name, $result['errorField'])) {
							$result['errorField'][] = $name;
						}
					}
				}
				
				// 唯一
				if(array_key_exists('unique', $f)) {
					$tableName = $f['unique']['table'];
					$columnName = $f['unique']['column'];
					
				}
			}
		}
	}
	
	public function inputText($name, $label, $attr, $type = 'text')
	{
		$id = 'fid_'.$name;
		
		echo '<div class="inline field">';
		echo '<label>'.$label.'</label>';
		if(array_key_exists('icon', $attr)) {
			echo '<div class="ui left icon input">';
			if(array_key_exists('placeholder', $attr)) {
				printf('<input type="%s" name="%s" id="%s" placeholder="%s" />', $type, $name, $id, $attr['placeholder']);
			} else {
				printf('<input type="%s" name="%s" id="%s" />', $type, $name, $id);
			}
			printf('<i class="%s icon"></i>', $attr['icon']);
			echo '</div>';
		} else {
			if(array_key_exists('placeholder', $attr)) {
				printf('<input type="%s" name="%s" id="%s" placeholder="%s" />', $type, $name, $id, $attr['placeholder']);
			} else {
				printf('<input type="%s" name="%s" id="%s" />', $type, $name, $id);
			}
		}
		echo '</div>';
	}
	
	public function radio($name, $label, $data)
	{
		echo '<div class="inline field">';
		printf('<label>%s</label>', $label);
		foreach($data as $key => $value) {
			echo '<div class="ui radio checkbox">';
			printf('<input type="radio" name="%s" value="%s"><label>%s</label>', $name, $value, $key);
			echo '</div>';
		}
		echo '</div>';
	}
	
	public function checkbox($name, $label, $data)
	{
		echo '<div class="inline field">';
		printf('<label>%s</label>', $label);
		foreach($data as $key => $value) {
			echo '<div class="ui checkbox">';
			printf('<input type="checkbox" name="%s" value="%s"><label>%s</label>', $name, $value, $key);
			echo '</div>';
		}
		echo '</div>';
	}
	
	public function dropdown($name, $label, $default, $data)
	{
		echo '<div class="inline field">';
		printf('<label>%s</label>', $label);
		echo '<div class="ui selection dropdown">';
		printf('<input type="hidden" name="%s" />', $name);
		printf('<div class="default text">%s</div>', $default);
		echo '<i class="dropdown icon"></i>';
		echo '<div class="menu">';
		foreach($data as $key => $value) {
			printf('<div class="item" data-value="%s">%s</div>', $value, $key);
		}
		echo '</div></div></div>';		
	}
	
	public function fileUpload($name, $label)
	{
		echo '<div class="inline field">';
		printf('<label>%s</label>', $label);
		printf('<input type="file" name="%s" />', $name);
		echo '</div>';
	}
	
	public function textarea($name, $label, $width)
	{
		echo '<div class="inline field">';
		printf('<label>%s</label>', $label);
		printf('<textarea name="%s" style="width: %sem"></textarea>', $name, $width);
		echo '</div>';
	}
	
	public function redactorEditor($name, $label)
	{
		echo '<div class="inline field">';
		printf('<label class="redactor label">%s</label>', $label);
		printf('<textarea id="content" name="%s"></textarea>', $name);
		echo '</div>';
	}
	
	public function button($name, $label, $color, $submit = true)
	{
		$id = 'btn_'.$name;
		
		echo '<div class="inline field"><label></label>';
		if($submit) {
			printf('<input name="%s" id="%s" type="submit" class="ui %s submit button" value="%s" />', $name, $id, $color, $label);
		} else {
			printf('<input name="%s" id="%s" type="button" class="ui %s submit button" value="%s" />', $name, $id, $color, $label);
		}
		echo '</div>';
	}
	
	public function images($name, $label, $photo = array())
	{
		echo '<div class="inline field">';
		printf('<label style="vertical-align: top">%s</label>', $label);
		echo '<div class="multiple picture upload">';
		
		if(!empty($photo)) {
			foreach($photo as $p) {
				echo '<div class="photo box"><div class="photo wrap">';
				printf('<img src="%s" style="max-width: 160px;max-height: 160px;display: block">', $p);
				echo '</div></div>';
			}
		}
		
		echo '<div class="ui photo upload box" id="photoUploadField"><div class="ui dimmer" id="photoUploadLoaderIndicator"><div class="ui small text loader">上传中...</div></div><div class="photo upload wrap" id="photo_upload_wrap">';
		echo '<p>点击选择要上传的图片</p>';
		echo '<p>或者</p>';
		echo '<p>拖拽要上传的图片至此</p>';
		echo '</div></div>';
		echo '<input type="file" id="photoUploadHiddenField" name="files[]" multiple hidden />';
		echo '</div></div>';
	}
}