<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

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
              <a class="nav-link" href="/WEB-INF/views/login/login.jsp"><img src="image/main/mainLogin.jpg" height="20px"></a> <!-- 로그인 -->
            </li>
            <li class="nav-item">
              <a class="nav-link" href="/WEB-INF/views/login/regiMain.jsp"><img src="image/main/mainRegi.jpg"  height="20px"></a> <!-- 회원가입 -->
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
          <a href="#">
            <img class="img-fluid" src="image/main/mainImg7.PNG" alt="">
          </a><br>
          <p class="pTitle">프로젝트 타이틀</p>
          <p class="pName">카테고리 | 회사이름</p>
        </div>

        <div class="col-md-3 col-sm-6 mb-4">
          <a href="#">
            <img class="img-fluid" src="image/main/mainImg7.PNG" alt="">
          </a><br>
          <p class="pTitle">프로젝트 타이틀</p>
          <p class="pName">카테고리 | 회사이름</p>
        </div>

        <div class="col-md-3 col-sm-6 mb-4">
          <a href="#">
            <img class="img-fluid" src="image/main/mainImg7.PNG" alt="">
          </a><br>
           <p class="pTitle">프로젝트 타이틀</p>
          <p class="pName">카테고리 | 회사이름</p>
        </div>

        <div class="col-md-3 col-sm-6 mb-4">
          <a href="#">
            <img class="img-fluid" src="image/main/mainImg7.PNG" alt="">
          </a><br>
          <p class="pTitle">프로젝트 타이틀</p>
          <p class="pName">카테고리 | 회사이름</p>
        </div>

      </div>
      <!-- /.row 리스트끝-->

    </div>
    <!-- /.container 메인컨테이너 끝-->

    <!-- Footer -->
    <footer class="py-5">
      <div class="container">
        <p class="m-0 text-center">더펀(주) | 서울특별시 뿅뿅구 뿅뿅동 123-88</p>
      </div>
      <!-- /.container -->
    </footer>

    <!-- Bootstrap core JavaScript -->
    <script src="CSS/mainVendor/jquery/jquery.min.js"></script>
    <script src="CSS/mainVendor/bootstrap/js/bootstrap.bundle.min.js"></script>


</body>
</html>