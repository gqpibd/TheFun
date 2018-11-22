<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:requestEncoding value="utf-8"/> 
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>디테일_새소식</title>
<!-- 폰트설정 -->
<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic:400,700,800&amp;subset=korean" rel="stylesheet">

<style type="text/css">
 .pupple{
 font-family: "Nanum Gothic", sans-serif;
 	color:#8152f0;
 	font-weight: bold;
 }
 .strongGray{
 font-family: "Nanum Gothic", sans-serif;
  color: #5c5c5c;
  font-weight: bold;
  
 }
 .liteGray{
 font-family: "Nanum Gothic", sans-serif;
	 color: #818181;
 }
</style>
</head>
<body>
<table style="width: 100%">
<tr>
	<td align="left" class="strongGray">새소식 <strong class="pupple">n</strong>건</td>
	<!-- if 작성자라면 -->
	<td align="right" class="pupple"> <img src="image/detail/writeBtn.jpg" width="100px"> </td>
</tr>
</table>

<!-- main content -->
<fmt:parseDate value="${notice.regdate}" var="dateFmt" pattern="yyyy-MM-dd HH:mm:ss"/>
<fmt:formatDate value="${dateFmt}" pattern="yyyy년MM월dd일"/>

<br><br>
<c:forEach items="${noticeInfo }" var="notice" varStatus="status">
	<p class="strongGray">
		<font class="pupple" style="font-weight: bold;">#${status.count }</font> 
		${notice.title }
		<font class="liteGray" size="3px">${dateFmt }</font>
	</p>
	<p class="liteGray">${notice.content }</p>
</c:forEach>
<br>


</body>
</html>