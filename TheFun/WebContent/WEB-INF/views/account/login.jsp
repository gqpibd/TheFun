<%@page import="java.math.BigInteger"%>
<%@page import="java.security.SecureRandom"%>
<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String message = (String) request.getAttribute("message");
	if(message != null){
		if(message.equals("registered")){
			out.print("<script>alert('회원가입이 완료되었습니다. 로그인해 주십시오')</script>");
		}
	}
%>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script> <!-- 주소검색 -->

<!-- 로그인폼 css -->
<link href="CSS/logincss/login.css" rel="stylesheet">

<style type="text/css">
.g-signin2>div{
	max-width: 100%;
}
div#naverIdLogin>a>img {
    width: 100%;
    height: 100%;
}
</style> 
<!-- 아이디 쿠키 저장 jquery코드 -->
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.cookie.js"></script>


<script type="text/javascript">
function optionToggle(){
	$('#option').slideToggle();
	$( ".fas" ).toggleClass( "fa-angle-down" );
	$( ".fas" ).toggleClass( "fa-angle-up" );	
}
/* 페이스북 로그인에 필요한 스크립트 */
function checkLoginState(){
	FB.getLoginStatus(function(response) {
		statusChangeCallback(response);
	});
}

function statusChangeCallback(response) {
	if (response.status === 'connected') {
		var uid = response.authResponse.userID;
	    var accessToken = response.authResponse.accessToken;
		// Logged into your app and Facebook.
		FB.api('/me',{fields: 'name,email,picture'}, function(res) {
	      console.log('Successful login for: ' + res.name);		      
	      console.log('response.authResponse.userID: ' + res.id);		      
	      console.log('response.email: ' + res.email);			
	      //console.log('response.public_profile: ' + res.picture.data.url);
	      profile = "http://graph.facebook.com/" + res.id + "/picture";
	      willYouSignUp(res.id,res.name,res.email,profile,"facebook");	
	    });
	} else {
		console.log("페이스북 로그인 되어있지 않음")
	}
}

//id쿠키저장
$(document).ready(function(){
	var user_id = $.cookie("user_id");
	
	if(user_id != null){ // 저장된 쿠키가 있는 경우 셋팅
		$("#loginId").val(user_id);
		$("#_chk_save_id").attr("checked", "checked");
	}
	//$("#_chk_save_id").change(function() {
	$('input:checkbox[id="_chk_save_id"]').change(function(){		
		saveId();
	}); 
})
function saveId(){ // 아이디를 쿠키에 저장하거나 삭제하는 함수	--> 함수로 만들어서 로그인 버튼을 누를 때도 호출되도록 사용
	if($('input:checkbox[id="_chk_save_id"]').is(":checked")){
		$.cookie("user_id", $("#loginId").val(), { expires: 7, path: '/' });
	}else{
		$.removeCookie("user_id", { path:'/' });
	}
}
</script>

<div>
<div class="form" style="margin-top:30px">
	<a href="main.do"><img src="image/main/banner.jpg" width="100%"><br></a>
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
		<input type="text" id="newEmail" name="email" placeholder="이메일 주소" maxlength="30" onkeyup="emailCheck()"  />
		
		<h6 class="background" style="cursor: pointer;" onclick="optionToggle()"><span>선택 항목<i id="updown" class="fas fa-angle-down"></i></span></h6>
		<div id="option">		
			<span id="phoneCheckMessage" style="color:red; font-size:11px;"></span> 
			<input type="text" id="newPhone" name="phone" placeholder="전화번호" maxlength="13" onkeyup="autoHyphen(this)">
			<input type="button" onclick="sample4_execDaumPostcode()" style="background: #8152f0; cursor: pointer; color: white" value="우편번호 찾기">
			<input type="text" id="postcode" name="postcode" placeholder="우편번호" readonly="readonly">
			<input type="text" id="roadAddress" name="roadaddress" placeholder="도로명주소" readonly="readonly">
			<input type="text" id="detailAddress" name="detailaddress" maxlength="30" onkeyup="detailAddressCheck()" placeholder="상세주소">
			
			<span id="infoCheckMessage" style="color:red; font-size:11px;"></span>		
			<textarea class="input" id="newInfo" name="info" maxlength="200" onkeyup="infoCheck()" placeholder="소개글"/></textarea>
		</div>		
		<button id="regiBtn" disabled="disabled" style="background: #E2E2E2; cursor: default;">회원가입</button>
		<!-- <h6 class="background"><span>또는</span></h6> -->

		<p class="message">
			이미 계정이 있으신가요? <a href="#" style="color:#8152f0">로그인</a>
		</p>
	</form>
	
	<!-- 로그인 폼 -->
	<form class="login-form" action="loginAf.do" id="loginForm" method="post">
		<input type="hidden" name="callback" value="${callback}">
		<input type="hidden" name="loginType" value="normal">		
		
		<input type="text" id="loginId" name="id" onkeyup="loginCheck()" maxlength="12" placeholder="아이디" value="" />
		
		<input type="password" id="loginPwd" name="pwd" onkeyup="loginCheck()" maxlength="12" placeholder="비밀번호" />
		<!-- 아이디 쿠키 저장 -->
		<div align="left">
		<span title="아이디저장" style="font-size: small; color: #747474;">
			<input type="checkbox" id="_chk_save_id" style="width: 5%">아이디 저장하기
		</span>
		</div>
		<button type="button" style="background: #E2E2E2; cursor: default;" id="loginBtn" disabled="disabled">로그인</button>
		<h6 class="background"><span>또는</span></h6>
		<div style="margin: auto;">
			<!-- 네이버 아이디로 로그인 -->
			<div class="mb-1"id="naverIdLogin"></div>
			<!-- 카카오 아이디로 로그인 -->
			<a id="custom-login-btn" href="javascript:loginWithKakao()" style="text-decoration: none;" > 
				<img class="mb-1" src="image/login/kakao_account_login_btn_medium_wide.png"
				onmouseover="this.src='image/login/kakao_account_login_btn_medium_wide_ov.png'"
				onmouseleave="this.src='image/login/kakao_account_login_btn_medium_wide.png'" style="max-width: 100%"/><!-- width="217.31px" -->
			</a>		
			
			<!-- 구글 아이디로 로그인 -->
			<div class="g-signin2 mb-1" data-width="300" data-height="49" data-longtitle="true" data-onsuccess="onSignIn"></div> 
			
			<!-- 페이스북아이디로로그인 --> 
			<!-- <div id="fbbtn" style="visibility: none;"class="fb-login-button" onlogin="checkLoginState();" data-width="300" data-max-rows="1" data-size="large" data-button-type="continue_with" data-show-faces="false" data-auto-logout-link="false" data-use-continue-as="false"></div> -->			
			<div id="fbbtn" style="visibility: none;"class="fb-login-button" onlogin="checkLoginState();" data-width="300" data-max-rows="1" data-size="large" data-button-type="continue_with" data-show-faces="false" data-auto-logout-link="false" data-use-continue-as="true"></div>
			<!-- <fb:login-button scope="public_profile,email" onlogin="checkLoginState();" data-width="100%" data-max-rows="1" data-size="large" data-button-type="login_with" data-show-faces="true" data-auto-logout-link="true" data-use-continue-as="true">페이스북 계정으로 로그인
			</fb:login-button> -->
			
		</div>
		<div>
			<p class="message">
				아직도 더펀 계정이 없으신가요? <a href="#" style="color: #8152f0">회원가입</a>
			</p>
			<p class="message">
				계정을 잊어버리셨나요? <a href="find_id_from.do" style="color: #8152f0">아이디/비밀번호 찾기</a>
			</p>
		</div>
	</form>
</div>
</div>


<script type="text/javascript">
/* 로그인 처리 */
$("#loginBtn").click(function(){
	saveId(); // 아이디 저장 체크박스를 확인하고 아이디 저장 처리
	tryLogin();
});
function tryLogin(){
	var formData = $("#loginForm").serialize(); /* 이렇게 하면 폼 데이터를 ajax로 보낼 수 있다@@ */
	$.ajax({
		type : "post",
		url : "loginAf.do",
		cache : false,
		data : formData,
		async:true, // 비동기
		dataType:'json',
		success:function(data){	
			if(data.message!=null && data.message=='retry'){
				alert("아이디 또는 비밀번호가 틀렸습니다. 다시 시도해 주세요");
				$("input[name='callback']").val(data.callback);
			}else{
				//console.log(data.callback);
				location.href=data.callback;
			}
		},
		error:function(req, stu, err){
			alert("통신실패");
		}
	});
}
	  
/* 회원가입 */
document.addEventListener("DOMContentLoaded", function(){
	$("#option").hide();	
});
$('.message a').click(function(){
   $('form').animate({height: "toggle", opacity: "toggle"}, "slow");
});
</script>
<!-- 카카오 아이디로 로그인 -->
<script type='text/javascript'>	 
    // topbar에서 이미 init함..
    Kakao.init('062de807a7680278db82ca44cf5eed29'); //도현
    //Kakao.init('e53f47e84dfa687f87346382fb232397'); //다슬
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
						var profile = res.properties.profile_image; 
						//console.log(authObj.access_token);//<---- 콘솔 로그에 토큰값 출력
						console.log("res.properties.profile_image : " + profile);//<---- 콘솔 로그에 토큰값 출력
						console.log("res.properties.nickname : " + res.properties.nickname);//<---- 콘솔 로그에 토큰값 출력
						console.log("res.properties.thumbnail_image : " + res.properties.thumbnail_image);//<---- 콘솔 로그에 토큰값 출력
						willYouSignUp(id,nickname,email,profile,"kakao");	
						
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
			callbackUrl: "http://ziharndwjs.dlinkddns.com/TheFun/login.do",
			//callbackUrl: "https://localhost:8443/TheFun/login.do",
			//isPopup: false, // 팝업을 통한 연동처리 여부 
			//callbackHandle: true,
			loginButton: {color: "green", type: 3, height: 50} // 로그인 버튼의 타입을 지정
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
			willYouSignUp(id,nickname,email,profileImage,"naver");	
		}
		});
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
    //auth2.disconnect(); 
    
	var profile = googleUser.getBasicProfile();
	//var id =  googleUser.getAuthResponse().id_token;
	var id = profile.getId();
	var nickname = profile.getName();
	console.log('Image URL: ' + profile.getImageUrl());
	var email = profile.getEmail();
	console.log("id:"+profile.getId());

	willYouSignUp(id,nickname,email,profile.getImageUrl(),"google");	
}
</script>

<!-- 회원가입 할래? -->
<script type="text/javascript">
function willYouSignUp(id,nickname,email,profile,account){
	var callback = $("input[name='callback']").val();
	//profile
	$.ajax({
		type:"get",
		url:"idCheck.do",
		data:"id=" + id,
		
		success:function(data){						
			if(data.trim() != "OK"){ // 등록되어 있으면 바로 로그인 시킴
				location.href="simpleLogin.do?id=" + id +"&loginType=" + account +"&callback=" + callback;				
			}else{ // 등록되어 있지 않으면 바로 회원가입 시킴
				modalConfirm(function(confirm){
					if(confirm){
						location.href="regiAf.do?id=" + id +"&nickname=" + nickname +"&email="+email+"&profile="+profile +"&account="+account +"&callback=" + callback;
						//console.log("yes");
					}
				});		
			}
		}
	});	
}
/* confirm창 콜백 처리 */
var modalConfirm = function(callback) {
	$("#confirmModal").modal('show');
	$("#join").on("click", function() {
		callback(true);
		$("#confirmModal").modal('hide');
	});

	$("#cancel").on("click", function() {
		callback(false);
		$("#confirmModal").modal('hide');
	});
};
</script>	
<!-- 회원가입 Modal -->
<div class="modal fade" id="confirmModal" tabindex="-1" role="dialog" aria-labelledby="confirmModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="confirmModalLabel">간편 회원가입</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
       	등록되지 않은 계정입니다.  회원가입 하시겠습니까?
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal" id="cancel">취소</button>
        <button type="button" class="btn btn-primary" id="join">회원가입</button>
      </div>
    </div>
  </div>
</div>

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

function infoCheck() { // 200글자 이내
	var regExp = /[\{\}\[\]\/.,;:|\)*~`\-_+<>@\#$%&\\\=\(\'\"]/gi;
	if(regExp.test($("#newInfo").val()) && $("#newInfo").val().length != 0){	    
		$("#infoCheckMessage").text("한글 또는 영어로만 200자 이내로 적어주세요");
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

//휴대폰 번호 자동 하이픈(-)
function autoHypenPhone(str){ 
	  str = str.replace(/[^0-9]/g, '');
	  var tmp = '';
	  if( str.length < 4){
	    return str;
	  }else if(str.length < 7){
	    tmp += str.substr(0, 3);
	    tmp += '-';
	    tmp += str.substr(3);
	    return tmp;
	  }else if(str.length < 11){
	    tmp += str.substr(0, 3);
	    tmp += '-';
	    tmp += str.substr(3, 3);
	    tmp += '-';
	    tmp += str.substr(6);
	    return tmp;
	  }else{        
	    tmp += str.substr(0, 3);
	    tmp += '-';
	    tmp += str.substr(3, 4);
	    tmp += '-';
	    tmp += str.substr(7);
	    return tmp;
	  }
	  return str;
	}
	
function autoHyphen(phoneField){
	var _val = $(phoneField).val().trim();
	$(phoneField).val(autoHypenPhone(_val)) ;
}

//엔터키로 로그인
var inputId = document.getElementById("loginId");
var inputPwd = document.getElementById("loginPwd");
inputId.addEventListener("keyup", function(event) {
  event.preventDefault();
  if (event.keyCode === 13) {
    document.getElementById("loginBtn").click();
  }
});
inputPwd.addEventListener("keyup", function(event) {
  event.preventDefault();
  if (event.keyCode === 13) {
    document.getElementById("loginBtn").click();
  }
});



</script>