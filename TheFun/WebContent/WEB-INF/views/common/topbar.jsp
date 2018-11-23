<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

    <!-- Navigation 헤더 -->
    <nav class="navbar navbar-expand-lg navbar-dark" style="z-index: 1">
      <div class="container" style="background-color: white;">
		<a class="navbar-brand" href="main.do"><img src="image/main/banner.jpg" width="130px"></a> <!-- 배너  -->
        <a href="#"><img src="image/main/done.jpg" width="50px"></a> <!-- 기부 -->
        <a href="#"><img src="image/main/funding.jpg" width="55px"></a> <!-- 펀딩 -->
        <a href="#"><img src="image/main/history.jpg" width="90px"></a> <!-- 히스토리 (종료된 프로젝트) -->
        <a href="#"><img src="image/main/newproject.jpg" width="90px"></a> <!-- 새 프로젝트 만들기 -->

        <form id="_frmFormSearch" name="frmForm1">
	        <input type="text" value="${s_keyword }" name="s_keyword" id="s_keywordTextField" style="width: 200px" onkeypress="if(event.keyCode==13) {search_Enter(); return false;}">
	        <a href="#none" id="search_Btn">검색</a>
	        <!-- controller로 넘겨주기 위한 값 -->
		<input type="hidden" name="pageNumber" id="_pageNumber" value="${(empty pageNumber)?0:pageNumber}">
		<input type="hidden" name="recordCountPerPage" id="_recordCountPerPage" value="${(empty recordCountPerPage) ? 8 : recordCountPerPage}">
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
		$("#_pageNumber").val(0);
		$("#s_keywordTextField").text($("#s_keywordTextField").text());
		$("#_frmFormSearch").attr("action","searchProjectList.do").submit();
	});
});
   
function search_Enter() {	// 엔터 쳤을 때 검색
	$("#_pageNumber").val(0);
	$("#s_keywordTextField").text($("#s_keywordTextField").text());
	$("#_frmFormSearch").attr("action","searchProjectList.do").submit();
}

/* 페이지 번호를 클릭했을 때 */
function goPage(pageNumber) {
	$("#_pageNumber").val(pageNumber);
	/* alert(pageNumber); */
	$("#_frmFormSearch").attr({"target":"_self", "action":"searchProjectList.do"}).submit();
}
</script>
    
    
     
