<?php
//error_reporting(0);
include 'link.php';

function result_msg($succ, $msg) {
    die(json_encode(
        array(
            'status'    => ($succ ? 'success' : 'fail'),
            'type'      => ($succ ? '1' : '10001'),
            'message'   => $msg,
        )));
}

function init_mysql() {
    global $db_config;
    $con = mysql_connect($db_config['host'], $db_config['user'], $db_config['pass']);
    if (!$con) {
        result_msg(false, "网络异常0x00！");
    }
    if(!mysql_select_db($db_config['db'], $con)) {
        result_msg(false, "网络异常0x1！");
    }
    if(!mysql_set_charset("utf8", $con)) {
        result_msg(false, "网络异常0x2！");
    }
    return $con;
}

function decrypt($sStr, $sKey) {
    $decrypted= mcrypt_decrypt(MCRYPT_DES, $sKey, $sStr, MCRYPT_MODE_ECB);
    $dec_s = strlen($decrypted);
    $padding = ord($decrypted[$dec_s-1]);
    $decrypted = substr($decrypted, 0, -$padding);
    return $decrypted;
}

function verify($account, $timestamp , $token) {
    $account = mysql_real_escape_string($account);
    //$pwd = mysql_real_escape_string($pwd);
  //  $pwd = md5($pwd);

    $sql = "select sid, pwd, cookie, concat(unix_timestamp(regist_time), '000') as regist_time from accounts where account = '$account'";
    $result = mysql_query($sql);
    if (mysql_num_rows($result) == 0) {
        result_msg(false, "账号不存在!");
    }
    $result = mysql_fetch_assoc($result);
   // if (!isset($result['sid']) || !isset($result['pwd']) || !isset($result['cookie']) || !isset($result['regist_time'])) {
     //   result_msg(false, "数据错误!");
  //  }
    //if ($pwd !== $result['pwd']) {
     //   result_msg(false, "密码错误!");
  //  }
    result_msg(true, json_encode(array(
	    'timestamp'     => $timestamp ,
		'realNameAuth'  => '1',
        'warnEndDate'   => '2018-12-16',
		'token'         => $token ,
		'age'           => '25',
        'adult'         => '1',
        'isFast'        => '5',
        'bind'          => '1',
        'registTime'    => 1492136395000,
     
    )));
}

$account = isset($_POST['username']) ? $_POST['username'] : '';
$timestamp = isset($_POST['timestamp']) ? $_POST['timestamp'] : '';
$token = isset($_POST['token']) ? $_POST['token'] : '';

///$pwd = hex2bin($pwd);
///$pwd = decrypt($pwd, $pwd);

 //result_msg(false,$token);

if (empty($account) || strlen($account) < 6) {
    result_msg(false, "输入的账号过短!");
}

if (empty($token) || strlen($token) < 6) {
    result_msg(false, "token不存在!");
}

init_mysql();
verify($account, $timestamp , $token);
?>