<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


    <!-- Navigation 헤더 -->
    <nav class="navbar navbar-expand-lg navbar-dark">
      <div class="container" style="background-color: white;">
		<a class="navbar-brand" href="main.do"><img src="image/main/banner.jpg" width="130px"></a> <!-- 배너  -->
        <a href="#"><img src="image/main/done.jpg" width="50px"></a> <!-- 기부 -->
        <a href="#"><img src="image/main/funding.jpg" width="55px"></a> <!-- 펀딩 -->
        <a href="#"><img src="image/main/history.jpg" width="90px"></a> <!-- 히스토리 (종료된 프로젝트) -->
        <a href="#"><img src="image/main/newproject.jpg" width="90px"></a> <!-- 새 프로젝트 만들기 -->
        <!-- &nbsp;&nbsp;&nbsp;
        <select name="s_type" onchange="setCategory(this)">
        	<option selected="selected" value="">선택</option>
        	<option value="reward">리워드</option>
        	<option value="donation">기부</option>
        </select>
        <select name="s_category">
        	<option selected="selected" value="" id="opt1">--</option>
        	<option value="" id="opt2">--</option>
        	<option value="" id="opt3">--</option>
        </select> -->
        <form action="searchProject.do">
        <input type="text" name="s_keyword" style="width: 200px">
        <input type="submit" id="search_Btn" value="검색">
        </form>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
          <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarResponsive">
          <ul class="navbar-nav ml-auto">
            <li class="nav-item">
              <a class="nav-link" href="login.do"><img src="image/main/mainLogin.jpg" height="20px"></a> <!-- 로그인 -->
            </li>
            <li class="nav-item">
              <a class="nav-link" href="regi.do"><img src="image/main/mainRegi.jpg"  height="20px"></a> <!-- 회원가입 -->
            </li>
          </ul>
        </div>
      </div>
    </nav>
    
    <!--
    <script>
    $(document).ready(function () {
    	$(document).on("click", "#search_Btn", function () {
		});
	});
    </script>
     -->
