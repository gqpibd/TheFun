<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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


</head>
<body>

<div>
<div class="form">
	<!-- 로고 -->
	<a href="main.do"><img src="image/main/banner.jpg" width="100%"><br></a>
	
	<br><br>
	
	<!-- id찾기 폼 -->
		<div>
			<h3>검색결과</h3>
		</div>
		<div>
			<h5>
				${ id }
			</h5>
			<p>
				<label></label>
			</p>
			<p>
				<button type="button" style="background: #8152f0; cursor: ;" 
				id="loginBtn " disabled="disabled"
				onclick = "location.href='login.do'">로그인</button>
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
</div>
</div>



</body>
</html>