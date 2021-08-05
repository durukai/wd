var account_url="http://121.4.95.230:6889";
var isWaitForResponse = false;
var countDownTime = 120;
var reg = {
    "phone"  :  /^1\d{9,11}$/,
    "email"  :  /^(\w-*\.*)+@(\w-?)+(\.\w{2,})+$/,
    "pwd" :	/^\w{6,32}$/,
    "chineseChar"  :  /^[\u4e00-\u9fa5]+$/
}

//验证身份证号码合法性
function validateIdCard(idCard){
    //15位和18位身份证号码的正则表达式
    var regIdCard=/^(^[1-9]\d{7}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}$)|(^[1-9]\d{5}[1-9]\d{3}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])((\d{4})|\d{3}[Xx])$)$/;

    //如果通过该验证，说明身份证格式正确，但准确性还需计算
    if(regIdCard.test(idCard)){
        if(idCard.length==18){
            var idCardWi=new Array( 7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2 ); //将前17位加权因子保存在数组里
            var idCardY=new Array( 1, 0, 10, 9, 8, 7, 6, 5, 4, 3, 2 ); //这是除以11后，可能产生的11位余数、验证码，也保存成数组
            var idCardWiSum=0; //用来保存前17位各自乖以加权因子后的总和
            for(var i=0;i<17;i++){
                idCardWiSum+=idCard.substring(i,i+1)*idCardWi[i];
            }

            var idCardMod=idCardWiSum%11;//计算出校验码所在数组的位置
            var idCardLast=idCard.substring(17);//得到最后一位身份证号码

            //如果等于2，则说明校验码是10，身份证号码最后一位应该是X
            if(idCardMod==2){
                if(idCardLast=="X"||idCardLast=="x"){
                    return true;
                }else{
                    return false;
                }
            }else{
                //用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
                if(idCardLast==idCardY[idCardMod]){
                    return true;
                }else{
                    return false;
                }
            }
        }else{
            return false;
        }
    }else{
        return false;
    }
}

//后退
function back(){
    jsObject.goBack();
}

//关闭
function close(){
    jsObject.close();
}

//查看用户协议
function goProtocol(){
    jsObject.goProtocol();
}

//通用发送
function send_fn(url,data,callback){
	if(isWaitForResponse) {
		return;
	}else {
        isWaitForResponse = true;
	}
    $.ajax({
        type:"post",
        url:url,
        data:data,
        dataType:'json',
        success:function(data){
            callback(data);
            setTimeout(function (args) {
                isWaitForResponse = false;
            },1000);
        },
        error:function(){
            popup_fn("网络异常，请稍后再试！");
            setTimeout(function (args) {
                isWaitForResponse = false;
            },500);
        }
    });
}

function countDown(obj, period) {
    // obj.attr("disabled", true);
    var href = obj.attr('href');
    obj.removeAttr('href');
    var time = setInterval(function() {
        period--;
        if (period <= 0) {
            clearInterval(time);
            obj.html('获取验证码');
            obj.attr("disabled", false);
            obj.attr('href',href);
            return;
        }
        obj.html(period + 's');
    }, 1000);
};

function resendCountDown(phone, type, period) {
    var obj = $('#countDown');
    var time = setInterval(function() {
        period--;
        if (period <= 0) {
            clearInterval(time);
            obj.html('<a href="javascript:reSend('+phone+','+type+')"><span>获取验证码</span></a>');
            return;
        }
        obj.html('<span>'+period+'</span>s');
    }, 1000);
};

function reSend(phone, type) {
    sendPhoneCode(phone,type,function () {
        resendCountDown(phone,type,countDownTime);
    });
}

function sendPhoneCode(phone, type, callback){
    var url=account_url+"/sdk/account/send_phone_code";
    var time = String(new Date().getTime());
    var data={"phone":phone,"type":type,"timestamp":time,"sign":jsObject.getAccountSign(phone+type.toString(),time)};
    send_fn(url,data,function(result){
        if(result.status === '1') {
            callback();
        } else {
            popup_fn(result.message);
        }
    });
}

function resendBindCountDown(username, type, period) {
    var obj = $('#countDown');
    var time = setInterval(function() {
        period--;
        if (period <= 0) {
            clearInterval(time);
            obj.html('超时？<a href="javascript:reSendBind('+username+','+type+')"><span>重新发送</span></a>');
            return;
        }
        obj.html('<span>'+period+'</span>秒重新发送');
    }, 1000);
};

function reSendBind(username, type) {
    sendBindPhoneCode(username,type,function () {
        resendBindCountDown(username,type,countDownTime);
    });
}

function sendBindPhoneCode(username, type, callback){
    var url=account_url+"/sdk/account/send_bind_phone_code";
    var time = String(new Date().getTime());
    var data={"username":username,"type":type,"timestamp":time,"sign":jsObject.getAccountSign(username+type.toString(),time)};
    send_fn(url,data,function(result){
        if(result.status === '1') {
            callback();
        } else {
            popup_fn(result.message);
        }
    });
}
// 显示隐藏
function showPassword() {
    var oInput = $('.common_ulPraent .show_password').parents('li').find('.common_text');
    if (oInput.attr('type') == 'text') {
        oInput.attr('type', 'password');
        $('.common_ulPraent .show_password').text('显示');
    } else {
        oInput.attr('type', 'text');
        $('.common_ulPraent .show_password').text('隐藏');
    }
}
//弹出提示窗
function popup_fn(msg){
    $('.common_popUp p').html(msg).parent().fadeIn(30).removeClass('hidden');
    var time=setInterval(function(){
        $('.common_popUp').fadeOut(30).addClass('hidden');
        clearInterval(time);
    },3000);
};
