<%@page import="java.math.BigInteger"%>
<%@page import="java.security.SecureRandom"%>
<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String message = (String) request.getAttribute("message");
	if(message != null && message.equals("retry")){
		out.print("<script>alert('아이디 또는 비밀번호가 일치하지 않습니다')</script>");
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width"/>
<meta name="google-signin-client_id" content="884451928834-qqlq8ck53ft5q6at5am0anhmkg43jq3b.apps.googleusercontent.com"> <!-- 구글 api사용 -->
<title>The Fun_더 아름다운 세상을 위한 펀딩 로그인</title>
<script src="CSS/mainVendor/jquery/jquery.min.js"></script>
<script src="https://apis.google.com/js/platform.js" async defer></script><!-- 구글 아이디로 로그인 -->
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script> <!-- 카카오로그인  -->
<!-- <script src="js/naveridlogin_js_sdk_2.0.0.js" charset="utf-8"></script> --><!-- 네이버 아이디로 로그인 -->
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script> <!-- 주소검색 -->
<!-- <script src="js/postcode/postcode.v2.js"></script>
<script src="js/postcode/180928.js"></script> -->
<link href="CSS/logincss/login.css" rel="stylesheet"> <!-- 로그인폼 css -->
<style type="text/css">

.form .register-form {
  display: none;
}
</style>
</head>
<body>

<div>
<div class="form">
	<img src="image/main/banner.jpg" width="100%"><br>	
	<!-- 회원가입 폼 -->
	<form action="regiAf.do" class="register-form" method="post">
		<h6 class="background"><span>필수 항목</span></h6>
		<span id="idcheckMessage" style="color:red; font-size:11px;"></span> 
		<input type="text" name="id" id="newId" placeholder="아이디" maxlength="12" onblur="idCheck()" />
		<span id="nicknameCheckMessage" style="color:red; font-size:11px;"></span> 
		<input type="text" id="newNickname" name="nickname" placeholder="이름" onkeyup="nicknameCheck()" maxlength="15"/> 
		<span id="pwdCheckMessage" style="color:red; font-size:11px;"></span> 
		<input type="password" id="newPwd" name="pwd" maxlength="12" placeholder="비밀번호" onkeyup="pwdCheck()" />
		<input type="password" id="newPwdCheck" maxlength="12" placeholder="비밀번호 확인" onkeyup="pwdCheck()" />
		<span id="emailCheckMessage" style="color:red; font-size:11px;"></span> 
		<input type="text" id="newEmail" name="email" placeholder="이메일 주소" maxlength="15" onkeyup="emailCheck()"  />
		
		<h6 class="background" style="cursor: pointer;" onclick="$('#option').slideToggle()"><span>선택 항목</span></h6>
		<div id="option">		
			<span id="phoneCheckMessage" style="color:red; font-size:11px;"></span> 
			<input type="text" id="newPhone" name="phone" placeholder="전화번호" maxlength="13" onkeyup="phoneCheck()">
			<input type="button" onclick="sample4_execDaumPostcode()" style="background: #8152f0; cursor: pointer; color: white" value="우편번호 찾기">
			<input type="text" id="postcode" name="postcode" placeholder="우편번호" readonly="readonly">
			<input type="text" id="roadAddress" name="roadaddress" placeholder="도로명주소" readonly="readonly">
			<input type="text" id="detailAddress" name="detailaddress" maxlength="30" onkeyup="detailAddressCheck()" placeholder="상세주소">
			
			<span id="infoCheckMessage" style="color:red; font-size:11px;"></span>		
			<input type="text" id="newInfo" name="info" maxlength="30" onkeyup="infoCheck()" placeholder="소개글"/>
		</div>		
		<button id="regiBtn" disabled="disabled" style="background: #E2E2E2; cursor: default;">회원가입</button>
		<!-- <h6 class="background"><span>또는</span></h6> -->

		<p class="message">
			이미 계정이 있으신가요? <a href="#" style="color:#8152f0">로그인</a>
		</p>
	</form>
	<!-- 로그인 폼 -->
	<form class="login-form" action="loginAf.do" method="post">
		<input type="hidden" name="loginType" value="normal">
		<input type="text" id="loginId" name="id" onkeyup="loginCheck()" maxlength="12" placeholder="아이디" />
		<!-- <span><input type="checkbox" >아이디 저장</span> -->
		<input type="password" id="loginPwd" name="pwd" onkeyup="loginCheck()" maxlength="12" placeholder="비밀번호" />
		<button style="background: #E2E2E2; cursor: default;" id="loginBtn" disabled="disabled">로그인</button>
		<h6 class="background"><span>또는</span></h6>
		<div style="margin: auto">
			
			<!-- 카카오 아이디로 로그인 -->
			<a id="custom-login-btn" href="javascript:loginWithKakao()" style="text-decoration: none;"> 
				<img src="image/login/kakao_account_login_btn_medium_wide.png"
				onmouseover="this.src='image/login/kakao_account_login_btn_medium_wide_ov.png'"
				onmouseleave="this.src='image/login/kakao_account_login_btn_medium_wide.png'"/><!-- width="217.31px" -->
			</a>
			<!-- 네이버 아이디로 로그인 -->
			<!-- <div id="naverIdLogin"></div> -->
			<!-- 페이스북아이디로로그인 -->
			<div class="fb-login-button" data-width="300" data-max-rows="1" data-size="large" data-button-type="login_with" data-show-faces="false" data-auto-logout-link="false" data-use-continue-as="false"></div>
			<!-- 구글 아이디로 로그인 -->
			<div class="g-signin2" data-width="300" data-height="49" data-longtitle="true" data-onsuccess="onSignIn" style="margin-top: 5px"></div> 
			
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
document.addEventListener("DOMContentLoaded", function(){
	$("#option").hide();	
});
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
						//console.log(authObj.access_token);//<---- 콘솔 로그에 토큰값 출력
						willYouSignUp(id,nickname,email);	
						
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
	/* var naverLogin = new naver.LoginWithNaverId(
		{
			clientId: "vb6UHNxUFoBsi487fDmI",
			//callbackUrl: "http://localhost:8090/TheFun/naverLogin.do",
			callbackUrl: "https://localhost:8443/TheFun/login.do",
			//isPopup: false, // 팝업을 통한 연동처리 여부 
			//callbackHandle: true,
			loginButton: {color: "green", type: 3, height: 47} // 로그인 버튼의 타입을 지정
		}
	);
	//설정정보를 초기화하고 연동을 준비 
	naverLogin.init();
	// (5) 현재 로그인 상태를 확인 
	window.addEventListener('load', function () {
	
	naverLogin.getLoginStatus(function (status) {
		if (status) {
			var email = naverLogin.user.getEmail();
			var nickname = naverLogin.user.getNickName();
			var profileImage = naverLogin.user.getProfileImage();						
			var id = naverLogin.user.getId();	
			willYouSignUp(id,nickname,email);	
		}
		});
	}); */
function willYouSignUp(id,nickname,email){
	/* $.noConflict(); */
	$.ajax({
		type:"get",
		url:"idCheck.do",
		data:"id=" + id,
		
		success:function(data){						
			if(data.trim() != "OK"){ // 등록되어 있으면 바로 로그인 시킴
				window.location.replace("loginAf.do?id=" + id +"&loginType=externalAccount");
				//location.href="loginAf.do?id=" + id +"&loginType=externalAccount";
			}else{ // 등록되어 있지 않으면 바로 회원가입 시킴							
				if (confirm("등록되지 않은 계정입니다.  회원가입 하시겠습니까?")) {
					//window.location.replace("regiAf.do?id=" + id +"&nickname=" + nickname +"&email="+email);
					location.href="regiAf.do?id=" + id +"&nickname=" + nickname +"&email="+email;
				}
			}
		}
	});	
}
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

	willYouSignUp(id,nickname,email);	
}
</script>

<!-- 페이스북아이디로 로그인  -->

<script>
  window.fbAsyncInit = function() {
    FB.init({
      appId      : '{2123794117640622}',
      cookie     : true,
      xfbml      : true,
      version    : '{3.2}'
    });
      
    FB.AppEvents.logPageView();   
    
    FB.getLoginStatus(function(response) {
        statusChangeCallback(response);
        console.log("abc")
    });
      
  };
  /*  페이스북 아이디로 로그인 */ 
  (function(d, s, id) {
    var js, fjs = d.getElementsByTagName(s)[0];
    if (d.getElementById(id)) return;
    js = d.createElement(s); js.id = id;
    js.src = 'https://connect.facebook.net/ko_KR/sdk.js#xfbml=1&version=v3.2&appId=2123794117640622&autoLogAppEvents=1';
    fjs.parentNode.insertBefore(js, fjs);
  }(document, 'script', 'facebook-jssdk'));

  
</script>


<script type="text/javascript">
/* 회원가입 유효성 검사 */
var idOk = false;
var pwdOk = false;
var emailOk = false;
var nicknameOk = false;
var infoOk = true;
var phoneOk = true;

function checkSubmitActivation(){
	if(idOk && pwdOk && emailOk && nicknameOk && infoOk && phoneOk){
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
	//console.log("nicknameCheck");
	var regExp = /[\{\}\[\]\/?.,;:|\)*~`!^\-_+<>@\#$%&\\\=\(\'\"]/gi;
	if(regExp.test($("#newNickname").val()) || $("#newNickname").val().length < 2 ){	    
		$("#nicknameCheckMessage").text("한글 또는 영어로만 2~15자 이내로 적어주세요");
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
	var regExp = /[\{\}\[\]\/?.,;:|\)*~`!^\-_+<>@\#$%&\\\=\(\'\"]/gi;
	if(regExp.test($("#newInfo").val()) && $("#newInfo").val().length != 0){	    
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
/* 상세 주소 */
function detailAddressCheck() {
	console.log("detailAddressCheck");
	var text = $("#detailAddress").val();
	//var regExp = /[\{\}\[\]\/?.,;:|\)*~`!^\-_+<>@\#$%&\\\=\(\'\"]/gi;
	text = text.replace(/[<(+>]/g, '');
	//console.log(text);
	$("#detailAddress").val(text);	
}
function phoneCheck(){
	//colsole.log()
	var text = $("#newPhone").val();
	var regExp = /^\d{3}-\d{3,4}-\d{4}$/;
	//text = text.replace(/[^0-9]/g, '');
	//$("#newPhone").val(text);
	if (!text.match(regExp) && $("#newPhone").val().length != 0) {
		$("#phoneCheckMessage").text("전화번호 형식:XXX-XXXX-XXXX");
		phoneOk = false;
		checkSubmitActivation();
	}else{
		$("#phoneCheckMessage").text("");
		phoneOk = true;
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
	//detailAddressCheck();
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
/* 주소검색 */
function sample4_execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
            var extraRoadAddr = ''; // 도로명 조합형 주소 변수

            // 법정동명이 있을 경우 추가한다. (법정리는 제외)
            // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
            if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                extraRoadAddr += data.bname;
            }
            // 건물명이 있고, 공동주택일 경우 추가한다.
            if(data.buildingName !== '' && data.apartment === 'Y'){
               extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
            }
            // 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
            if(extraRoadAddr !== ''){
                extraRoadAddr = ' (' + extraRoadAddr + ')';
            }
            // 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
            if(fullRoadAddr !== ''){
                fullRoadAddr += extraRoadAddr;
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('postcode').value = data.zonecode; //5자리 새우편번호 사용
            document.getElementById('roadAddress').value = fullRoadAddr;
           
        }
    }).open();
}
</script>

</body>
</html>