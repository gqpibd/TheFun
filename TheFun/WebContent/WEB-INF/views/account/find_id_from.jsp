<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="CSS/logincss/login.css" rel="stylesheet"> <!-- 로그인폼 css -->

<style type="text/css">
.form .register-form {
  display: none;
}
</style>

<script type="text/javascript">
$(document).ready(function(){ 
	/* $("#phone").focus(function () {
		$("#phone").attr("placeholder","010-XXXX-XXXX");
	});
	$("#phone").focusout (function () {
		$("#phone").attr("placeholder","");
	});
	$("#email").focus(function () {
		$("#email").attr("placeholder","hello@sagong.com");
	});
	$("#email").focusout (function () {
		$("#email").attr("placeholder","");
	}); */
		
	function checkWidth() { // 윈도우 사이즈가 바뀔 때 보여주는 아이템 변경
		$("[name='large']").toggle($(window).width() >= 900);
		$("[name='small']").toggle($(window).width() < 900);
	}
	checkWidth();
	$(window).resize(checkWidth);
	
	// 아이디 비밀번호 확인
	$("#forpassword").click(function() { 
		console.log("forpassword");
		var email = $("#findIdEmail").val();
		var phone = $("#findIdPhone").val();
		$.ajax({
			url:"find_idpw.do", // 접근대상
			type:"get",		// 데이터 전송 방식
			data:"command=find_idpw&email="+email+"&phone="+phone, 
			success:function(data, status, xhr){
				var id = data.trim();
				console.log(id);
				if(id!=""){ // 일치하는 아이디를 찾은 경우
					var change = confirm("당신의 id는" + id + "입니다. 비밀번호를 변경하시겠습니까?");
					if(change){
						$("#cpw").val(id);
						openChangePwdModal();
					}
					/* location.href='loginAf.do?loginType'; */
				}else{ // 일치하는 아이디가 없는 경우
					alert("일치하는 회원 정보가 없습니다. 다시 확인해 주세요");
				}			
			},
			error:function(){ // 또는					 
				console.log("통신실패!");
			}
		});	
	});
});
function openChangePwdModal(){
	$("#changePassword").modal('show');	
}

</script>

</head>
<body>

<div>
<div class="form">
	<!-- 로고 -->
	<a href="main.do"><img src="image/main/banner.jpg" width="100%"><br></a>
	
	<br><br>
	
	<!-- id찾기 폼 -->
	<!-- <form class="login-form" action="find_idpw.do" method="post" id="find"> -->
		<input type="hidden" name="command" value="find_idpw">
		<div>
			<h4>ID찾기 및 비밀번호 변경</h4>
		</div>
		<div>
			<p>
				<label></label>
				<input type="text" id="findIdEmail" name="email" 
				maxlength="30" placeholder="email" />
				<input type="text" id="findIdPhone" name="phone" 
				maxlength="30" placeholder="phone" />	
			</p>
			<p>
				<button type="button" style="background: #8152f0; cursor: ;" 
				id="forpassword" name="forpassword" onclick="submit()">찾기</button>
			</p>
			<p>
				<button type="button" style="background: #8152f0; cursor: ;"  
				onclick = "location.href='login.do'">취소</button>
			</p>
		</div>
		<div>
			<p class="message">
				아직도 더펀 계정이 없으신가요? <a href="login.do" style="color: #8152f0">회원가입</a>
			</p>
		</div>
	<!-- </form> -->
</div>
</div>

<div class="modal fade bs-modal-sm" id="changePassword" tabindex="0" role="dialog" aria-labelledby="mySmallModalLabel" aria-hidden="true">
<div class="modal-dialog modal-sm">
<div class="modal-content">
	<div class="modal-header">
		<!-- <button type="button" class="close" data-dismiss="modal"
			aria-label="Close">
			<span aria-hidden="true">&times;</span>
		</button> -->
		<h4 class="modal-title" id="myModalLabel">비밀번호 변경하기</h4>
	</div>
	<div class="modal-body">
		<form class="form-horizontal" action="change_pw.do" method="post" id="pwc">
			<input type="hidden" id="cpw" name="id"  value="">
			<fieldset>
				<div class="group, form" style="margin: 0px; padding: 0px">
					<p id="pwdCheckMessage" style="color:red; font-size:11px; margin: 0;"></p>
					<input required="required" type="password" placeholder="변경할 비밀번호 입력"
					class="input" name="pwd" id="newPwd" maxlength="20"
					onkeyup="myNewPwdCheck()">
					<span class="highlight"></span> <span class="bar"></span>
					<!-- <label class="label" for="date"></label> -->
				</div>
				<div class="group, form" style="margin: 0px; padding: 0px;">
					<p id="pwdCheckMessage" style="color:red; font-size:11px; margin: 0;"></p>
					<input required="required" type="password" placeholder="비밀번호 확인"
					class="input" name="" id="newPwdCheck" maxlength="20"
					onkeyup="myNewPwdCheck()">
					<span class="highlight"></span> <span class="bar"></span> 
					<!-- <label class="label" for="date">패스워드 확인</label> -->
				</div>
				<div class="control-group">
					<label class="control-label" for="forpassword"></label>
					<div class="controls">
						<button type="button" id="chang_pw" name="chang_pw" class="btn btn-primary btn-block"
						style="background-color: #E2E2E2; border-color: #E2E2E2;"
						onclick = " pwdSubmit() " disabled="disabled">비밀번호 변경</button>
						<button type="button" id="" name="" class="btn btn-primary btn-block"
						style="background-color: #8152f0; border-color: #8152f0;"
						onclick = "location.href = 'find_id_from.do' ">취소</button>
					</div>
				</div>
			</fieldset>
		</form>
	</div>
</div>
</div>
</div>

<script type="text/javascript">
function submit(){
	console.log("submit");
	$("#find").submit();
}

function pwdSubmit(){
	alert("비밀번호가 변경 되었습니다. 다시 로그인 해주세요.");
	$("#pwc").submit();
}

var newPwdOk = false;

function myNewPwdCheck() {		
	var re = /^[a-zA-Z0-9]{3,12}$/ // 아이디와 패스워드가 적합한지 검사할 정규식
	if($('#newPwd').val() != "" && !re.test($('#newPwd').val())) {
		$("#pwdCheckMessage").text("3~12자의 영문과 숫자로만 입력해 주세요");
		$("#newPwd").focus();
		newPwdOk = false;
		checkSubmitActivation();
    }else if(($('#newPwd').val() != "" && $("#newPwdCheck").val() !="" ) && ($("#newPwd").val() != $("#newPwdCheck").val())){ // 비밀 번호 다르면
		$("#pwdCheckMessage").text("비밀번호가 일치하지 않습니다.");		
		newPwdOk = false;
		checkSubmitActivation();
	}else if($("#newPwdCheck").val() ==""){ // 비밀번호 확인 필드 비어있는경우				
		newPwdOk = false;
		checkSubmitActivation();
	}else{
		$("#pwdCheckMessage").text("");		
		newPwdOk = true;
		checkSubmitActivation();
		/* $("#change_pw").submit(); */
	}
}

function checkSubmitActivation(){
	if(newPwdOk){
	//console.log(newPwdOk + " " + pwdOk + " " + emailOk + " " + nicknameOk + " " + infoOk + " " + phoneOk)
		document.getElementById("chang_pw").disabled = false;
		document.getElementById("chang_pw").style.background = "#8152f0";
		document.getElementById("chang_pw").style.cursor =  "pointer";
	}else{
		document.getElementById("chang_pw").disabled = true;
		document.getElementById("chang_pw").style.background = "#E2E2E2";
		document.getElementById("chang_pw").style.cursor =  "default";
	}
}



</script>




	




</body>
</html>