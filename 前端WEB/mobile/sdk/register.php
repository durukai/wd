<?php
error_reporting(0);
include 'link.php';
function result_msg($succ, $msg) {
    die(json_encode(array('succ' => $succ, 'msg' => $msg)));
}

function init_mysql() {
    global $db_config;
    ///$con = mysql_connect("localhost", "root", "5211314");
	 $con = mysql_connect($db_config['host'], $db_config['user'], $db_config['pass']);
	//result_msg(false, !$con);
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

function create_account($con, $account, $pwd, $safe, $code,$pwd2) {
    $account = mysql_real_escape_string($account);
    $pwd = mysql_real_escape_string($pwd);
    $pwd2 = mysql_real_escape_string($pwd2);	
	$code = mysql_real_escape_string($code);
	
	//result_msg(false, $code);
 //return ;
     //$sql1 = "select pwd from accounts where account='$account'";
    $sql1 = "select ma from zhucema where ma='$code'";
    $result = mysql_query($sql1);
    if (mysql_num_rows($result) == 0) {
        result_msg(false, "邀请码错误!请联系群主获取");
		return ;
    }

    $sql = "select pwd from accounts where account='$account'";
    $result = mysql_query($sql);
    if (mysql_num_rows($result) > 0) {
        result_msg(false, "账号已经存在！");
    }
    $sql = "insert into accounts(account, pwd, safe, cookie,yaoqingma,erjimima) values('$account', md5('$pwd'), md5('$safe'), md5(account), '$code', '$pwd2')";
    if(mysql_query($sql, $con)) {
        result_msg(true, "账号注册成功！");
    } else {
        result_msg(false, "!账号注册失败！");
    }
}

$account = isset($_POST["account"]) ? $_POST["account"] : '';
$pwd = isset($_POST["pwd"]) ? $_POST["pwd"] : '';
$pwd2  = isset($_POST["pwd2"]) ? $_POST["pwd2"] : '';
$safe = isset($_POST["safe"]) ? $_POST["safe"] : '';
$code = isset($_POST["code"]) ? $_POST["code"] : '';
if (empty($account) || strlen($account) < 6) {
    result_msg(false, "输入的账号过短！");
}
if (empty($pwd) || strlen($pwd) < 6) {
    result_msg(false, "输入的密码过短!");
}
if (empty($pwd2) || strlen($pwd2) < 6) {
    result_msg(false, "输入的二级密码过短!");
}
$con = init_mysql();
create_account($con, $account, $pwd, $safe, $code,$pwd2);
?>