var I = {
		//'DOMAIN' : '/demo'
		'DOMAIN' : 'https://dev.imaicloud.com/iam-web'
}

Loader = (function() {

  var load_cursor = 0;
  var load_queue;

  var loadFinished = function() {
    load_cursor ++;
    if (load_cursor < load_queue.length) {
      loadScript();
    }
  }

  function loadError (oError) {
    console.error("The script " + oError.target.src + " is not accessible.");
  }

  var loadScript = function() {
    var url = load_queue[load_cursor];
    var script = document.createElement('script');
    script.type = "text/javascript";

    if (script.readyState){  //IE
        script.onreadystatechange = function(){
            if (script.readyState == "loaded" ||
                    script.readyState == "complete"){
                script.onreadystatechange = null;
                loadFinished();
            }
        };
    } else {  //Others
        script.onload = function(){
            loadFinished();
        };
    }

    script.onerror = loadError;

    script.src = url;//+'?'+'time='+Date.parse(new Date());
    document.body.appendChild(script);
  };

  var loadMultiScript = function(url_array) {
    load_cursor = 0;
    load_queue = url_array;
    loadScript();
  }

  return {
    load: loadMultiScript,
  };

})();  // end Loader

init();

/**
初始化
*/
function init() {
	
	importresource();
	
	var itoken = getCookie("itoken");
	
	var viewSucceed;
	var viewSucceedArray = [];
	if(itoken == "") {
 		viewSucceedArray.push('<div class="sign"><a onclick="login()">登录</a></div>');
 		viewSucceedArray.push('<div class="sign"><a onclick="signup()">注册</a></div>');
	} else {
		viewSucceedArray.push('<a data-toggle="dropdown" data-bind="text:userName" class="username"><span id="username"></span><span class="caret"></span></a>');
		viewSucceedArray.push('<div class="dropdown-menu ue-dropdown-menu dropdown-menu-right">');
		viewSucceedArray.push('<span class="ue-dropdown-angle"></span>');
		viewSucceedArray.push('<img class="user-photo" src="/demo/skins/skin/platform/img/user.jpg"/>');
		viewSucceedArray.push('<div class="user-info">');
		viewSucceedArray.push('<a href="#" class="user-action"><i class="fa fa-edit md">&nbsp;</i>修改资料</a>');
		viewSucceedArray.push('<a href="#" class="user-action"><i class="fa fa-user-md md">&nbsp;</i>个人中心</a>');
		viewSucceedArray.push('</div>');
		viewSucceedArray.push('<div class="exit"><a onclick="logout()">退出</a></div>');
		viewSucceedArray.push('</div>');
	}
	
	viewSucceed = viewSucceedArray.join('');

	var clientDiv = document.getElementById("userInfo");
	clientDiv.innerHTML = viewSucceed;

}(window, document);

/**
引入资源
*/
function importresource() {
	
	var theDate = +new Date();

	// js css import
		//I.DOMAIN + '/skins/skin/css/bootstrap.css',
		//I.DOMAIN + '/skins/skin/css/font-awesome.css',
		//I.DOMAIN + '/skins/skin/css/ui.css',
	var cssArray = new Array(
		I.DOMAIN + '/skins/skin/platform/css/home.css'
	);
	for(var i=0; i<cssArray.length; i++){
		var cssTarget = document.createElement('link');
		cssTarget.rel = 'stylesheet';
		cssTarget.type = 'text/css';
		cssTarget.href = cssArray[i];
		cssTarget.setAttribute('data-timestamp', theDate);
		(document.head).appendChild(cssTarget);
	}
	//	I.DOMAIN + '/skins/js/bootstrap.js',
	var jsArray = new Array(
		I.DOMAIN + '/skins/js/jquery.js',
		I.DOMAIN + '/skins/js/jquery.base64.js',
		I.DOMAIN + '/skins/js/json.js',
		I.DOMAIN + '/skins/js/iamui.js'
	);
	/*for(var i=0; i<jsArray.length; i++){
		var cssTarget = document.createElement('script');
		cssTarget.src = jsArray[i];
		cssTarget.setAttribute('data-timestamp', theDate);
		(document.body).appendChild(cssTarget);
	}*/

	//loading ...
	Loader.load(jsArray);

}

function login() {
	var href = window.location.href;
	window.location.href=I.DOMAIN + '/signin.html?redirectURL=' + encodeURIComponent(href);
}

function signup() {
	window.location.href=I.DOMAIN + '/signup.html';
}
function logout() {
	delCookies("itoken");
	window.location.reload();
}

function setCookie(c_name,value,expiredays){
	var exdate=new Date();
	exdate.setDate(exdate.getDate()+expiredays);
	document.cookie=c_name+ "=" +escape(value)+((expiredays==null) ? "" : ";expires="+exdate.toGMTString())+";path=/";
	//console.log(document.cookie);
}
		
function getCookie(c_name){
	if (document.cookie.length>0){
		c_start=document.cookie.indexOf(c_name + "=");
		if (c_start!=-1){
			c_start=c_start + c_name.length+1;
			c_end=document.cookie.indexOf(";",c_start);
			if (c_end==-1){
				c_end=document.cookie.length;
			}
			return unescape(document.cookie.substring(c_start,c_end))
		} 
	}
	return "";
}

function delCookies(name){
	var cookes = name.split(",");
	var exp = new Date();
	exp.setTime(exp.getTime() - 1);
	for(var i = 0; i != cookes.length; ++i){
		var cval=getCookie(cookes[i]);
		if(cval!=null)
		document.cookie= cookes[i] + "="+cval+";expires="+exp.toGMTString() + ";path=/";
	}
}
