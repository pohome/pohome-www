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