<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:requestEncoding value="utf-8"/> 

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<!-- 폰트설정 -->
<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic:400,700,800&amp;subset=korean" rel="stylesheet">

<!-- main CSS설정 -->
 <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
 <meta name="description" content="">
 <meta name="author" content="">
 
<title>The Fun_상세페이지</title>

 <!-- Bootstrap core CSS -->
 <link href="CSS/mainVendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
 <!-- Custom styles for this template -->
 <link href="CSS/mainCss/portfolio-item.css" rel="stylesheet">
 <!-- mainCSS 설정 끝 -->
 
<!-- Bootstrap core CSS -->
<link href="CSS/detailvendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<!-- Custom styles for this template -->
<link href="CSS/detailcss/blog-post.css" rel="stylesheet">
<!-- 디테일설정끝 -->
 
 <style type="text/css">
 p {
   font-family: "Nanum Gothic", sans-serif;
}
 .pupple{
 	color:#8152f0;
 	font-family: "Nanum Gothic", sans-serif;
 }
 .strongGray{
 font-family: "Nanum Gothic", sans-serif;
  color: #5c5c5c;
  
 }
 .liteGray{
 font-family: "Nanum Gothic", sans-serif;
	 color: #c4c4c4;
 }
 .jbMenu {
  background-color:#ffffff;
  text-align: center;
  padding-right: 15px;
  padding-left: 15px;
  margin-right: auto;
  margin-left: auto;
  width: 100%;
}
.jbFixed {
  text-align: center;
  padding-right: 15px;
  padding-left: 15px;
  margin-right: auto;
  margin-left: auto;
   position: fixed;
   top: 0px;
 }

 </style>
<!--  
<script>
  $( document ).ready( function() {
    var jbOffset = $( '.jbMenu' ).offset();
    $( window ).scroll( function() {
      if ( $( document ).scrollTop() > jbOffset.top ) {
        $( '.jbMenu' ).addClass( 'jbFixed' );
      }
      else {
        $( '.jbMenu' ).removeClass( 'jbFixed' );
      }
    });
  } );
</script>
  -->
</head>
<body>

<!-- Navigation 헤더 -->
    <nav class="navbar navbar-expand-lg navbar-dark">
      <div class="container" style="background-color: white;">
        <a class="navbar-brand" href="main.do"><img src="image/main/banner.jpg" width="130px"></a> <!-- 배너 -->
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
              <a class="nav-link" href="/WEB-INF/views/login/login.jsp"><img src="image/main/mainLogin.jpg" height="20px"></a> <!-- 로그인 -->
            </li>
            <li class="nav-item">
              <a class="nav-link" href="regi.do"><img src="image/main/mainRegi.jpg"  height="20px"></a> <!-- 회원가입 -->
            </li>
          </ul>
        </div>
      </div>
    </nav>
 
 <!-- 프로젝트명 부분-->
    <div class="container">
   	<br>
   	<div align="center">
   		<p><b class="pupple">카테고리명  </b>&nbsp;&nbsp;&nbsp;<font class="strongGray">#태그명</font></p>
   
		<table style="width: 100%;">
		
		<tr height="50">
			<td rowspan="5" style="width: 50%" align="right"> 이미지&nbsp;&nbsp;</td>
			<td class="strongGray" align="left" style="width: 50%"><b>n일 남음</b></td>
		</tr>
		<tr height="50">
			<td class="strongGray"align="left"  style="width: 50%"><b>n</b>%달성
		</tr>
		<tr height="50">
			<td class="strongGray"align="left"  style="width: 50%"><b>n</b>원 펀딩
		</tr>
		<tr height="50">
			<td class="strongGray"align="left"  style="width: 50%"><b>n</b>명의 서포터
		</tr>
		<tr height="50">
			<td> <a href="goOrderReward.do"><img src="image/detail/fundBtn.jpg" height="50px"></a> </td>
		</tr>
		<tr height="50">
			<td align="right" class="strongGray">한줄설명 &nbsp;&nbsp; </td>
			<td><a href="#"><img src="image/detail/addcart.jpg" height="50px"></a>카카오톡 공유 </td>
		</tr>
		</table>

		<!-- 메뉴바 -->
		<div style="background-color: white;">
		<div class="jbMenu">
		<hr>
		<table style="width: 100%; background-color: white;">
		<tr>
			<td align="center" class="strongGray" id="story"><font class="menubar">스토리</font></td>
			<td align="center" class="strongGray" id="notice"><font class="menubar">새소식<sup class="pupple"><b>n</b></sup></font></td>
			<td align="center" class="strongGray" id="feedback"><font class="menubar">피드백<sup class="pupple"><b>n</b></sup></font></td>
		</tr>
		</table>
		<hr>
		</div>
	    </div>
	 </div>
<script type="text/javascript">
$(document).ready(function () {
	$("#feedbackContent").hide();
	$("#noticeContent").hide();
});

//마우스커서 모양변환
$(".menubar").mouseover(function () {	
	$(this).css("cursor","pointer");
}); 

//
$(function () {
	$("#story").click(function () {
		//alert("스토리 클릭");
		$("#storyContent").show();
		$("#noticeContent").hide();
		$("#feedbackContent").hide();
	});
	$("#notice").click(function () {
		//alert("새소식 클릭");	
		$("#storyContent").hide();
		$("#noticeContent").show();
		$("#feedbackContent").hide();
	});
	$("#feedback").click(function () {
		//alert("피드백 클릭");	
		$("#storyContent").hide();
		$("#noticeContent").hide();
		$("#feedbackContent").show();
	});
});

</script>
      <div class="row">

        <!-- Main content 스토리, 댓글, 새소식 ★★★★★-->
        <div class="col-lg-8" id="storyContent">
			<jsp:include page="detailStory.jsp"/>
        </div>
        
         <div class="col-lg-8" id="feedbackContent">
			<jsp:include page="detailFeedback.jsp"/>
        </div>
        
         <div class="col-lg-8" id="noticeContent">
			<jsp:include page="detailNotice.jsp"/>
        </div>

        <!-- Sidebar 전체-->
        <div class="col-md-4">
        
          <!--side 회사정보-->
          <p class="strongGray"><b>메이커정보</b></p>
          <div class="card my-4">
            <div class="card-body">   
			<table style="width: 100%">
			<tr>
				<td rowspan="2" align="left" class="strongGray">회사이미지 </td>
				<td align="right" class="strongGray"> 회사명 </td>
			</tr>
			<tr><td align="right" class="strongGray">회사이메일</td> </tr>
			</table>
            </div>
          </div>

          <!-- Side 옵션 -->
          <p class="strongGray"><b>리워드선택</b></p>
          <div class="card my-4">
            <div class="card-body">
              <p>옵션 title</p>
              <p class="liteGray">배송비</p>
              <p>2500원</p>
              <p class="liteGray">리워드 발송 시작일</p>
              <p class="strongGray"> n월n일</p>
              <p class="pupple">제한수량 n개  <b>현재 n개 남음!</b></p>
              <p class="strongGray"><b>총 n개 펀딩완료</b></p>
            </div>
          </div>
		<!-- side옵션 끝 -->
		
		<!-- Side 옵션 -->
          <div class="card my-4">
            <div class="card-body">
              <p>옵션 title</p>
              <p class="liteGray">배송비</p>
              <p>2500원</p>
              <p class="liteGray">리워드 발송 시작일</p>
              <p class="strongGray"> n월n일</p>
              <p class="pupple">제한수량 n개<b>현재 n개 남음!</b></p>
              <p class="strongGray"><b>총 n개 펀딩완료</b></p>
            </div>
          </div>
		<!-- side옵션 끝 -->
		
     	 </div>
     	<!-- sidebar 끝 -->

      </div>
      <!-- /.row -->

    </div>
    <!-- /.container -->


 <!-- Footer -->
    <footer class="py-5">
      <div class="container">
        <p class="m-0 text-center">더펀(주) | 서울특별시 뿅뿅구 뿅뿅동 123-88</p>
      </div>
      <!-- /.container -->
    </footer>

    <!-- Bootstrap core JavaScript -->
    <script src="vendor/jquery/jquery.min.js"></script>
    <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

</body>
</html>