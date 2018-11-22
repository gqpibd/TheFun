<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width"/>
<meta name="google-signin-client_id" content="884451928834-qqlq8ck53ft5q6at5am0anhmkg43jq3b.apps.googleusercontent.com"> <!-- 구글 api사용 -->
<title>The Fun_더 아름다운 세상을 위한 펀딩 로그인</title>
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script> <!-- 카카오로그인  -->
<script type="text/javascript" src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.0.js" charset="utf-8"></script><!-- 네이버 아이디로 로그인 -->
<script src="https://apis.google.com/js/platform.js" async defer></script> <!-- 구글 아이디로 로그인 -->
<script src="https://apis.google.com/js/platform.js?onload=renderButton" async defer></script> <!-- 구글 로그인 커스텀 버튼 -->
<script src="https://apis.google.com/js/platform.js?onload=init" async defer></script>
<script src="CSS/mainVendor/jquery/jquery.min.js"></script>

<style type="text/css">
/* Form */
.form {
  position: relative;
  z-index: 1;
  background: #FFFFFF;
  max-width: 300px;
  margin: 0 auto 100px;
  padding: 30px;
  border-top-left-radius: 3px;
  border-top-right-radius: 3px;
  border-bottom-left-radius: 3px;
  border-bottom-right-radius: 3px;
  text-align: center;
}
.form input {
  outline: 0;
  background: #f2f2f2;
  width: 100%;
  border: 0;
  margin: 0 0 15px;
  padding: 15px;
  border-top-left-radius: 3px;
  border-top-right-radius: 3px;
  border-bottom-left-radius: 3px;
  border-bottom-right-radius: 3px;
  box-sizing: border-box;
  font-size: 14px;
}
.form button {
  outline: 0;
  background: #8152f0;
  width: 100%;
  border: 0;
  padding: 15px;
  border-top-left-radius: 3px;
  border-top-right-radius: 3px;
  border-bottom-left-radius: 3px;
  border-bottom-right-radius: 3px;
  color: #FFFFFF;
  font-size: 14px;
  transition: all 0.3 ease;
  cursor: pointer;
}
.form .message {
  margin: 15px 0 0;
  color: #b3b3b3;
  font-size: 12px;
}
.form .message a {
  color: #EF3B3A;
  text-decoration: none;
}
.form .register-form {
  display: none;
}
body {
  background: #ccc;
  font-family: "Roboto", sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}
body:before {
  content: "";
  position: fixed;
  top: 0;
  left: 0;
  display: block;
  background: rgba(255, 255, 255, 0.8);
  width: 100%;
  height: 100%;
} 

h6.background {
  font: 26px;
  margin-top: 10px;
  text-align: center;
  position: relative;
  z-index: 1;
}
h6.background:before {
  border-top: 2px solid #dfdfdf;
  content: "";
  margin: 0 auto;
  /* this centers the line to the full width specified */
  position: absolute;
  /* positioning must be absolute here, and relative positioning must be applied to the parent */
  top: 50%;
  left: 0;
  right: 0;
  bottom: 0;
  width: 95%;
  z-index: -1;
}
h6.background span {
  /* to hide the lines from behind the text, you have to set the background color the same as the container */
  background: #fff;
  padding: 0 15px;
}​
</style>

</head>
<body>

<div>
<div class="form">
	<img src="image/main/banner.jpg" width="100%"><br>	
	<!-- 회원가입 폼 -->
	<form action="regiAf.do" class="register-form" method="post">
		<span id="idcheckMessage" style="color:red; font-size:11px;"></span> 
		<input type="text" name="id" id="newId" placeholder="아이디" maxlength="12" onblur="idCheck()" />
		<span id="nicknameCheckMessage" style="color:red; font-size:11px;"></span> 
		<input type="text" id="newNickname" name="nickname" placeholder="이름" onblur="nicknameCheck()" maxlength="15"/> 
		<span id="pwdCheckMessage" style="color:red; font-size:11px;"></span> 
		<input type="password" id="newPwd" name="pwd" maxlength="12" placeholder="비밀번호" onkeyup="pwdCheck()" />
		<input type="password" id="newPwdCheck" maxlength="12" placeholder="비밀번호 확인" onkeyup="pwdCheck()" />
		<span id="emailCheckMessage" style="color:red; font-size:11px;"></span> 
		<input type="text" id="newEmail" name="email" placeholder="이메일 주소" maxlength="15" onblur="emailCheck()"  />
		<span id="infoCheckMessage" style="color:red; font-size:11px;"></span> 
		<input type="text" id="newInfo" name="info" maxlength="30" onblur="infoCheck()" placeholder="소개글"/>
		<button id="regiBtn" disabled="disabled" style="background: #E2E2E2; cursor: default;">회원가입</button>
		<h6 class="background"><span>또는</span></h6>

		<p class="message">
			이미 계정이 있으신가요? <a href="#" style="color:#8152f0">로그인</a>
		</p>
	</form>
	
	<!-- 로그인 폼 -->
	<form class="login-form" action="login.do" method="post">
		<input type="hidden" name="loginType" value="normal">
		<input type="text" id="loginId" name="id" onkeyup="loginCheck(this)" maxlength="12" placeholder="아이디" />
		<!-- <span><input type="checkbox" >아이디 저장</span> -->
		<input type="password" id="loginPwd" name="pwd" onkeyup="loginCheck(this)" maxlength="12" placeholder="비밀번호" />
		<button style="background: #E2E2E2; cursor: default;" id="loginBtn" disabled="disabled">로그인</button>
		<h6 class="background"><span>또는</span></h6>
		<div style="margin: auto">
			<div class="g-signin2" data-width="300" data-height="49" data-longtitle="true" data-onsuccess="onSignIn"></div> <!-- 구글 아이디로 로그인 -->
			<br>
			<a id="custom-login-btn" href="javascript:loginWithKakao()" style="text-decoration: none;"> <!-- 카카오 아이디로 로그인 -->
				<img src="image/login/kakao_account_login_btn_medium_narrow.png"
				onmouseover="this.src='image/login/kakao_account_login_btn_medium_narrow_ov.png'"
				onmouseleave="this.src='image/login/kakao_account_login_btn_medium_narrow.png'"/><!-- width="217.31px" -->
			</a>			
			<div id="naverIdLogin"></div> <!-- 네이버 아이디로 로그인 -->
		</div>
		<div>
			<p class="message">
				아직도 더펀 계정이 없으신가요? <a href="#" style="color: #8152f0">회원가입</a>
			</p>
		</div>
	</form>
</div>
</div>
<!-- 회원가입 -->
<script type="text/javascript">
$('.message a').click(function(){
   $('form').animate({height: "toggle", opacity: "toggle"}, "slow");
});
</script>
<!-- 카카오 아이디로 로그인 -->
<script type='text/javascript'>	 
    // 사용할 앱의 JavaScript 키를 설정해 주세요.
    Kakao.init('dd0c44a9e5b9f94ce480a440c3113d2d');
    // 카카오 로그인 버튼을 생성합니다.
	  
	function loginWithKakao() {
		// 로그인 창을 띄웁니다.
		Kakao.Auth.login({
			success : function(authObj) {
				Kakao.API.request({
					url : '/v1/user/me',
					success : function(res) {
						var id = res.id;
						var email = res.kaccount_email;
						var nickname = res.properties['nickname']; // res.properties.nickname으로도 접근 가능  
						//location.href="loginAf.do?id=" + res.id +"&nickname=" + res.properties['nickname']"&nickname=" + ;
						
						//console.log(authObj.access_token);//<---- 콘솔 로그에 토큰값 출력
						$.ajax({
							type:"get",
							url:"idCheck.do",
							data:"id=" + id,
							
							success:function(data){						
								if(data.trim() != "OK"){ // 등록되어 있으면 바로 로그인 시킴		
									location.href="loginAf.do?id=" + id +"&loginType=externalAccount";
								}else{ // 등록되어 있지 않으면 바로 회원가입 시킴	
									//alert("등록되지 않은 계정입니다. 회원가입해 주세요.");
									//location.href="regiAf.do?id=" + id +"&nickname=" + nickname +"&email="+email;
									location.href="regiAf.do?id=" + id +"&nickname=" + nickname;
								}
							}
						});	
						
					}
				})
			},
			fail : function(err) {
				alert(JSON.stringify(err));
			}
		});
	};
</script>
<!-- 네이버아디디로로그인 Script -->
<script type="text/javascript">
	var naverLogin = new naver.LoginWithNaverId(
		{
			clientId: "vb6UHNxUFoBsi487fDmI",
			callbackUrl: "http://localhost:8090/TheFun/login.do",
			isPopup: false, /* 팝업을 통한 연동처리 여부 */
			callbackHandle: false,
			loginButton: {color: "green", type: 3, height: 47} /* 로그인 버튼의 타입을 지정 */
		}
	);
	
	/* 설정정보를 초기화하고 연동을 준비 */
	naverLogin.init();
	naverLogin.logout(); // 자동 로그인 방지
	
	naverLogin.getLoginStatus(function (status) {
		if (status) {
			var email = naverLogin.user.getEmail();
			var nickname = naverLogin.user.getNickName();
			var profileImage = naverLogin.user.getProfileImage();						
			var id = naverLogin.user.getId();				
			console.log(email);
			console.log(name);
			console.log(profileImage);				
			console.log(id);
			$.ajax({
				type:"get",
				url:"idCheck.do",
				data:"id=" + id,
				
				success:function(data){						
					if(data.trim() != "OK"){ // 등록되어 있으면 바로 로그인 시킴		
						location.href="loginAf.do?id=" + id +"&loginType=externalAccount";
					}else{ // 등록되어 있지 않으면 바로 회원가입 시킴	
						//alert("등록되지 않은 계정입니다. 회원가입해 주세요.");
						location.href="regiAf.do?id=" + id +"&nickname=" + nickname +"&email="+email;
						//location.href="regiAf.do?id=" + id +"&nickname=" + nickname;
					}
				}
			});	
		}  else {
			//console.log("AccessToken이 올바르지 않습니다.");
		} 
	});
</script>

<!-- 구글 아이디로 로그인 -->

<script type="text/javascript">
/* id:884451928834-qqlq8ck53ft5q6at5am0anhmkg43jq3b.apps.googleusercontent.com
secret:fiTxL5KFg9TPiYGEY8QsVWjH */
function onSignIn(googleUser) {
	console.log("onSignIn");
	var id_token = googleUser.getAuthResponse().id_token;
    var auth2 = gapi.auth2.getAuthInstance(); 
    auth2.disconnect(); 
    
	var profile = googleUser.getBasicProfile();
	//var id =  googleUser.getAuthResponse().id_token;
	var id = profile.getId();
	var nickname = profile.getName();
	//console.log('Image URL: ' + profile.getImageUrl());
	var email = profile.getEmail();
	console.log("id:"+profile.getId());
	$.ajax({
		type:"get",
		url:"idCheck.do",
		data:"id=" + id,
		
		success:function(data){						
			if(data.trim() != "OK"){ // 등록되어 있으면 바로 로그인 시킴		
				location.href="loginAf.do?id=" + id +"&loginType=externalAccount";
			}else{ // 등록되어 있지 않으면 바로 회원가입 시킴	
				//alert("등록되지 않은 계정입니다. 회원가입해 주세요.");
				location.href="regiAf.do?id=" + id +"&nickname=" + nickname +"&email="+email;
				//location.href="regiAf.do?id=" + id +"&nickname=" + nickname;
			}
		}
	});	
}
</script>
<script type="text/javascript">
/* 회원가입 유효성 검사 */
var idOk = false;
var pwdOk = false;
var emailOk = false;
var nicknameOk = true;
var infoOk = true;

function checkSubmitActivation(){
	if(idOk && pwdOk && emailOk && nicknameOk && infoOk){
		document.getElementById("regiBtn").disabled = false;
		document.getElementById("regiBtn").style.background = "#8152f0";
		document.getElementById("regiBtn").style.cursor =  "pointer";
	}else{
		document.getElementById("regiBtn").disabled = true;
		document.getElementById("regiBtn").style.background = "#E2E2E2";
		document.getElementById("regiBtn").style.cursor =  "default";
	}
}

function idCheck() {
	var re = /^[a-zA-Z0-9]{3,12}$/ // 아이디가 적합한지 검사할 정규식
	if(!re.test($('#newId').val())) {
		$("#idcheckMessage").text("3~12자의 영문 대소문자와 숫자로만 입력해 주세요");
		$("#newId").val("");
		$("#newId").focus();
		idOk = false;
		checkSubmitActivation();
		return;
    }

	$.ajax({
		type:"get",
		url:"idCheck.do",
		data:"id=" + $('#newId').val(),
		
		success:function(data){						
			if(data.trim() != "OK"){		
				$("#idcheckMessage").text("사용 중인 id입니다.");
				$("#newId").val("");
				$("#newId").focus();
				idOk = false;
				checkSubmitActivation();
			}else{
				$("#idcheckMessage").text("");
				idOk = true;	
				checkSubmitActivation();			
			}
		}
	});	
}

function pwdCheck() {		
	var re = /^[a-zA-Z0-9]{3,12}$/ // 아이디와 패스워드가 적합한지 검사할 정규식
	if(!re.test($('#newPwd').val())) {
		$("#pwdCheckMessage").text("3~12자의 영문 대소문자와 숫자로만 입력해 주세요");
		$("#newPwd").focus();
		pwdOk = false;
		checkSubmitActivation();
    }else if(($("#newPwdCheck").val() !=null ) && ($("#newPwd").val() != $("#newPwdCheck").val())){ // 비밀 번호 다르면
		$("#pwdCheckMessage").text("비밀번호가 일치하지 않습니다.");		
		pwdOk = false;
		checkSubmitActivation();
	}else{
		$("#pwdCheckMessage").text("");		
		pwdOk = true;
		checkSubmitActivation();
	}
}

function nicknameCheck() { // 15글자 이내
	console.log("nicknameCheck");
	var regExp = /[\{\}\[\]\/?.,;:|\)*~`!^\-_+<>@\#$%&\\\=\(\'\"]/gi;
	if(regExp.test($("#newNickname").val())){	    
		$("#nicknameCheckMessage").text("한글 또는 영어로만 15자 이내로 적어주세요");
		$("#newNickname").focus();
		nicknameOk = false;
		checkSubmitActivation();
	}else{
		$("#nicknameCheckMessage").text("");
		nicknameOk = true;
		checkSubmitActivation();
	}
}

function infoCheck() { // 30글자 이내
	console.log("infoCheck");
	var regExp = /[\{\}\[\]\/?.,;:|\)*~`!^\-_+<>@\#$%&\\\=\(\'\"]/gi;
	if(regExp.test($("#newInfo").val())){	    
		$("#infoCheckMessage").text("한글 또는 영어로만 30자 이내로 적어주세요");
		$("#newInfo").focus();
		infoOk = false;
		checkSubmitActivation();
	}else{
		 $("#infoCheckMessage").text("");
	    infoOk = true;
		checkSubmitActivation();
	}
}
function emailCheck() {
	var emailVal = $("#newEmail").val();
	var regExp = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;	
				
	if(emailVal.match(regExp) == null) { // 형식이 올바르지 않은 경우
		$("#emailCheckMessage").text("올바른 이메일을 입력해 주세요");
	    $("#newEmail").focus();
	    emailOk = false;
		checkSubmitActivation();
	    return;
	}

	$.ajax({
		type:"get",
		url:"emailCheck.do",
		data:"email=" + $("#newEmail").val(),	
		success:function(data){			
			if(data != "OK") { // 중복된 이메일
				$("#newEmail").val("");
			    $("#newEmail").focus();  
			    $("#emailCheckMessage").text("이미 사용중인 이메일 입니다");
			    emailOk = false;
				checkSubmitActivation();
			}else{
				 $("#emailCheckMessage").text("");
				 emailOk = true;
				 checkSubmitActivation();
			}
		}
	});
}
/* 로그인 검사 */
function loginCheck() {
	if($("#loginId").val()=="" || $("#loginPwd").val()==""){
		document.getElementById("loginBtn").disabled = true;
		document.getElementById("loginBtn").style.background = "#E2E2E2";		
		document.getElementById("loginBtn").style.cursor =  "default";		
	}else{
		document.getElementById("loginBtn").disabled = false;
		document.getElementById("loginBtn").style.background = "#8152f0";	
		document.getElementById("loginBtn").style.cursor =  "pointer";
	}
}

</script>


</body>
</html>