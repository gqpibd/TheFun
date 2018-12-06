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



<script src="http://code.jquery.com/jquery-latest.js"></script>

<style type="text/css">
.form .register-form {
  display: none;
}
</style>

<script type="text/javascript">
/* function emailCheck() {
	var emailVal = $("#newEmail").val();
	var regExp = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;	
				
	if(emailVal.match(regExp) == null) { // 형식이 올바르지 않은 경우
		$("#emailCheckMessage").text("올바른 이메일을 입력해 주세요");
	    $("#newEmail").focus();
	    emailOk = false;
		checkSubmitActivation();
	    return;
	}
} */


</script>

</head>
<body>

<div>
<div class="form">
	<!-- 로고 -->
	<a href="main.do"><img src="image/main/banner.jpg" width="100%"><br></a>
	
	<br><br>
	
	<!-- id찾기 폼 -->
	<form class="login-form" action="find_id.do" method="post" id="findid">
		<div>
			<h3>ID찾기</h3>
		</div>
		<div>
			<p>
				<label></label>
				<input type="text" id="email" name="email" 
				onkeyup="" maxlength="30" placeholder="email" />
			</p>
			<p>
				<button type="button" style="background: #8152f0; cursor: ;" id="findBtn" onclick="submit()">찾기</button>
			</p>
			<p>
				<button type="button" style="background: #8152f0; cursor: ;"  
				onclick = "location.href='login.do'">취소</button>
			</p>
		</div>
		<div>
			<p class="message">
				비밀번호를 잊어버리셨나요? <a href="find_pw_from.do" style="color: #8152f0">비밀번호 찾기</a>
			</p>
		</div>
	</form>
</div>
</div>
<script type="text/javascript">
function submit(){
	console.log("submit");
	$("#findid").submit();
}
</script>




	




</body>
</html>