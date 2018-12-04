<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

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
	padding: 14px 16px;
	font-size: 17px;
	transition:0.3s;
}
/* Style the tab content */
.tabcontent {
	display: none;
	background-color:rgb(0,154,200);
	padding: 5px 10px;
	color:#fff;
}
ul.tab li.current{
	background-color: rgb(129,082,240);
	selected:selected;
	color: #222;
}
ul.tab li.selected{
	background-color: rgb(129,082,240);
	color: #222;
	
}
.tabcontent.current {
	display: block;
}

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


<div style="background: #fff;padding-top: -3%;padding-bottom: 3%;">
<c:choose>
	<c:when test="${doc_title eq 'complete'}">
	<header id="line_header">
	<div class="container text-center">
	<!-- <h1 class="head_title">HISTORY</h1> -->
	<p>종료된 프로젝트</p>
	<%-- <h5 style="font-family: 'Allura';">${totalRecordCount } 건</h5> --%>
	</div>
	</header>
	</c:when>
	
	<c:when test="${doc_title eq 'search'}">
	<header id="line_header">
	<div class="container text-center">
	<!-- <h1 class="head_title">SEARCH</h1> -->
	<%-- <p> "${s_keyword }" 의 검색 결과</p> --%>
	<%-- <h5 style="font-family: 'Allura';">${totalRecordCount } 건</h5> --%>
	</div>
	</header>
	</c:when>
</c:choose>
</div>

<div class="container">
${totalRecordCount } 건
<div class="row">
<div class="tab">
    <ul class="tab">
     <li data-tab="tab1" ><a href="searchProjectList.do?s_type=${s_type }&s_category=${s_category }&s_keyword=${s_keyword}&s_complete=${s_complete}&s_sort=buycountDESC">참여 순</a></li>
     <li data-tab="tab2" ><a href="searchProjectList.do?s_type=${s_type }&s_category=${s_category }&s_keyword=${s_keyword}&s_complete=${s_complete}&s_sort=fundachivedDESC">모금순</a></li>
     <li data-tab="tab3" ><a href="searchProjectList.do?s_type=${s_type }&s_category=${s_category }&s_keyword=${s_keyword}&s_complete=${s_complete}&s_sort=edateASC">마감 순</a></li>
    </ul>
</div>
</div>

</div>
</div>

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
<br>
<!-- 페이징 처리 -->     
<div id="paging_wrap" align="center"><!-- flush 는 갱신의 의미 -->
	<jsp:include page="/WEB-INF/views/common/paging.jsp" flush="false">
	
		<jsp:param value="${s_keyword }" name="s_keyword"/>
	
		<jsp:param value="${pageNumber }" name="pageNumber"/>
		<jsp:param value="${pageCountPerScreen }" name="pageCountPerScreen"/>
		<jsp:param value="${recordCountPerPage }" name="recordCountPerPage"/>
		<jsp:param value="${totalRecordCount }" name="totalRecordCount"/>
	</jsp:include>
</div>

<script>
// 탭 누를 시 클래스 적용
$(function() {
	$('ul.tab li').click(function() {
		var activeTab = $(this).attr('data-tab');
		$('ul.tab li').removeClass('current');
		$('.tabcontent').removeClass('current');
		$(this).addClass('current');
		$('#' + activeTab).addClass('current');
	});
});
</script>

