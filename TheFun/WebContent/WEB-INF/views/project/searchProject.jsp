<%@page import="donzo.thefun.model.ProjectDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<fmt:requestEncoding value="utf-8"/>   

<style>
.tab {
	list-style: none;
	margin: 0;
	padding: 0;
	overflow: hidden;
}
/* Float the list items side by side */
.tab li {
	float: left;
}
/* Style the links inside the list items */
.tab li a {
	display: inline-block;
	color: #000;
	text-align: center;
	text-decoration: none;
	padding: 10px 14px;
	font-size: 17px;
	transition:0.3s;
}
/* Style the tab content */
/* .tabcontent {
	display: none;
	background-color:rgb(0,154,200);
	padding: 5px 10px;
	color:#fff;
} */
ul.tab li:hover{
	border-radius: 15px;
	background-color: #8152f050;
}

ul.tab li a:hover{
	border-radius: 15px;
	background-color: #8152f050;
	color: #FFF;
}

ul.tab li.current{
	border-radius: 15px;
	background-color: rgb(129,082,240);
	selected:selected;
	color: #FFF;
}
ul.tab li.selected{
	border-radius: 15px;
	background-color: rgb(129,082,240);
	color: #FFF;
}
ul.tab li.current a{
	color:#FFF;
}
/* .tabcontent.current {
	display: block;
} */
.head_title {
  font-size: 200%;
  text-transform: uppercase;
  letter-spacing: 3px;
  font-weight: bold;
}
#line_header {
  background: #fff;
  color: #00000090;
  padding: 20px;
}
#line_header p {
  font-family: 'Allura';
  color: #00000090;
  font-size: 40px;
}
</style>

<!-- 차트 css -->
<link rel="stylesheet" href="https://cdn.rawgit.com/theus/chart.css/v1.0.0/dist/chart.css" />

<!-- 몇 건인지 표시하려고 -->
<div style="background: #fff;">

<div style="background: #fff;margin-top: 3%;padding-bottom: 3%;">
<c:choose>

	<c:when test="${doc_title eq 'all'}">
	<header id="line_header">
	<div class="container text-center">
	<!-- <h1 class="head_title">SEARCH</h1> -->
	<p>모든 프로젝트</p>
	<c:choose>
	<c:when test="${ !empty s_keyword or s_keyword ne ''}">
		<c:choose>
		<c:when test="${empty more_s_keyword or more_s_keyword eq ''}">
			<h5 style="font-family: 'Allura';">"${s_keyword }" 의 검색 결과 ${totalRecordCount } 건</h5>
		</c:when>
		<c:when test="${!empty more_s_keyword or more_s_keyword ne ''}">
			<h5 style="font-family: 'Allura';">"${s_keyword }" 의 검색 결과 중, "${more_s_keyword }" 결과 내 검색 ${totalRecordCount } 건</h5>
		</c:when>
		<c:otherwise>
		
		</c:otherwise>
		</c:choose>
	</c:when>
	<c:otherwise>
	<c:choose>
		<c:when test="${empty more_s_keyword or more_s_keyword eq ''}">
		<h5 style="font-family: 'Allura';">총 ${totalRecordCount } 건</h5>
		</c:when>
		<c:when test="${!empty more_s_keyword or more_s_keyword ne ''}">
			<h5 style="font-family: 'Allura';">"${more_s_keyword }" 결과 내 검색 ${totalRecordCount } 건</h5>
		</c:when>
		<c:otherwise>
		
		</c:otherwise>
	</c:choose>
	</c:otherwise>
	</c:choose>
	</div>
	</header>
	</c:when>
	
	<c:when test="${doc_title eq 'ing'}">
	<header id="line_header">
	<div class="container text-center">
	<!-- <h1 class="head_title">SEARCH</h1> -->
	<p>진행 중인 프로젝트</p>
	<c:choose>
	<c:when test="${ !empty s_keyword or s_keyword ne ''}">
		<c:choose>
		<c:when test="${empty more_s_keyword or more_s_keyword eq ''}">
			<h5 style="font-family: 'Allura';">"${s_keyword }" 의 검색 결과 ${totalRecordCount } 건</h5>
		</c:when>
		<c:when test="${!empty more_s_keyword or more_s_keyword ne ''}">
			<h5 style="font-family: 'Allura';">"${s_keyword }" 의 검색 결과 중, "${more_s_keyword }" 결과 내 검색 ${totalRecordCount } 건</h5>
		</c:when>
		<c:otherwise>
		
		</c:otherwise>
		</c:choose>
	</c:when>
	<c:otherwise>
	<c:choose>
		<c:when test="${empty more_s_keyword or more_s_keyword eq ''}">
		<h5 style="font-family: 'Allura';">총 ${totalRecordCount } 건</h5>
		</c:when>
		<c:when test="${!empty more_s_keyword or more_s_keyword ne ''}">
			<h5 style="font-family: 'Allura';">"${more_s_keyword }" 결과 내 검색 ${totalRecordCount } 건</h5>
		</c:when>
		<c:otherwise>
		
		</c:otherwise>
	</c:choose>
	</c:otherwise>
	</c:choose>
	</div>
	</header>
	</c:when>
	
	<c:when test="${doc_title eq 'edateASC'}">
	<header id="line_header">
	<div class="container text-center">
	<!-- <h1 class="head_title">SEARCH</h1> -->
	<p>곧 끝나는 프로젝트</p>
	<c:choose>
	<c:when test="${ !empty s_keyword or s_keyword ne ''}">
		<c:choose>
		<c:when test="${empty more_s_keyword or more_s_keyword eq ''}">
			<h5 style="font-family: 'Allura';">"${s_keyword }" 의 검색 결과 ${totalRecordCount } 건</h5>
		</c:when>
		<c:when test="${!empty more_s_keyword or more_s_keyword ne ''}">
			<h5 style="font-family: 'Allura';">"${s_keyword }" 의 검색 결과 중, "${more_s_keyword }" 결과 내 검색 ${totalRecordCount } 건</h5>
		</c:when>
		<c:otherwise>
		
		</c:otherwise>
		</c:choose>
	</c:when>
	<c:otherwise>
	<c:choose>
		<c:when test="${empty more_s_keyword or more_s_keyword eq ''}">
		<h5 style="font-family: 'Allura';">총 ${totalRecordCount } 건</h5>
		</c:when>
		<c:when test="${!empty more_s_keyword or more_s_keyword ne ''}">
			<h5 style="font-family: 'Allura';">"${more_s_keyword }" 결과 내 검색 ${totalRecordCount } 건</h5>
		</c:when>
		<c:otherwise>
		
		</c:otherwise>
	</c:choose>
	</c:otherwise>
	</c:choose>
	</div>
	</header>
	</c:when>
	
	<c:when test="${doc_title eq 'regdateDESC'}">
	<header id="line_header">
	<div class="container text-center">
	<!-- <h1 class="head_title">SEARCH</h1> -->
	<p>최신  프로젝트</p>
	<c:choose>
	<c:when test="${ !empty s_keyword or s_keyword ne ''}">
		<c:choose>
		<c:when test="${empty more_s_keyword or more_s_keyword eq ''}">
			<h5 style="font-family: 'Allura';">"${s_keyword }" 의 검색 결과 ${totalRecordCount } 건</h5>
		</c:when>
		<c:when test="${!empty more_s_keyword or more_s_keyword ne ''}">
			<h5 style="font-family: 'Allura';">"${s_keyword }" 의 검색 결과 중, "${more_s_keyword }" 결과 내 검색 ${totalRecordCount } 건</h5>
		</c:when>
		<c:otherwise>
		
		</c:otherwise>
		</c:choose>
	</c:when>
	<c:otherwise>
	<c:choose>
		<c:when test="${empty more_s_keyword or more_s_keyword eq ''}">
		<h5 style="font-family: 'Allura';">총 ${totalRecordCount } 건</h5>
		</c:when>
		<c:when test="${!empty more_s_keyword or more_s_keyword ne ''}">
			<h5 style="font-family: 'Allura';">"${more_s_keyword }" 결과 내 검색 ${totalRecordCount } 건</h5>
		</c:when>
		<c:otherwise>
		
		</c:otherwise>
	</c:choose>
	</c:otherwise>
	</c:choose>
	</div>
	</header>
	</c:when>
	
	<c:when test="${doc_title eq 'complete'}">
	<header id="line_header">
	<div class="container text-center">
	<!-- <h1 class="head_title">HISTORY</h1> -->
	<p>끝난 프로젝트</p>
	<c:choose>
	<c:when test="${ !empty s_keyword or s_keyword ne ''}">
		<c:choose>
		<c:when test="${empty more_s_keyword or more_s_keyword eq ''}">
			<h5 style="font-family: 'Allura';">"${s_keyword }" 의 검색 결과 ${totalRecordCount } 건</h5>
		</c:when>
		<c:when test="${!empty more_s_keyword or more_s_keyword ne ''}">
			<h5 style="font-family: 'Allura';">"${s_keyword }" 의 검색 결과 중, "${more_s_keyword }" 결과 내 검색 ${totalRecordCount } 건</h5>
		</c:when>
		<c:otherwise>
		
		</c:otherwise>
		</c:choose>
	</c:when>
	<c:otherwise>
	<c:choose>
		<c:when test="${empty more_s_keyword or more_s_keyword eq ''}">
		<h5 style="font-family: 'Allura';">총 ${totalRecordCount } 건</h5>
		</c:when>
		<c:when test="${!empty more_s_keyword or more_s_keyword ne ''}">
			<h5 style="font-family: 'Allura';">"${more_s_keyword }" 결과 내 검색 ${totalRecordCount } 건</h5>
		</c:when>
		<c:otherwise>
		
		</c:otherwise>
	</c:choose>
	</c:otherwise>
	</c:choose>
	</div>
	</header>
	</c:when>

	<c:when test="${doc_title eq ProjectDto.TYPE_DONATION}">
	<header id="line_header">
	<div class="container text-center">
	<!-- <h1 class="head_title">SEARCH</h1> -->
	<p>기부</p>
	<c:choose>
	<c:when test="${ !empty s_keyword or s_keyword ne ''}">
		<c:choose>
		<c:when test="${empty more_s_keyword or more_s_keyword eq ''}">
			<h5 style="font-family: 'Allura';">"${s_keyword }" 의 검색 결과 ${totalRecordCount } 건</h5>
		</c:when>
		<c:when test="${!empty more_s_keyword or more_s_keyword ne ''}">
			<h5 style="font-family: 'Allura';">"${s_keyword }" 의 검색 결과 중, "${more_s_keyword }" 결과 내 검색 ${totalRecordCount } 건</h5>
		</c:when>
		<c:otherwise>
		
		</c:otherwise>
		</c:choose>
	</c:when>
	<c:otherwise>
	<c:choose>
		<c:when test="${empty more_s_keyword or more_s_keyword eq ''}">
		<h5 style="font-family: 'Allura';">총 ${totalRecordCount } 건</h5>
		</c:when>
		<c:when test="${!empty more_s_keyword or more_s_keyword ne ''}">
			<h5 style="font-family: 'Allura';">"${more_s_keyword }" 결과 내 검색 ${totalRecordCount } 건</h5>
		</c:when>
		<c:otherwise>
		
		</c:otherwise>
	</c:choose>
	</c:otherwise>
	</c:choose>
	</div>
	</header>
	</c:when>
	
	<c:when test="${doc_title eq 'donationHuman'}">
	<header id="line_header">
	<div class="container text-center">
	<!-- <h1 class="head_title">SEARCH</h1> -->
	<p>기부 - 인권 프로젝트</p>
	<c:choose>
	<c:when test="${ !empty s_keyword or s_keyword ne ''}">
		<c:choose>
		<c:when test="${empty more_s_keyword or more_s_keyword eq ''}">
			<h5 style="font-family: 'Allura';">"${s_keyword }" 의 검색 결과 ${totalRecordCount } 건</h5>
		</c:when>
		<c:when test="${!empty more_s_keyword or more_s_keyword ne ''}">
			<h5 style="font-family: 'Allura';">"${s_keyword }" 의 검색 결과 중, "${more_s_keyword }" 결과 내 검색  ${totalRecordCount } 건</h5>
		</c:when>
		<c:otherwise>
		
		</c:otherwise>
		</c:choose>
	</c:when>
	<c:otherwise>
	<c:choose>
		<c:when test="${empty more_s_keyword or more_s_keyword eq ''}">
		<h5 style="font-family: 'Allura';">총 ${totalRecordCount } 건</h5>
		</c:when>
		<c:when test="${!empty more_s_keyword or more_s_keyword ne ''}">
			<h5 style="font-family: 'Allura';">"${more_s_keyword }" 결과 내 검색 ${totalRecordCount } 건</h5>
		</c:when>
		<c:otherwise>
		
		</c:otherwise>
	</c:choose>
	</c:otherwise>
	</c:choose>
	</div>
	</header>
	</c:when>
	
	<c:when test="${doc_title eq 'donationAnimal'}">
	<header id="line_header">
	<div class="container text-center">
	<!-- <h1 class="head_title">SEARCH</h1> -->
	<p>기부 - 동물 프로젝트</p>
	<c:choose>
	<c:when test="${ !empty s_keyword or s_keyword ne ''}">
		<c:choose>
		<c:when test="${empty more_s_keyword or more_s_keyword eq ''}">
			<h5 style="font-family: 'Allura';">"${s_keyword }" 의 검색 결과 ${totalRecordCount } 건</h5>
		</c:when>
		<c:when test="${!empty more_s_keyword or more_s_keyword ne ''}">
			<h5 style="font-family: 'Allura';">"${s_keyword }" 의 검색 결과 중, "${more_s_keyword }" 결과 내 검색 ${totalRecordCount } 건</h5>
		</c:when>
		<c:otherwise>
		
		</c:otherwise>
		</c:choose>
	</c:when>
	<c:otherwise>
	<c:choose>
		<c:when test="${empty more_s_keyword or more_s_keyword eq ''}">
		<h5 style="font-family: 'Allura';">총 ${totalRecordCount } 건</h5>
		</c:when>
		<c:when test="${!empty more_s_keyword or more_s_keyword ne ''}">
			<h5 style="font-family: 'Allura';">"${more_s_keyword }" 결과 내 검색 ${totalRecordCount } 건</h5>
		</c:when>
		<c:otherwise>
		
		</c:otherwise>
	</c:choose>
	</c:otherwise>
	</c:choose>
	</div>
	</header>
	</c:when>
	
	<c:when test="${doc_title eq ProjectDto.TYPE_REWARD}">
	<header id="line_header">
	<div class="container text-center">
	<!-- <h1 class="head_title">SEARCH</h1> -->
	<p>리워드</p>
	<c:choose>
	<c:when test="${ !empty s_keyword or s_keyword ne ''}">
		<c:choose>
		<c:when test="${empty more_s_keyword or more_s_keyword eq ''}">
			<h5 style="font-family: 'Allura';">"${s_keyword }" 의 검색 결과 ${totalRecordCount } 건</h5>
		</c:when>
		<c:when test="${!empty more_s_keyword or more_s_keyword ne ''}">
			<h5 style="font-family: 'Allura';">"${s_keyword }" 의 검색 결과 중, "${more_s_keyword }" 결과 내 검색 ${totalRecordCount } 건</h5>
		</c:when>
		<c:otherwise>
		
		</c:otherwise>
		</c:choose>
	</c:when>
	<c:otherwise>
	<c:choose>
		<c:when test="${empty more_s_keyword or more_s_keyword eq ''}">
		<h5 style="font-family: 'Allura';">총 ${totalRecordCount } 건</h5>
		</c:when>
		<c:when test="${!empty more_s_keyword or more_s_keyword ne ''}">
			<h5 style="font-family: 'Allura';">"${more_s_keyword }" 결과 내 검색 ${totalRecordCount } 건</h5>
		</c:when>
		<c:otherwise>
		
		</c:otherwise>
	</c:choose>
	</c:otherwise>
	</c:choose>
	</div>
	</header>
	</c:when>
	
	<c:when test="${doc_title eq 'rewardFood'}">
	<header id="line_header">
	<div class="container text-center">
	<!-- <h1 class="head_title">SEARCH</h1> -->
	<p>리워드 - 음식 프로젝트</p>
	<c:choose>
	<c:when test="${ !empty s_keyword or s_keyword ne ''}">
		<c:choose>
		<c:when test="${empty more_s_keyword or more_s_keyword eq ''}">
			<h5 style="font-family: 'Allura';">"${s_keyword }" 의 검색 결과 ${totalRecordCount } 건</h5>
		</c:when>
		<c:when test="${!empty more_s_keyword or more_s_keyword ne ''}">
			<h5 style="font-family: 'Allura';">"${s_keyword }" 의 검색 결과 중, "${more_s_keyword }" 결과 내 검색 ${totalRecordCount } 건</h5>
		</c:when>
		<c:otherwise>
		
		</c:otherwise>
		</c:choose>
	</c:when>
	<c:otherwise>
	<c:choose>
		<c:when test="${empty more_s_keyword or more_s_keyword eq ''}">
		<h5 style="font-family: 'Allura';">총 ${totalRecordCount } 건</h5>
		</c:when>
		<c:when test="${!empty more_s_keyword or more_s_keyword ne ''}">
			<h5 style="font-family: 'Allura';">"${more_s_keyword }" 결과 내 검색 ${totalRecordCount } 건</h5>
		</c:when>
		<c:otherwise>
		
		</c:otherwise>
	</c:choose>
	</c:otherwise>
	</c:choose>
	</div>
	</header>
	</c:when>
	
	<c:when test="${doc_title eq 'rewardIt'}">
	<header id="line_header">
	<div class="container text-center">
	<!-- <h1 class="head_title">SEARCH</h1> -->
	<p>리워드 - IT / 생활 프로젝트</p>
	<c:choose>
	<c:when test="${ !empty s_keyword or s_keyword ne ''}">
		<c:choose>
		<c:when test="${empty more_s_keyword or more_s_keyword eq ''}">
			<h5 style="font-family: 'Allura';">"${s_keyword }" 의 검색 결과 ${totalRecordCount } 건</h5>
		</c:when>
		<c:when test="${!empty more_s_keyword or more_s_keyword ne ''}">
			<h5 style="font-family: 'Allura';">"${s_keyword }" 의 검색 결과 중, "${more_s_keyword }" 결과 내 검색 ${totalRecordCount } 건</h5>
		</c:when>
		<c:otherwise>
		
		</c:otherwise>
		</c:choose>
	</c:when>
	<c:otherwise>
	<c:choose>
		<c:when test="${empty more_s_keyword or more_s_keyword eq ''}">
		<h5 style="font-family: 'Allura';">총 ${totalRecordCount } 건</h5>
		</c:when>
		<c:when test="${!empty more_s_keyword or more_s_keyword ne ''}">
			<h5 style="font-family: 'Allura';">"${more_s_keyword }" 결과 내 검색 ${totalRecordCount } 건</h5>
		</c:when>
		<c:otherwise>
		
		</c:otherwise>
	</c:choose>
	</c:otherwise>
	</c:choose>
	</div>
	</header>
	</c:when>
	
	<c:when test="${doc_title eq 'rewardAnimal'}">
	<header id="line_header">
	<div class="container text-center">
	<!-- <h1 class="head_title">SEARCH</h1> -->
	<p>리워드 - 동물 프로젝트</p>
	<c:choose>
	<c:when test="${ !empty s_keyword or s_keyword ne ''}">
		<c:choose>
		<c:when test="${empty more_s_keyword or more_s_keyword eq ''}">
			<h5 style="font-family: 'Allura';">"${s_keyword }" 의 검색 결과 ${totalRecordCount } 건</h5>
		</c:when>
		<c:when test="${!empty more_s_keyword or more_s_keyword ne ''}">
			<h5 style="font-family: 'Allura';">"${s_keyword }" 의 검색 결과 중, "${more_s_keyword }" 결과 내 검색 ${totalRecordCount } 건</h5>
		</c:when>
		<c:otherwise>
		
		</c:otherwise>
		</c:choose>
	</c:when>
	<c:otherwise>
	<c:choose>
		<c:when test="${empty more_s_keyword or more_s_keyword eq ''}">
		<h5 style="font-family: 'Allura';">총 ${totalRecordCount } 건</h5>
		</c:when>
		<c:when test="${!empty more_s_keyword or more_s_keyword ne ''}">
			<h5 style="font-family: 'Allura';">"${more_s_keyword }" 결과 내 검색 ${totalRecordCount } 건</h5>
		</c:when>
		<c:otherwise>
		
		</c:otherwise>
	</c:choose>
	</c:otherwise>
	</c:choose>
	</div>
	</header>
	</c:when>
	
</c:choose>
</div>

<div align="right" style="margin-right: 15%;">
	<input type="text" placeholder=" 결과 내 검색" name="more_s_keyword" class="field" value="${more_s_keyword }" id="more_search"
	onkeypress="var iffocus = $(this).is(':focus');if(iffocus){if(event.keyCode==13) {more_search_Enter(); return false;}} else{}">
</div>

<div class="container" style="margin-bottom: 3%;">
<div class="row">
<div class="tab">
    <ul class="tab"> <!-- post로 보내고 싶은데.. 이런저런 시도 후 원상복구 -->
     <li data-tab="tab1" id="tab1"><a href="searchProjectList.do?s_type=${s_type}&s_category=${s_category}&s_keyword=${s_keyword}&s_complete=${s_complete}&s_condition=${s_condition}&doc_title=${doc_title}&more_s_keyword=${more_s_keyword}&s_sort=fundachivedDESC">모금액 많은 순</a></li>
     <li data-tab="tab2" id="tab2"><a href="searchProjectList.do?s_type=${s_type}&s_category=${s_category}&s_keyword=${s_keyword}&s_complete=${s_complete}&s_condition=${s_condition}&doc_title=${doc_title}&more_s_keyword=${more_s_keyword}&s_sort=buycountDESC">참여 많은 순</a></li>
     <li data-tab="tab3" id="tab3"><a href="searchProjectList.do?s_type=${s_type}&s_category=${s_category}&s_keyword=${s_keyword}&s_complete=${s_complete}&s_condition=${s_condition}&doc_title=${doc_title}&more_s_keyword=${more_s_keyword}&s_sort=edateASC">곧 끝나는 순</a></li>
     <li data-tab="tab4" id="tab4"><a href="searchProjectList.do?s_type=${s_type}&s_category=${s_category}&s_keyword=${s_keyword}&s_complete=${s_complete}&s_condition=${s_condition}&doc_title=${doc_title}&more_s_keyword=${more_s_keyword}&s_sort=regdateDESC">최신 등록된 순</a></li>
    </ul>
</div>
</div>

</div>
</div>
<div class="container" style="margin-bottom: 3%;">
<div class="row">
<!-- list jsp:include로 보내려면 이렇게 설정해서 보내주면 된다.-->
<c:set var="list" value="${list }" scope="request"/>

<jsp:include page="/WEB-INF/views/project/project_list.jsp" flush="false">
	<jsp:param value="${pageNumber }" name="pageNumber"/>
	<jsp:param value="${pageCountPerScreen }" name="pageCountPerScreen"/>
	<jsp:param value="${recordCountPerPage }" name="recordCountPerPage"/>
	<jsp:param value="${totalRecordCount }" name="totalRecordCount"/>
	
	<jsp:param value="${s_type }" name="s_type"/>
	<jsp:param value="${s_category }" name="s_category"/>
	<jsp:param value="${s_keyword }" name="s_keyword"/>
	<jsp:param value="${s_summary }" name="s_summary"/>
	<jsp:param value="${s_asc_desc }" name="s_asc_desc"/>
	
	<jsp:param value="${list }" name="list"/>
</jsp:include>

</div>
</div>

<!-- 페이징 처리 -->     
<div id="pagination__wrapper" align="center"><!-- flush 는 갱신의 의미 -->
	<jsp:include page="/WEB-INF/views/common/paging.jsp" flush="false">	
		<jsp:param value="${s_keyword }" name="s_keyword"/>	
		<jsp:param value="${pageNumber }" name="pageNumber"/>
		<jsp:param value="${pageCountPerScreen }" name="pageCountPerScreen"/>
		<jsp:param value="${recordCountPerPage }" name="recordCountPerPage"/>
		<jsp:param value="${totalRecordCount }" name="totalRecordCount"/>
		<jsp:param value="searchProjectList.do" name="actionPath"/>
	</jsp:include>
</div>


<script>
// 탭 누를 시 클래스 적용
$(document).ready(function() {
	var current_sort = '${s_sort}';
	
	if(current_sort == null){
		
	} else if(current_sort == 'fundachivedDESC'){
		$('#tab1').addClass('current');
	} else if(current_sort == 'buycountDESC'){
		$('#tab2').addClass('current');
	} else if(current_sort == 'edateASC'){
		$('#tab3').addClass('current');
	} else if(current_sort == 'regdateDESC'){
		$('#tab4').addClass('current');
	}
	
	
	$('ul.tab li').click(function() {
		var activeTab = $(this).attr('data-tab');
		$('ul.tab li').removeClass('current');
		/* $('.tabcontent').removeClass('current'); */
		$(this).addClass('current');
		$('#' + activeTab).addClass('current');
	});
});

	/* 결과 내 검색 */
function more_search_Enter() {
	/* alert("more_search_Enter"); */
	$("#_pageNumber").val(0);
	$("#more_search").val($("#more_search").val());
	$("#_more_s_keyword").val($("#more_search").val());
	$("#_frmFormSearch").attr({"action":"searchProjectList.do", "method":"post"}).submit();
}
</script>
