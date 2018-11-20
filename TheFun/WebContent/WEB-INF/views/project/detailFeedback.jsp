<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:requestEncoding value="utf-8"/> 

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<!-- 폰트설정 -->
<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic:400,700,800&amp;subset=korean" rel="stylesheet">

<title>디테일_피드백</title>
<style type="text/css">
 .pupple{
 	color:#8152f0;
 	font-weight: bold;
 	font-family: "Nanum Gothic", sans-serif;
 }
 .addreply{
 	color:#8152f0;
 	font-weight: bold;
 	text-decoration: underline;
 	font-family: "Nanum Gothic", sans-serif;
 }
 .strongGray{
  color: #5c5c5c;
  font-weight: bold;
  font-family: "Nanum Gothic", sans-serif;
  
 }
 .liteGray{
	 color: #818181;
	 font-family: "Nanum Gothic", sans-serif;
 }
</style>
</head>
<body>

<p class="strongGray">피드백 <font class="pupple">n</font></p>
<img src="image/detail/writeBtn.jpg" width="100px"> <br>
<hr>

<table style="width: 100%">
<tr>
	<td colspan="2" align="left" class="strongGray">댓글 title</td>
</tr>
<tr>
	<td colspan="2" align="left" class="liteGray">댓글 content</td>
</tr>
<tr>
	<td align="left" class="liteGray">작성자 이름</td>
	<td align="right" class="addreply"> 답글달기</td>
	
</tr>
<tr>
	<td colspan="2"><hr> </td>
</tr>
</table>
</body>
</html>