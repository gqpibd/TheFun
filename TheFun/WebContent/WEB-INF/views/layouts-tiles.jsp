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
<title>Insert title here</title>

<%-- <tiles:insertAttribute name="header"/> --%> <!-- 표현 되는 것이 아닌 데이터 읽어들여오는 부분 -->

<%-- <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/style.css"> --%>

</head>
<body>
<tiles:insertAttribute name="topbar"/>
<tiles:insertAttribute name="bottom"/>


</body>
</html>