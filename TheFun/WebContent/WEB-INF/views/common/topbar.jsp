<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<fmt:requestEncoding value="UTF-8"/>
<script type="text/javascript">
window.fbAsyncInit = function() {
	FB.init({
		appId : '2123794117640622',
		cookie : true,
		xfbml : true,
		version : 'v3.2'
	});	
	
	FB.getLoginStatus(function(response) {
		if (response.status === 'connected') {
			//console.log("페이스북 로그인 되어있음")
		} else {
			//console.log("페이스북 로그인 되어있지 않음")
		}
	});
};
(function(d, s, id) {
	var js, fjs = d.getElementsByTagName(s)[0];
	if (d.getElementById(id)) {
		return;
	}
	js = d.createElement(s);
	js.id = id;
	js.src = "https://connect.facebook.net/en_US/sdk.js";
	fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));		
</script>

<!-- <div class="top-menu"> -->
<!-- Navigation 헤더 -->
<nav class="navbar navbar-expand-lg navbar-dark">
  <div class="container" style="background-color: white;">
<a class="navbar-brand" href="main.do"><img src="image/main/banner.jpg" width="130px"></a><!--  배너 --> 
    <a href="#"><img src="image/main/done.jpg" width="50px"></a><!--  기부 -->
    <a href="#"><img src="image/main/funding.jpg" width="55px"></a><!--  펀딩 -->
    <a href="#"><img src="image/main/history.jpg" width="90px"></a> <!-- 히스토리 (종료된 프로젝트) -->
    <a href="#"><img src="image/main/newproject.jpg" width="90px"></a> <!-- 새 프로젝트 만들기 -->
    &nbsp;&nbsp;&nbsp;
    
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
			<c:if test="${login eq null}">
			         	<a class="nav-link" href="login.do"><img src="image/main/mainLogin.jpg" height="20px"></a> <!-- 로그인 -->				
			</c:if>
			<c:if test="${login ne null}">
				<span id="profile"></span>			
				<a href="#" onclick="logout()">로그아웃</a> <!-- 로그인 -->
				<button type="button" onclick="location.href='feedBack.do'">피드백</button>
				<button type="button" onclick="location.href='myPage.do?id=${login.id}'">마이페이지</button>					
				<c:if test="${login.auth eq MemberDto.MANAGER}">
					<button type="button" onclick="location.href='projectManage.do'">프로젝트 관리</button>
				</c:if>
			</c:if>
        </li>
      </ul>
    </div>
  </div>
</nav>
    
<script type="text/javascript">	
	/* 로그아웃 */
	function logout() {
		console.log("로그아웃");
		/* 페이스북 로그아웃 */
		FB.logout(function(response) { /* user is now logged out */	}); 
		location.href="logout.do";		
	}
	
    $(document).ready(function () {
    	$("#search_Btn").click(function () {
    		$("#frm_search").attr("action","searchProject.do").submit();
		});
	});
    
    function search_Enter() {	// 엔터 쳤을 때 검색
    	$("#frm_search").attr("action","searchProject.do").submit();
	}
</script>