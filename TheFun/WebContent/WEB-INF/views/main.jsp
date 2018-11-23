<%@page import="donzo.thefun.model.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<fmt:requestEncoding value="UTF-8"/>
<%
	MemberDto login = (MemberDto) session.getAttribute("login");
	System.out.println(login);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width"/>

<meta name="google-signin-client_id" content="884451928834-qqlq8ck53ft5q6at5am0anhmkg43jq3b.apps.googleusercontent.com"> <!-- 구글 api사용 -->
<script src="https://apis.google.com/js/platform.js" async defer></script> <!-- 구글 아이디로 로그인 -->
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script> <!-- 카카오로그인  -->
<!-- main CSS설정 -->
 <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
 <meta name="description" content="">
 <meta name="author" content="">

 <title>The Fun_더 아름다운 세상을 위한 펀딩</title>

 <!-- Bootstrap core CSS -->
 <link href="CSS/mainVendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
 <!-- Custom styles for this template -->
 <link href="CSS/mainCss/portfolio-item.css" rel="stylesheet">
 <!-- mainCSS 설정 끝 -->
<script type="text/javascript" src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.0.js" charset="utf-8"></script><!-- 네이버 아이디로 로그인 -->
<!-- Bootstrap core JavaScript -->
<script src="CSS/mainVendor/jquery/jquery.min.js"></script>
<script src="CSS/mainVendor/bootstrap/js/bootstrap.bundle.min.js"></script>
 <style type="text/css">
 .pTitle{
 	font-weight: bold;
 	color: black;
 	font-size: large;
 }
 .pName{
 	color: gray;
 	font-size: small;
 }
 </style>
</head>
<body>


 <!-- Navigation 헤더 -->
    <nav class="navbar navbar-expand-lg navbar-dark">
      <div class="container" style="background-color: white;">
        <a class="navbar-brand" href="#"><img src="image/main/banner.jpg" width="130px"></a> <!-- 배너 -->
        <a href="#"><img src="image/main/done.jpg" width="50px"></a> <!-- 기부 -->
        <a href="#"><img src="image/main/funding.jpg" width="55px"></a> <!-- 펀딩 -->
        <a href="#"><img src="image/main/history.jpg" width="90px"></a> <!-- 히스토리 (종료된 프로젝트) -->
        <a href="#"><img src="image/main/newproject.jpg" width="90px"></a> <!-- 새 프로젝트 만들기 -->
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
          <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarResponsive">
          <ul class="navbar-nav ml-auto">
            <li class="nav-item">
            <c:if test="${login eq null}">
            	<a class="nav-link" href="login.do"><img src="image/main/mainLogin.jpg" height="20px"></a> <!-- 로그인 -->				
			</c:if>
			<c:if test="${login ne null}">
				<span id="profile"></span>			
				<a href="#" onclick="logout()">로그아웃</a> <!-- 로그인 -->
				<button type="button" onclick="location.href='feedBack.do'">피드백</button>
				<button type="button" onclick="location.href='getMypage.do?id=${login.id}'">마이페이지</button>					
				<c:if test="${login.auth eq MemberDto.MANAGER}">
					<button type="button" onclick="location.href='projectManage.do'">프로젝트 관리</button>
				</c:if>
			</c:if>
              
            </li>
            <li class="nav-item">
              <a class="nav-link" href="regiMain.do"><img src="image/main/mainRegi.jpg"  height="20px"></a> <!-- 회원가입 -->
            </li>
          </ul>
        </div>
      </div>
    </nav>

 <!-- Page Content -->
    <div class="container">

      <!-- 메인첫시작점 -->
		<br><br>

      <!-- 메인 사진 -->
      <div class="row" align="center">
        <div align="center">
          <img class="img-fluid" src="image/main/mainImg1.PNG">
        </div>
      </div>
      <!-- /.row -->

      <!-- 리스트 -->
      <h3 class="my-4">HOT 프로젝트</h3>

      <div class="row">

        <div class="col-md-3 col-sm-6 mb-4">
          <a href="detail.do">
            <img class="img-fluid" src="image/main/mainImg7.PNG" alt="">
          </a><br>
          <p class="pTitle">프로젝트 타이틀</p>
          <p class="pName">카테고리 | 회사이름</p>
        </div>

        <div class="col-md-3 col-sm-6 mb-4">
          <a href="detail.do">
            <img class="img-fluid" src="image/main/mainImg7.PNG" alt="">
          </a><br>
          <p class="pTitle">프로젝트 타이틀</p>
          <p class="pName">카테고리 | 회사이름</p>
        </div>

        <div class="col-md-3 col-sm-6 mb-4">
          <a href="detail.do">
            <img class="img-fluid" src="image/main/mainImg7.PNG" alt="">
          </a><br>
           <p class="pTitle">프로젝트 타이틀</p>
          <p class="pName">카테고리 | 회사이름</p>
        </div>

        <div class="col-md-3 col-sm-6 mb-4">
          <a href="detail.do">
            <img class="img-fluid" src="image/main/mainImg7.PNG" alt="">
          </a><br>
          <p class="pTitle">프로젝트 타이틀</p>
          <p class="pName">카테고리 | 회사이름</p>
        </div>

      </div>
      <!-- /.row 리스트끝-->

orderBtn.jpg
    </div>
    <!-- /.container 메인컨테이너 끝-->

    <!-- Footer -->
    <footer class="py-5">
      <div class="container">
        <p class="m-0 text-center">더펀(주) | 서울특별시 뿅뿅구 뿅뿅동 123-88</p>
      </div>
      <!-- /.container -->
    </footer>

    <script type="text/javascript">
		
    //var naverLogin = new naver.LoginWithNaverId("vb6UHNxUFoBsi487fDmI", "http://localhost:8090/TheFun/");
	/* 네아로 로그인 정보를 초기화하기 위하여 init을 호출 */
	//naverLogin.init();	
	//window.addEventListener('load', function () {
	//	naverLogin.getLoginStatus(function (status) {
	//		if (status) {
				/* 로그인 상태가 "true" 인 경우  */
	//			setLoginStatus();
	//		}
	//	});
	//});
	Kakao.init('dd0c44a9e5b9f94ce480a440c3113d2d');
	function setLoginStatus() {
		var profileImage = naverLogin.user.getProfileImage();
		var nickName = naverLogin.user.getNickName();
		$("#profile").html('<img src="' + profileImage + '" height=50 />' + nickName + '님 반갑습니다.');		
	}
	function logout() {
		//naverLogin.logout();
		Kakao.Auth.logout();
		location.href="logout.do";
	}
	</script>
</body>
</html>