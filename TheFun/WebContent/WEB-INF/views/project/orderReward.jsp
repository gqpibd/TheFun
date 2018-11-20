<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>The Fun_orderReward</title>
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
        
        <!-- 메인 -->
          <p class="strongGray" style="font-size: 25px">프로젝트명</p>
          
          <!-- 옵션테이블 -->
			<table>
			<tr>
				<td colspan="2" class="pupple" align="left">옵션 title</td>
			</tr>
			<tr>
				<td class="liteGray" align="left">옵션 content</td>
				<td class="liteGray" align="right">n원</td>
			</tr>
			</table>
			<hr color="#818181">
         	
         <!-- 최종결제정보 테이블 -->
         	<table>
         	<tr>
         		<td class="liteGray" align="left">배송비</td>
         		<td class="liteGray" align="right">n원</td>
         	</tr>
            <tr>
         		<td class="liteGray" align="left">펀딩금액</td>
         		<td class="liteGray" align="right">n원</td>
         	</tr>         	
         	<tr>
         		<td class="liteGray" align="left">최종 결제금액</td>
         		<td class="pupple" align="right">n원</td>
         	</tr>	
         	</table>
         	
         	<!-- 결제정보입력 테이블 -->
			<table style="width: 80%">
			<tr>
				<td class="strongGray" align="left" colspan="2">신용(체크)카드번호</td>
			</tr>
			<tr>
				<td><input type="text" name="card1"> <input type="text" name="card2"> </td>
				<td><input type="text" name="card1"> <input type="text" name="card2"> </td>
			</tr>
			<tr>
				<td align="left" width="50%" class="strongGray">유효기간 </td>
				<td align="left" width="50%" class="strongGray">카드 비밀번호 </td>
			</tr>
			<tr>
				<td><input type="text" name="validDate"></td>
				<td><input type="text" name="cardPwd"></td>
			</tr>
			<tr>
				<td class="strongGray" align="left" colspan="2">생년월일(주민번호 앞 6자리)</td>
			</tr>
			<tr>
				<td colspan="2"><input type="text" name="birth"></td>
			</tr>
			</table>
			
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