function Server(){
	this.protocol="https";
	this.host="dev.imaicloud.com";
	this.port="443";
	this.context="/iam";

	this.init=function(){
	var _that=this;
	var protocol=_that.protocol;
	var host=_that.host;
	var port=_that.port;
	var context=_that.context;
	var url;
	if(port==80 || port==443){
		url=protocol+"://"+host+context;
	}else{
		url=protocol+"://"+host+":"+port+context;
	}

	return url;
	}
}

function Authc(){
	var context=this.server.init();
	this.loginUrl=context+"/admin/login";
	this.registerUrl=context+"/admin/register";

	this.basicAuthen=function(postData){
		var email=postData.email;
		var password=postData.password;
		$.base64.utf8encode=true;
		var value=$.base64.encode(email+":"+password);
		postData.value=value;
		postData.type="basic";

		$.ajax({
		type:"POST",
		url:this.loginUrl,
		contentType:"application/json;charset=utf-8",
		dataType:"json",
		data:JSON.stringify(postData),
		success:function(data){

			if(data.code=="2000"){
				alert("登录错误！");
			}else{
				$.cookie("itoken",data.itoken,{expires:7,path:'/'});
				var tokenInfo=data.itoken.split(".");
				if(tokenInfo.length==3){
					var payload=$.base64.decode(tokenInfo[1]);
					var userInfo=JSON.parse(payload);
					$.cookie('imaicloud_expires',userInfo.exp,userInfo.exp);
					$.cookie('imaicloud_payload',tokenInfo[1],userInfo.exp);
					$.cookie('imaicloud_md5',tokenInfo[2],userInfo.exp);
					$.cookie('imaicloud_role',userInfo.group,userInfo.exp);
					$.cookie('iamicloud_tenant',userInfo.tenant,userInfo.exp);

					var redirectURL=document.referer;
					if(redirectURL !="" && redirectURL!=null){
						window.location.href=decodeURIComponent(redirectURL);
					}else{
						window.location.replace("index.html");
					}
				}
			}


		},
		error:function(e){
			location.reload();
		}

		});

	}
}
Authc.prototype.server=new Server();

////////////  会话管理  ///////////////////////////////

function Session(){
	var tenant=$.cookie("iamicloud_tenant");
	this.tenant=tenant;
	if(tenant==null){
		this.isLogin=false;
	}else{
		this.isLogin=true;
	}
}


/////////////  资源管理  /////////////////////////

function Resource(){

	this.init=function(allUrl){
	var options={
		ordering:false
	};

	var grid=new L.FlexGrid("dataList",allUrl);
	grid.setParameter("start","1");
	grid.setParameter("limit","10");
	grid.init(options);
	}

	this.getOne=function(href){
		var _that=this;
		$.ajax({
		type:"GET",
		url : href,
		async:false,		
		success : function(data) {
			_that.data=data;
		},
		error:function(e){
			_that.error=e;
		}
	});
	}

	this.delOne=function(href){

	}

}



function App(){
	var server=new Server();
	this.context=server.init();
	this.initUrl=function(){
		this.allUrl=this.context+"/v1/applications";
	}
	
}
App.prototype=new Resource();


function Organ(){
	var server=new Server();
	this.context=server.init();
	this.initUrl=function(){
		this.allUrl=this.context+"/v1/organizations";
	}

}
Organ.prototype=new Resource();


function Directory(){
	var server=new Server();
	this.context=server.init();
	this.initUrl=function(){
		this.allUrl=this.context+"/v1/directories";
	}

}
Directory.prototype=new Resource();


function Group(){
	var server=new Server();
	this.context=server.init();
	this.initUrl=function(){
		this.allUrl=this.context+"/v1/groups";
	}
}
Group.prototype=new Resource();


function Account(){
	var server=new Server();
	this.context=server.init();
	this.initUrl=function(){
		this.allUrl=this.context+"/v1/accounts";
	}
}
Account.prototype=new Resource();


//表格渲染1：Checkbox
function renderCheckbox(data, type, full) {
	var checkboxDom='<input type="checkbox" value="' + data + '" name="selectId"/>';
	return checkboxDom;
}

//表格渲染2：Button
function renderBtn(data, type, full) {	
	var delBtnDom = "<a href=\"javascript:showDelModal('" + data  + "')\">删除</a>";
	var editBtnDom = "<a href=\"detail.html#" + data + "\">编辑</a>";
	return editBtnDom + "&nbsp;&nbsp;&nbsp;" + delBtnDom;
}
