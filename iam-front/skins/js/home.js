function logout(){
	$.dialog({
		type: 'confirm',
		content: '您确定要退出系统吗？',
		ok: function () {
//		    	delCookies("topMenu,favoritesMenu,initModelName,leftMenu,ifram");
			document.location.href= context + "/logout";
			},
		cancel: function () {},
		autofocus: true
	}).showModal();
}    


//保存菜单到cookie中
function setCookie(name, value){
	document.cookie = name + "=" + escape(value);
}
//获取cookie中的菜单
function getCookie(name) {
	var cookies = document.cookie;
	var menu_cookies = cookies.split(';');
	for (var i = 0; i <  menu_cookies.length; i++) {
		var arr = menu_cookies[i].split("=");
		if (arr[0] == name||arr[0] ==" "+name){
			return unescape(arr[1]);
		}
	}
	return null;
}
//删除cookie中的菜单
function delCookies(name){
	var cookes = name.split(",");
	var exp = new Date();
	exp.setTime(exp.getTime() - 1);
	for(var i = 0; i != cookes.length; ++i){
		var cval=getCookie(cookes[i]);
		if(cval!=null)
		document.cookie= cookes[i] + "="+cval+";expires="+exp.toGMTString();
	}
}