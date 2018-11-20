<%@page import="donzo.thefun.model.ProjectDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:requestEncoding value="utf-8"/>   

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>The Fun_더 아름다운 세상을 위한 펀딩</title>
</head>
<body>
<%

%>
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
	<table style="text-align: center;">
	<col width="200px"><col width="200px"><col width="200px"><col width="200px">
	<tr>
	<td><a href="#">리워드 전체</a></td>
	<td><a href="#">음식</a></td>
	<td><a href="#">IT</a></td>
	<td><a href="#">동물</a></td>
	</tr>
	</table>
	</div>
	<div style="margin-bottom: 100px;"></div>
	
	<!-- 리스트 -->
	<h3 class="my-4">HOT 프로젝트</h3>
	
	<c:forEach items="${hotList}" var="attribute" varStatus="status">	<!-- 리스트(object)를 jsp:param 으로 보낼 때  -->
	<c:set var="attribute" value="${attribute}" scope="request"/>
	
	<table border="1">
	<tr>
	<td>
	<jsp:include page="../project/project_list.jsp">
		<jsp:param name="attribute" value="${attribute}" />
	</jsp:include>
	
	<td>
	</tr>
	</table>
	</c:forEach>

</div>

</body>
</html>