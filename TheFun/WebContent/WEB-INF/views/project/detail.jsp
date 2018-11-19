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

<!-- main CSS설정 -->
 <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
 <meta name="description" content="">
 <meta name="author" content="">
 
<title>The Fun_디테일</title>

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
 .pupple{
 	color:#8152f0;
 }
 .strongGray{
  color: #5c5c5c;
  
 }
 .liteGray{
	 color: #c4c4c4;
 }
 
 </style>
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
   
		<table border="1" style="width: 100%">
		<tr>
			<td rowspan="5" style="width: 50%">이미지</td>
			<td class="strongGray" align="left" style="width: 50%"><b>n일 남음</b></td>
		</tr>
		<tr >
			<td class="strongGray"align="left"  style="width: 50%"><b>n</b>%달성
		</tr>
		<tr>
			<td class="strongGray"align="left"  style="width: 50%"><b>n</b>원 펀딩
		</tr>
		<tr>
			<td class="strongGray"align="left"  style="width: 50%"S><b>n</b>명의 서포터
		</tr>
		<tr>
			<td> <img src="image/detail/fundBtn.jpg"> </td>
		</tr>
		
		</table>
		<hr>
		<!-- 메뉴바 -->
		
		<hr>
	 </div>
      <div class="row">

        <!-- 스토리, 댓글, 새소식-->
        <div class="col-lg-8">
			<h1>스토리~~</h1>

        </div>

        <!-- Sidebar 회사명-->
        <div class="col-md-4">
          <!-- Categories Widget -->
          <div class="card my-4">
            <h5 class="card-header">회사명</h5>
            <div class="card-body">   
					회사디테일
            </div>
          </div>

          <!-- Side 옵션 -->
          <div class="card my-4">
            <h5 class="card-header">옵션타이틀</h5>
            <div class="card-body">
              <p>옵션콘텐츠</p>
            </div>
          </div>

        </div>

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