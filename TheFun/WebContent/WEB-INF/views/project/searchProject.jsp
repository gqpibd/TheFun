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
	
	<c:when test="${doc_title eq 'sdateDESC'}">
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



<%-- 
MyBatis에 foreach 써서 list가 들어가는 줄을 몰랐네 바보다
<!-- 검색 조건	 -->
<div align="center" style="margin-bottom: 30px;margin-top: 30px;">
<form action="searchProjectList.do" > <!-- post로 바꿀 예정 -->
	<input type="hidden" id="s_keyword_hidden" name="s_keyword" value="${s_keyword }">
	<table style="width: 50%;" cellpadding="5px" id="search_option">
	<col width="15%"><col width="10%"><col width="10%;"><col width="10%;">
	<tr id="type_option">
	<th>대분류<input type="hidden" id="s_type_hidden" name="s_type" value=""><!-- 정리하기 위한 hidden --></th>
	<td><input type="checkbox" name="s_type_before" value="${ProjectDto.TYPE_DONATION}"><span>&nbsp;기부</span></td>
	<td><input type="checkbox" name="s_type_before" value="${ProjectDto.TYPE_REWARD}"><span>&nbsp;리워드</span></td>
	<td></td> 
	</tr>
	
	<tr id="reward_category">
	<th>리워드-카테고리<input type="hidden" id="s_category_hidden" name="s_category" value=""><!-- 정리하기 위한 hidden --></th>
	<td><input type="checkbox" name="s_category_before" value="${ProjectDto.CATEGORY_FOOD}"><span>&nbsp;음식</span></td>
	<td><input type="checkbox" name="s_category_before" value="${ProjectDto.CATEGORY_IT}"><span>&nbsp;IT/생활</span></td>
	<td><input type="checkbox" name="s_category_before" value="${ProjectDto.CATEGORY_ANIMAL}"><span>&nbsp;동물</span></td>
	</tr>
	
	<tr id="donation_category">
	<th>기부-카테고리<input type="hidden" id="s_category_hidden" name="s_category" value=""><!-- 정리하기 위한 hidden --></th>
	<td><input type="checkbox" name="s_category_before" value="${ProjectDto.CATEGORY_HUMAN}"><span>&nbsp;인권</span></td>
	<td><input type="checkbox" name="s_category_before" value="${ProjectDto.CATEGORY_ANIMAL}"><span>&nbsp;동물</span></td>
	<td></td>
	</tr>
	
	<tr>
	<th>프로젝트 진행 상태<input type="hidden" id="s_complete_hidden" name="s_complete" value=""><!-- 정리하기 위한 hidden --></th>
	<td>
		<input type="checkbox" name="s_complete_before" value="${ProjectDto.COMPLETE_SUCCESS}"><span>&nbsp;종료</span>
		<input type="hidden" name="s_complete_before" value="${ProjectDto.COMPLETE_FAIL}">
	</td>
	<td>
		<input type="checkbox" name="s_complete_before" value="${ProjectDto.ONGOING}"><span>&nbsp;진행 / 준비 중</span>
		<input type="hidden" name="s_complete_before" value="${ProjectDto.PREPARING}">
	</td>
	<td><input type="submit" value="제출"></td>
	</tr>
	
	</table>
	
</form>
</div>
 --%>
 
 
<%-- 
<script>
$(document).ready(function () {
	
	/* 검색 조건 걸러내서 담을 변수 */
	/*
	var s_type_after = "";
	var s_category_after = "";
	var s_complete_after = "";
	*/
	
	/* 배열 과 그 사이즈 */
	var s_type_before = document.getElementsByName("s_type_before");
	var s_type_before_size = document.getElementsByName("s_type_before").length;
	
	var s_category_before = document.getElementsByName("s_category_before");
	var s_category_before_size = document.getElementsByName("s_category_before").length;
	
	var s_complete_before = document.getElementsByName("s_complete_before");
	var s_complete_before_size = document.getElementsByName("s_complete_before").length;
	
	//////////////////////////////////
	/* 하드 코딩하기 싫은데 생각이 떠오르질 않아요 */
	/* s_type 정리 */
	for (i = 0; i < s_type_before_size ; i++) {
		
		/* .indexOf(String) : 배열에 값 없으면 -1 반환 /있으면 그 배열의 인덱스 숫자 반환 */
		/* 리워드가 있을시 */
		if(s_type_before[i].value.indexOf("<%=ProjectDto.TYPE_REWARD%>") != -1){ 
			alert(s_type_before[i].value.indexOf("<%=ProjectDto.TYPE_REWARD%>"));
			/* 리워드와 기부가 모두 있을 시 */
			if(s_type_before[i].value.indexOf("<%=ProjectDto.TYPE_DONATION%>") != -1){
				$("#s_type_hidden").val("");	// 공백이 모두 있다는 의미
			}
			/* 리워드는 있는데 기부가 없을 때 */
			else{
				$("#s_type_hidden").val("<%=ProjectDto.TYPE_REWARD%>");
			}
		}
		/* 기부가 있을 시 */
		else if(s_type_before[i].value.indexOf("<%=ProjectDto.TYPE_DONATION%>") != -1){
			/* 기부와 리워드 모두 있을 시 */
			if(s_type_before[i].value.indexOf("<%=ProjectDto.TYPE_REWARD%>") != -1){
				$("#s_type_hidden").val("");	// 공백이 모두 있다는 의미
			}
			/* 기부는 있는데 리워드가 없을 때 */
			else{
				$("#s_type_hidden").val("<%=ProjectDto.TYPE_DONATION%>");
			}
		}
	}
	
	//////////////////////////////////
	
	/* 하드 코딩하기 싫은데 생각이 떠오르질 않아요 */
	/* s_category 정리 */
	for (i = 0; i < s_cavtegory_before_size ; i++) {
		
		/* .indexOf(String) : 배열에 값 없으면 -1 반환 /있으면 그 배열의 인덱스 숫자 반환 */
		/* 음식이 있을시 */
		if(s_category_before[i].value.indexOf("<%=ProjectDto.CATEGORY_FOOD%>") != -1){ 
			alert(s_type_before[i].value.indexOf("<%=ProjectDto.TYPE_REWARD%>"));
			/* 음식과 it가 있을 시 */
			if(s_category_before[i].value.indexOf("<%=ProjectDto.CATEGORY_IT%>") != -1){
				/* 음식과 it와 동물이 모두 있을 시 */
				if(s_category_before[i].value.indexOf("<%=ProjectDto.CATEGORY_ANIMAL%>") != -1){
					$("#s_category_hidden").val("");	// 공백이 모두 있다는 의미
				}
				/* 음식과 it는 있는데 동물이 없을 시 */
				else{
					$("#s_category_hidden").val("only_no_animal");
				}
			}
			/* 는 있는데 가 없을 때 */
			else{
				$("#s_type_hidden").val("<%=ProjectDto.TYPE_REWARD%>");
			}
		}
		/* 음식이 없고 it가 있을 시 */
		else if(s_category_before[i].value.indexOf("<%=ProjectDto.TYPE_DONATION%>") != -1){
			/* 기부와 리워드 모두 있을 시 */
			if(s_category_before[i].value.indexOf("<%=ProjectDto.TYPE_REWARD%>") != -1){
				/* $("#s_type_hidden").val("");	// 공백이 모두 있다는 의미 */
			}
			/* 기부는 있는데 리워드가 없을 때 */
			else{
				$("#s_category_hidden").val("<%=ProjectDto.TYPE_DONATION%>");
			}
		}
	}
	
	
	var typeVal = '${s_type}';
	var categoryVal = '${s_category}';
	var completeVal = '${s_complete}';
	
	/* alert("typeVal : " + typeVal + " categoryVal : " + categoryVal + " completeVal : " + completeVal); */
	
	/* 체크 초기설정 */
	/* 타입 */
	if(typeVal == ""){
		$("input[name='s_type_before']").prop("checked", true);
	} else if($("input[value='<%=ProjectDto.TYPE_REWARD%>']").val() == typeVal){
		$("input[value='<%=ProjectDto.TYPE_REWARD%>']").prop("checked", true);
		$("#donation_category").css("display", "none");
	} else if($("input[value='<%=ProjectDto.TYPE_DONATION%>']").val() == typeVal){
		$("input[value='<%=ProjectDto.TYPE_DONATION%>']").prop("checked", true);
		$("#reward_category").css("display", "none");
	}
	
	/* 체크 초기설정 */
	/* 카테고리 */
	if(categoryVal == ""){
		$("input[name='s_category_before']").prop("checked", true);
	} else if($("input[value='<%=ProjectDto.CATEGORY_FOOD%>']").val() == categoryVal){
		$("input[value='<%=ProjectDto.CATEGORY_FOOD%>']").prop("checked", true);
	} else if($("input[value='<%=ProjectDto.CATEGORY_IT%>']").val() == categoryVal){
		$("input[value='<%=ProjectDto.CATEGORY_IT%>']").prop("checked", true);
	} else if($("input[value='<%=ProjectDto.CATEGORY_ANIMAL%>']").val() == categoryVal){
		$("input[value='<%=ProjectDto.CATEGORY_ANIMAL%>']").prop("checked", true);
	} else if($("input[value='<%=ProjectDto.CATEGORY_HUMAN%>']").val() == categoryVal){
		$("input[value='<%=ProjectDto.CATEGORY_HUMAN%>']").prop("checked", true);
	}
	
	/* 체크 초기설정 */
	/* 완료 여부 */
	if('complete' == completeVal){
		$("input[value='s_complete_before']").prop("checked", true);
	} else {
		$("input[value='<%=ProjectDto.ONGOING%>']").prop("checked", true);
	}
	
	
	/* 체크에 따른 기능 */
	$(document).on("click", "#search_option input:checkbox", function () {
		/* 체크 시 */
		if($(this).is(":checked")){
			if($(this).val() == $("input[value='<%=ProjectDto.TYPE_REWARD%>']").val()){
				/* 보이게 */
				$("#reward_category").css("display", "");
			} else if($(this).val() == $("input[value='<%=ProjectDto.TYPE_DONATION%>']").val()){
				/* 보이게 */
				$("#donation_category").css("display", "");
			}
			
			/* 동물끼리는 같은 묶음 - 보이게 */
			if($(this).val() == $("input[value='<%=ProjectDto.CATEGORY_ANIMAL%>']").val()) {
				$("input[value='<%=ProjectDto.CATEGORY_ANIMAL%>']").prop("checked", true);
			}
		}
		
		/* 체크 해제 시 */
		else{ 
			if($(this).val() == $("input[value='<%=ProjectDto.TYPE_REWARD%>']").val()){
				/* 안 보이게 */
				$("#reward_category").css("display", "none");
			} else if($(this).val() == $("input[value='<%=ProjectDto.TYPE_DONATION%>']").val()){
				/* 안 보이게 */
				$("#donation_category").css("display", "none");
			}
			
			/* 동물끼리는 같은 묶음 - 안 보이게 */
			if($(this).val() == $("input[value='<%=ProjectDto.CATEGORY_ANIMAL%>']").val()) {
				$("input[value='<%=ProjectDto.CATEGORY_ANIMAL%>']").prop("checked", false);
			}
        }
	});
	
});
</script>
--%>

<div class="container" style="margin-bottom: 3%;">
<div class="row">
<div class="tab">
    <ul class="tab"> <!-- post로 보내고 싶은데.. 이런저런 시도 후 원상복구 -->
     <li data-tab="tab1" id="tab1"><a href="searchProjectList.do?s_type=${s_type}&s_category=${s_category}&s_keyword=${s_keyword}&s_complete=${s_complete}&s_condition=${s_condition}&doc_title=${doc_title}&more_s_keyword=${more_s_keyword}&s_sort=buycountDESC">참여 많은 순</a></li>
     <li data-tab="tab2" id="tab2"><a href="searchProjectList.do?s_type=${s_type}&s_category=${s_category}&s_keyword=${s_keyword}&s_complete=${s_complete}&s_condition=${s_condition}&doc_title=${doc_title}&more_s_keyword=${more_s_keyword}&s_sort=fundachivedDESC">모금액 많은 순</a></li>
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
		
	} else if(current_sort == 'buycountDESC'){
		$('#tab1').addClass('current');
	} else if(current_sort == 'fundachivedDESC'){
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
