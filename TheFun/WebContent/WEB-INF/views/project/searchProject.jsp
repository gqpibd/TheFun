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
</style>

<!-- 차트 css -->
<link rel="stylesheet" href="https://cdn.rawgit.com/theus/chart.css/v1.0.0/dist/chart.css" />

<!-- 몇 건인지 표시하려고 -->
<div class="container">
<h5>${totalRecordCount } 건</h5>
<div class="row">
<div class="tab">
    <ul class="tab">
     <li data-tab="tab1" ><a href="searchProjectList.do?s_type=${s_type }&s_category=${s_category }&s_keyword=${s_keyword}&s_sort=buycountDESC">참여순</a></li>
     <li data-tab="tab2" ><a href="searchProjectList.do?s_type=${s_type }&s_category=${s_category }&s_keyword=${s_keyword}&s_sort=fundachivedDESC">모금액순</a></li>
     <li data-tab="tab2" ><a href="searchProjectList.do?s_type=${s_type }&s_category=${s_category }&s_keyword=${s_keyword}&s_sort=sdateDESC">최신순</a></li>
    </ul>
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
	
	<jsp:param value="${list }" name="list"/>
</jsp:include>

<!-- 페이징 처리 -->
<div id="paging_wrap"><!-- flush 는 갱신의 의미 -->
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

