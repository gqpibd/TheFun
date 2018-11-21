<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

    <!-- Navigation 헤더 -->
    <nav class="navbar navbar-expand-lg navbar-dark">
      <div class="container" style="background-color: white;">
		<a class="navbar-brand" href="main.do"><img src="image/main/banner.jpg" width="130px"></a> <!-- 배너  -->
        <a href="#"><img src="image/main/done.jpg" width="50px"></a> <!-- 기부 -->
        <a href="#"><img src="image/main/funding.jpg" width="55px"></a> <!-- 펀딩 -->
        <a href="#"><img src="image/main/history.jpg" width="90px"></a> <!-- 히스토리 (종료된 프로젝트) -->
        <a href="#"><img src="image/main/newproject.jpg" width="90px"></a> <!-- 새 프로젝트 만들기 -->
        <!-- &nbsp;&nbsp;&nbsp;	// 검색 후 정렬하기로 하였음
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
        <form id="frm_search">
	        <input type="text" name="s_keyword" id="s_keywordTextField" style="width: 200px" onkeypress="if(event.keyCode==13) {search_Enter(); return false;}">
	        <a href="#none" id="search_Btn">검색</a>
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
    
    
    <script>
    $(document).ready(function () {
    	$("#search_Btn").click(function () {
    		$("#frm_search").attr("action","searchProject.do").submit();
		});
	});
    
    function search_Enter() {	// 엔터 쳤을 때 검색
    	$("#frm_search").attr("action","searchProject.do").submit();
	}
    </script>
    
    
    
     
