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

function create_account($con, $account, $Safety, $newpwd) {
    $account = mysql_real_escape_string($account);
    $Safety = mysql_real_escape_string($Safety);
	$newpwd = mysql_real_escape_string($newpwd);
	
	//result_msg(false, $code);
 //return ;
     //$sql1 = "select pwd from accounts where account='$account'";
    
    $sql = "select erjimima from accounts where account='$account'";
    $result = mysql_query($sql);
    if (mysql_num_rows($result) == 0) {
        result_msg(false, "账号不存在！");
         			 				 	
    }else {
    //result_msg(false, "账号存在！");
	
	$row = mysql_fetch_assoc($result);
    
	$safe =  $row['erjimima'];
	///$newerji = ($Safety);
	
	//result_msg(false,$Safety);
	//ecd6828e10828838a2d34fef2919a977
	
	  if  ($safe ==  $Safety){
		   $sql = "UPDATE accounts SET pwd=md5('$newpwd') WHERE account='$account'";
		    $result = mysql_query($sql);
			if ($result){
			result_msg(true, "密码重置成功请牢记");	
				
			} 
		   
	  } else{
		    
		result_msg(false, "密码修改失败！");	 
		  
	  }		
}
	
	
    ///$sql = "insert into accounts(account, pwd, safe, cookie,yaoqingma) values('$account', md5('$pwd'), md5('$safe'), md5(account), '$code')";
    //if(mysql_query($sql, $con)) {
     //   result_msg(true, "账号注册成功！");
   // } else {
        //result_msg(false, "!账号注册失败！");
   // }
}

$account = isset($_POST["account"]) ? $_POST["account"] : '';
$Safety = isset($_POST["Safety"]) ? $_POST["Safety"] : '';
$newpwd = isset($_POST["newpwd"]) ? $_POST["newpwd"] : '';
if (empty($account) || strlen($account) < 6) {
    result_msg(false, "输入的账号过短！");
}
if (empty($Safety) || strlen($Safety) < 6) {
    result_msg(false, "二级密码太短!");
}
if (empty($newpwd) || strlen($newpwd) < 6) {
    result_msg(false, "输入的密码过短!");
}
$con = init_mysql();
create_account($con, $account, $Safety, $newpwd);
?>