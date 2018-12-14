<%@page import="donzo.thefun.model.ProjectDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<fmt:requestEncoding value="utf-8"/>   

<!-- 차트 css -->
<link rel="stylesheet" href="https://cdn.rawgit.com/theus/chart.css/v1.0.0/dist/chart.css" />

<!-- 메인 css -->
<!-- <link rel="stylesheet" href="CSS/common/main.css">  -->
<style>
 
.main_container h1 {
  font-size: 48px;
  font-weight: 300;
  margin: 0 0 .1em;
}

.main_container p {
  margin: 0;
}

.main_carousel {
	justify-content: flex-start;
	overflow: hidden;
  	padding: 40px 0;
	position: relative;
	width: 100vw;
}

.carousel > .main_container {
	display: flex;
	flex-direction: row;
	height: 100%;
	transform: translate3d(0, 0, 0);
	transition: transform 600ms;
}

.carousel > nav {
	bottom: 0;
	left: 0;
	position: absolute;
	text-align: center;
	width: 100%;
	z-index: 1;
}

.carousel > nav a {
	color: #000;
	font-size: 14px;
	opacity: .2;
	text-decoration: none;
}

.carousel > nav a:hover {
	opacity: .5;
}

.carousel > nav a.current {
	opacity: 1;
}

.carousel .slide {
	flex-shrink: 0;
	line-height: 1.4;
	text-align: center;
	width: 100vw;
}
.no-drag{
	-ms-user-select: none;
	-moz-user-select: -moz-none;
	-webkit-user-select: none;
	-khtml-user-select: none;
	user-select:none;
}
 </style>
 
<!-- <div class="container" style="margin-top: 3%;">	  -->
	<!-- 메인 배너 슬라이드 -->
	<div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel" style="width:100%;height:400px;object-fit: cover;overflow:hidden; user-select: none;">
	  <ol class="carousel-indicators" style="z-index: 4;">
	    <li data-target="#carouselExampleIndicators" data-slide-to="0" class="active"></li>
	    <li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
	    <li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
	    <li data-target="#carouselExampleIndicators" data-slide-to="3"></li>
	    <li data-target="#carouselExampleIndicators" data-slide-to="4"></li>
	    <li data-target="#carouselExampleIndicators" data-slide-to="5"></li>
	  </ol>
	  <div class="carousel-inner">
	    <div class="carousel-item active">
	      <img class="d-block w-100" src="image/banner/메인1.png" alt="첫번째 슬라이드" onclick="location.href='projectDetail.do?seq=161'">
	    </div>
	    <div class="carousel-item">
	      <img class="d-block w-100" src="image/banner/메인2.png" alt="두번째 슬라이드" onclick="location.href='projectDetail.do?seq=162'">
	    </div>
	    <div class="carousel-item">
	      <img class="d-block w-100" src="image/banner/메인3.png" alt="세번째 슬라이드" onclick="location.href='projectDetail.do?seq=163'">
	    </div>
	     <div class="carousel-item">
	      <img class="d-block w-100" src="image/banner/메인4.png" alt="네번째 슬라이드" onclick="location.href='projectDetail.do?seq=165'">
	    </div>
	    <div class="carousel-item">
	      <img class="d-block w-100" src="image/banner/메인5.png" alt="다섯번째 슬라이드" onclick="location.href='projectDetail.do?seq=166'">
	    </div>
	    <div class="carousel-item">
	      <img class="d-block w-100" src="image/banner/메인6.png" alt="여섯번째 슬라이드" onclick="location.href='projectDetail.do?seq=167'">
	    </div>
	  </div>
	  <a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev">
	    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
	    <span class="sr-only">이전</span>
	  </a>
	  <a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next">
	    <span class="carousel-control-next-icon" aria-hidden="true"></span>
	    <span class="sr-only">다음</span>
	  </a>
	</div>

<!-- </div> -->
	 <!-- /.row -->	
	<div style="margin-bottom: 10px;"></div>
	
<div class="container" style="margin-top: 3%;">	
	<!-- 리스트 -->
	<h3 class="my-4">HOT 프로젝트</h3>
	<div align="right"><a href="searchProjectList.do">see all</a></div>
</div>

<!-- list jsp:include로 보내려면 이렇게 -->
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
	
	<jsp:param value="${list }" name="list"/>
	<jsp:param value="main.do" name="actionPath"/>
</jsp:include>

<br>

<div class="container">
	<!-- 리스트 -->
	
	<h3 class="my-4">곧 마감되는 프로젝트</h3>
	<div align="right"><a href="searchProjectList.do?s_sort=edateASC">see all</a></div>

<!-- list jsp:include로 보내려면 이렇게 -->
<c:set var="list" value="${edate_list }" scope="request"/>

<jsp:include page="/WEB-INF/views/project/project_list.jsp" flush="false">
	<jsp:param value="${edate_pageNumber }" name="pageNumber"/>
	<jsp:param value="${edate_pageCountPerScreen }" name="pageCountPerScreen"/>
	<jsp:param value="${edate_recordCountPerPage }" name="recordCountPerPage"/>
	<jsp:param value="${edate_totalRecordCount }" name="totalRecordCount"/>

	<jsp:param value="${edate_s_type }" name="s_type"/>
	<jsp:param value="${edate_s_category }" name="s_category"/>
	<jsp:param value="${edate_s_keyword }" name="s_keyword"/>
	<jsp:param value="${edate_s_summary }" name="s_summary"/>

	<jsp:param value="${edate_list }" name="list"/>
</jsp:include>

</div>
<script type="text/javascript">
/* 배너이미지 시간차 변경코드 */
var startImage = $('section.awSlider .item.active > img').attr('src');
$('section.awSlider').append('<img src="' + startImage + '">');
$('section.awSlider .carousel').on('slid.bs.carousel', function () {
 var bscn = $(this).find('.item.active > img').attr('src');
	$('section.awSlider > img').attr('src',bscn);
});

</script>