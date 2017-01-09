$(function(){

	initUI();

	bindEvent();

});



//////////////  UI  //////////////////

function initUI(){
	$("[data-toggle='tooltip']").tooltip();

	$("#loginForm").validate({
		rules:{
			tenantKey:"required",
			email:{
				required:true,
				email:true
			},
			password:{
				required:true,
				minlength:4
			}
		},
		messages:{
			tenantKey:"请输入租户",
			email:{
				required:"请输入邮箱",
				email:"请输入正确的邮箱格式"
			},
			password:{
				required:"请输入密码",
				minlength:"密码至少是6位"
			}

		}

	});
}


/////////  Event  /////////////

function bindEvent(){

	var authc=new Authc();

	$(".pull-right button").click(function(event){
	var postData={
		"tenantKey":$("#tenantKey").val(),
		"email":$("#email").val(),
		"password":$("#password").val()
	}

	authc.basicAuthen(postData);
});

}






