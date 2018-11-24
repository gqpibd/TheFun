<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<fmt:requestEncoding value="utf-8"/>   
<!-- 차트 css -->
<link rel="stylesheet" href="https://cdn.rawgit.com/theus/chart.css/v1.0.0/dist/chart.css" />

<!-- 몇 건인지 표시하려고 -->
<div class="container">
<div class="row">
<p>${totalRecordCount } 건</p>
</div>
</div>

<!-- list jsp:include로 보내려면 이렇게 설정해서 보내주면 된다.-->
<c:set var="list" value="${list }" scope="request"/>
<%-- <p>pageNumber : ${pageNumber } , pageCountPerScreen : ${pageCountPerScreen }, recordCountPerPage : ${recordCountPerPage }, totalRecordCount : ${totalRecordCount }</p> --%>

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
		<jsp:param value="${pageNumber }" name="pageNumber"/>
		<jsp:param value="${pageCountPerScreen }" name="pageCountPerScreen"/>
		<jsp:param value="${recordCountPerPage }" name="recordCountPerPage"/>
		<jsp:param value="${totalRecordCount }" name="totalRecordCount"/>
	</jsp:include>
</div>

