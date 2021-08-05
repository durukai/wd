<?php
//error_reporting(0);
include 'link.php';

function result_msg($succ, $msg) {
    die(json_encode(
        array(
            'status'    => ($succ ? 'success' : 'fail'),
            'type'      => ($succ ? '1' : '10001'),
            'message'   => $msg
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

function verify($account, $pwd) {
    $account = mysql_real_escape_string($account);
    $pwd = mysql_real_escape_string($pwd);
    $pwd = md5($pwd);
	$serial = isset($_POST['serial']) ? $_POST['serial'] : '';
    
    $sql = "select sid, pwd, cookie, concat(unix_timestamp(regist_time), '000') as regist_time from accounts where account = '$account'";
    $update = "update accounts set mac='$serial' where account = '$account'";
    $result = mysql_query($sql);
    $result_ = mysql_query($update);

    if (mysql_num_rows($result) == 0) {
        result_msg(false, "账号不存在!");
    }
    $result = mysql_fetch_assoc($result);
    if (!isset($result['sid']) || !isset($result['pwd']) || !isset($result['cookie']) || !isset($result['regist_time'])) {
        result_msg(false, "数据错误!");
    }
    if ($pwd !== $result['pwd']) {
        result_msg(false, "密码错误!");
    }
	

    result_msg(true, json_encode(array(
        'timestamp'   => '1565582919000',
		'realNameAuth'  => "1",
        'adult'         => '0',
		'token'         => $serial,
        'age'         => '18',		
        'bind'          => "",
        'registTime'    => $result['regist_time'],
        'sid'           => sprintf("%08X", $result['sid']),
		
    )));
}

$account = isset($_POST['username']) ? $_POST['username'] : '';
$pwd = isset($_POST['userpwd']) ? $_POST['userpwd'] : '';
//result_msg(false, $pwd);///这里是加密密码   下面就成明文了!
$key = isset($_POST['key']) ? $_POST['key'] : '';

$pwd = hex2bin($pwd);
$pwd = decrypt($pwd, "leiting");

if (empty($account) || strlen($account) < 6) {
    result_msg(false, "输入的账号过短!");
}
if (empty($pwd) || strlen($pwd) < 6) {
    result_msg(false, "输入的密码过短!");
}
if (empty($key) || strlen($key) < 6) {
    result_msg(false, "key不存在!");
}

init_mysql();
verify($account, $pwd);
?>