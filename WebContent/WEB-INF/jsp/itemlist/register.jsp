<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>注册</title>
	<style type="text/css">
	/* 默认设置*/
	*
	{
		margin: 0px;
		padding:0px;	
	}
	a
	{
		text-decoration:none;
	}
	ul,ol
	{
		list-style: none;
	}

     /* 设置头部登陆框和导航栏*/
	.top
	{
		background-color: #F7F7F7;
	}
	.lg
	{
		width: 1200px;
		margin: 0 auto;
	}
	.lg li
	{
		height: 30px;
		line-height: 30px;
		display: inline-block;
		margin-left: 5px;
	}
	.lg a
	{
		display: block;
	}
	.head-ad
	{
		width: 1200px;
		margin:auto;
		height: 80px;
	}
	.head-ad h1
	{
		display: inline-block;
		font-size: 30px;
		color: #0F970B;
		width: 150px;
	}
	.head-ad h2
	{
		background: url(http://img03.taobaocdn.com/tps/i3/T1rasSXk4dXXcufgfr-5-5.jpg) no-repeat 0 50%;
		font-size: 22px;
		padding-left: 20px;
		display: inline-block;
		height: 80px;
		line-height: 80px;
		color: #777;
	}
	.content
	{
		width: 1200px;
		margin: 5px auto;
	}
	#registerForm
	{
		width: 600px;
		font-family: 微软雅黑 serif;
		font-size: 16px;
		margin: auto;
	}
	#registerForm div
	{
		margin: 15px;
		height: 32px;
	}
	#registerForm div span,p
	{
		color: #D90B12;
	}
	#registerForm label
	{
		display: inline-block;
		width: 100px;
		text-align: right;
		color:#666;
		margin-right: 15px;
	}
	#registerForm input
	{
		width: 200px;
		height: 26px;
	}
	#registerForm .check_code
	{
		display: inline-block;
		vertical-align: middle;
		width: 90px;
		height: 20px;
		margin: 0px;
	}
	.check_code img:hover
	{
		cursor: pointer;
	}
	.btn
	{
		display: inline-block;
		border: none;
		width: 130px;
		height: 35px;
		font-size: 16px;
		color: #fff; 
		text-align: center;
		background: #21A31E;
	}
	.btn-block
	{
		margin-top: 10px;
		padding-left: 118px;
	}
	</style>
</head>
<body>
	<div class="head">
			<div class="top">
				<div class="lg">
					<ul>
						<li><a id="user" href="#">Line</a></li>
						<li><a id="login" href="#">登陆</a></li>
						<li><a id="regist" href="#">注册</a></li>
					</ul>
				</div>
			</div>
			<div class="head-ad">
				<h1>Line 商城</h1>
				<h2>用户注册</h2>
			</div>
	</div>
	<div class="content">
		<div>
			<form id="registerForm" action="/NetMall/user/save" method="POST">
				<p>${errorMsg}</p>
				<div>
					<label for="account">账号:</label>
					<input type="text" name="account" id="account" placeholder="该用户名作为日后登陆">
					<span>*</span><span id="msg-name"></span>
				</div>
				<div>
					<label for="password">登陆密码:</label>
					<input type="password" name="password" id="password" placeholder="由6位字母和数字组成">
					<span>*</span><span id="msg-psw"></span>
				</div>
				<div>
					<label for="password-repeat">密码确认:</label>
					<input type="password" name="passwordRepeat" id="password-repeat"/>
					<span id="msg-psw-repeat"></span>
				</div>
				<div>
					<label for="checkCode">验证码:</label>
					<input type="text" name="checkCode" id="checkCode"/>
					<div class="check_code">
						<img onclick="changeImage(this);" src="http://localhost:9000/NetMall/checkcode" alt="验证码">
					</div>
					<span id="msg-code"></span>
				</div>
				<div class="btn-block">
				<button class="btn btn-primary" type="submit">注册</button>
				</div>
			</form>
		</div>
	</div>
</body>
<script type="text/javascript">
	var patten = /^[1-9a-zA-Z]{6,12}$/;
	(function(){
	document.getElementById("account").onblur = function(){
		if(this.value.length!= 0 && !patten.exec(this.value)){
			document.getElementById("msg-name").innerHTML = "账户只能由6-12个字母或数字组成";
		}else{
			document.getElementById("msg-name").innerHTML = "";
		}
	};
	document.getElementById("password").onblur = function(){
		if(this.value.length!= 0 && !patten.exec(this.value)){
			document.getElementById("msg-psw").innerHTML = "密码只能由6-12个字母或数字组成";
		}else{
			document.getElementById("msg-psw").innerHTML = "";
		}
	};
	document.getElementById("password-repeat").onblur = function(){
		var psw = document.getElementById("password").value;
		if(this.value.length!= 0 && psw != this.value){
			document.getElementById("msg-psw-repeat").innerHTML = "两次输入不一致";
		}else{
			document.getElementById("msg-psw-repeat").innerHTML = "";
		}
	};
	document.getElementById("checkCode").onblur = function(){
		if(this.value.length != 0){
			var xmlhttp = getXMLHTTP();
			xmlhttp.open("GET","http://localhost:9000/NetMall/user/ajax/code?code="+this.value,true);
			xmlhttp.setRequestHeader("Content-Type","application/json");
			xmlhttp.setRequestHeader("Accept","application/json");
			xmlhttp.send();
			xmlhttp.onreadystatechange = function(){
				if(xmlhttp.readyState == 4 && xmlhttp.status == 200){
					console.log(xmlhttp.responseText);
					var flag = JSON.parse(xmlhttp.responseText);
					console.log(flag.flage == true);
					if(flag.flage == false){
						document.getElementById("msg-code").innerHTML = "验证码错误";
					}else{
						document.getElementById("msg-code").innerHTML = "";
					}
				}
			};
		}
	};
	})();	

	function getXMLHTTP(){
		var xmlhttp ;
		if(window.XMLHttpRequest){
			xmlhttp = new window.XMLHttpRequest();
		}else{
			xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
		}
		return xmlhttp;
	}
	function changeImage(image){
		var src = "http://localhost:9000/NetMall/checkcode";
		var timestamp = (new Date()).valueOf();
		src += "?tamp=" + timestamp;
		image.setAttribute("src",src);
	}
</script>
</html>