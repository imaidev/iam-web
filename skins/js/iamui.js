var CookieKeys = {
	"expire": "imaicloud_expires",
	"payload": "imaicloud_payload",
	"algorithm":"imaicloud_md5",
	"group":"imaicloud_role",
}
$(function(){
	// 头像菜单
	$('#userInfo').hover(function(){
		$($(this).children("div[class!='sign']")).show(); 		
	},function() {
		$($(this).children("div[class!='sign']")).hide();		
	});

	var itoken = getCookie("itoken");
	if(itoken != "" && itoken != null) {
		var tokenInfo = itoken.split(".");
		if(tokenInfo.length != 3) {
			login();
		} else {
			var payload = $.base64.decode(tokenInfo[1]);
			var userInfo = JSON.parse(payload);
			$("#username").text(userInfo.uname);
			$("#id").text(userInfo.accountId);
			$("#email").text(userInfo.email);
			$("#username").text(userInfo.username);
			$("#tenant").text(userInfo.tenant);
			$("#tenantKey").text(userInfo.tenantKey);
			setCookie(CookieKeys.expire, userInfo.exp);
			setCookie(CookieKeys.payload, tokenInfo[1]);
			setCookie(CookieKeys.algorithm, tokenInfo[2]);
			setCookie(CookieKeys.group, userInfo.group);
		}
		
	}
});	

