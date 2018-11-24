<%@page import="donzo.thefun.model.ProjectDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:requestEncoding value="utf-8"/>   

<!-- 차트 css -->
<link rel="stylesheet" href="https://cdn.rawgit.com/theus/chart.css/v1.0.0/dist/chart.css" />
 
 <style type="text/css">
 .pTitle{
 	font-weight: bold;
 	color: black;
 	font-size: large;
 }
 .pName{
 	color: gray;
 	font-size: small;
 }
 </style>
 
<div class="container">
	<!-- 메인 사진 -->
	 <div class="row" align="center">
	   <div align="center">
	     <img class="img-fluid" src="image/main/mainImg1.PNG">
	   </div>
	 </div>
	 <!-- /.row -->
	    
	<!-- 카테고리 -->
	<div align="center">
	<table style="text-align: center;" border="1">
	<col width="150px"><col width="150px"><col width="150px"><col width="150px">
	<tr>
	<td><a href="searchProjectList.do?s_type=<%=ProjectDto.TYPE_REWARD%>&s_keyward=<%=ProjectDto.TYPE_REWARD%>" onclick="search_Enter()">리워드 전체</a></td>
	<td><a href="searchProjectList.do?s_type=<%=ProjectDto.TYPE_REWARD%>&s_category=<%=ProjectDto.CATEGORY_FOOD%>&s_keyward=<%=ProjectDto.CATEGORY_FOOD%>"  onclick="search_Enter()">음식</a></td>
	<td><a href="searchProjectList.do?s_type=<%=ProjectDto.TYPE_REWARD%>&s_category=<%=ProjectDto.CATEGORY_IT%>&s_keyward=<%=ProjectDto.CATEGORY_IT%>"  onclick="search_Enter()">IT</a></td>
	<td><a href="searchProjectList.do?s_type=<%=ProjectDto.TYPE_REWARD%>&s_category=<%=ProjectDto.CATEGORY_ANIMAL%>&s_keyward=<%=ProjectDto.CATEGORY_ANIMAL%>"  onclick="search_Enter()">동물-리워드</a></td>
	</tr>
	<tr>
	<td style="text-align: center;" colspan="4">
		<table border="1">
		<col width="150px"><col width="150px"><col width="150px">
		<tr>
		<td><a href="searchProjectList.do?s_type=<%=ProjectDto.TYPE_DONATION%>&s_keyward=<%=ProjectDto.TYPE_DONATION%>" onclick="search_Enter()">기부 전체</a></td>
		<td><a href="searchProjectList.do?s_type=<%=ProjectDto.TYPE_DONATION%>&s_category=<%=ProjectDto.CATEGORY_HUMAN%>&s_keyward=<%=ProjectDto.CATEGORY_HUMAN%>" onclick="search_Enter()">인권</a></td>
		<td><a href="searchProjectList.do?s_type=<%=ProjectDto.TYPE_DONATION%>&s_category=<%=ProjectDto.CATEGORY_ANIMAL%>&s_keyward=<%=ProjectDto.CATEGORY_ANIMAL%>" onclick="search_Enter()">동물-기부</a></td>
		</tr>
		</table>
	</td>
	</tr>
	</table>
	</div>
	<div style="margin-bottom: 100px;"></div>
	
	<!-- 리스트 -->
	<h3 class="my-4">HOT 프로젝트(구매많은순-모금액순)</h3>
	
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
</jsp:include>

</body>
</html>