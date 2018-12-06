<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:requestEncoding value="utf-8"/>    <!-- request.setCharacterEncoding("utf-8"); 이것과 동일 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>더펀:더 나은 세상을 위한 펀딩</title>
<tiles:insertAttribute name="header"/> <!-- views/common파일 위치에 header.jsp 생성 -->

</head>
<body>

<!-- 탑바 -->
<div>	<!-- 로고 검색 로그인 회원가입 -->
	<tiles:insertAttribute name="topbar" /> 
</div>

<!-- 메인 -->
<div style="display: grid"> <!-- 메인뷰 디테일 뉴프로젝트 -->
	<tiles:insertAttribute name="tabs"/>		
	<tiles:insertAttribute name="main"/>		
</div>

<div style="margin-top: 80px;"></div> <!-- 간격 -->

<!-- 풋터 -->
<div> <!-- 회사소개문구 -->
	<tiles:insertAttribute name="footer" /> 
</div>

</body>
</html>