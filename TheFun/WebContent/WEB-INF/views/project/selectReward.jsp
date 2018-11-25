<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<meta charset="UTF-8">
<title>The Fun_selectReward</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<!-- 폰트설정 -->
<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic:400,700,800&amp;subset=korean" rel="stylesheet">

<!-- main CSS설정 -->
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<meta name="description" content="">
	<meta name="author" content="">
 <!-- Bootstrap core CSS -->
	<link href="CSS/mainVendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<!-- Custom styles for this template -->
	<link href="CSS/mainCss/portfolio-item.css" rel="stylesheet">
 <!-- mainCSS 설정 끝 -->
 
<style type="text/css">
 .strongGray{
 font-family: "Nanum Gothic", sans-serif;
  color: #5c5c5c;
  font-weight: bold;
  
 }
 .liteGray{
 font-family: "Nanum Gothic", sans-serif;
	 color: #818181;
 }
.checkOption{
 	border: 1px solid #818181;
}
table{
	width:70%;
	border: 1px solid #818181;
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
              <a class="nav-link" href="regi.do"><img src="image/main/mainRegi.jpg"  height="20px"></a> <!-- 회원가입 -->
            </li>
          </ul>
        </div>
      </div>
    </nav>

 <!-- Page Content -->
    <div class="container">
      <div class="my-4" align="center">
        <div align="center">
          <p class="strongGray" style="font-size: 25px">프로젝트명</p>
          <img src="image/detail/selectReword.jpg" width="120px"> <strong class="strongGray">펀딩해주시는 금액에 따라 감사의 의미로 리워드를 제공 해 드립니다.</strong>
          <br><br>
          
          <!-- 테이블 영역 -->
           <table>
           <tr>
          	<td>  </td>
          </tr>
          <tr>
          	<td class="strongGray" rowspan="3"><p> <input type="checkbox">&nbsp; n 원 펀딩합니다</p>
			 <p class="liteGray">&nbsp;&nbsp;&nbsp; 옵션 title</p>
			 <p class="liteGray">&nbsp;&nbsp;&nbsp; 옵션 content</p>        	
          	</td>
          </table>
          <br>
          
          <!-- 갯수만큼증가 -->
           <table>
           <tr>
          	<td>  </td>
          </tr>
          <tr>
          	<td class="strongGray" rowspan="3"><p> <input type="checkbox">&nbsp; n 원 펀딩합니다</p>
			 <p class="liteGray">&nbsp;&nbsp;&nbsp; 옵션 title</p>
			 <p class="liteGray">&nbsp;&nbsp;&nbsp; 옵션 content</p>        	
          	</td>
          </table>
          <br>
          <br>
            <a href="goOrder.do"><img src="image/detail/next.jpg" width="120px"></a>
          
        </div>
      </div>
      <!-- /.row -->
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