<?php

static $sequence = 0;
static $last_timestamp = 0;
$twepoch = 1419120000; // 60 * 60 * 24 * 365 * (2015 - 1970)

function gen_uuid()
{
	$timestamp = time();
	$machine_id = rand(0, 16);
	$random = rand(0, 1048576);
	
	global $last_timestamp, $sequence, $twepoch;
	
	if($timestamp == $last_timestamp) {
		$sequence++;
		$sequence %= 64;
	} else {
		$sequence = 0;
		$last_timestamp = $timestamp;
	}
	
	$uuid = ($timestamp - $twepoch) << 30 | ($machine_id << 26) | ($random << 6) | $sequence;
	return $uuid;
}

function submail(array $m)
{
    global $mail_configs;
    $mail = new MAILSend($mail_configs);
    
    if(array_key_exists('to', $m)) {
        if(!is_array($m['to'])) {
            $mail->AddTo($m['to']);
        } else {
            $mail->AddTo(implode(',', $m['to']));
        }
    } else {
        return false;
    }
    
    if(array_key_exists('from', $m) && array_key_exists('name', $m)) {
        $mail->SetSender($m['from'], $m['name']);
    } else {
        return false;
    }
    
    if(array_key_exists('title', $m)) {
        $mail->SetSubject($m['title']);
    } else {
        return false;
    }
    
    if(array_key_exists('text', $m) || array_key_exists('html', $m)) {
        if(array_key_exists('html', $m)) {
            $mail->SetHtml($m['html']);
        } else {
            $mail->SetText($m['text']);
        }
    } else {
        return false;
    }
    

    $result = $mail->send();
    if($result['status'] == 'success') {
        return true;
    } else {
        return false;
    }
}