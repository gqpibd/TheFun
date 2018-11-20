<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:requestEncoding value="utf-8"/> 

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>디테일_피드백</title>
<style type="text/css">
 .pupple{
 	color:#8152f0;
 	font-weight: bold;
 }
 .addreply{
 	color:#8152f0;
 	font-weight: bold;
 	text-decoration: underline;
 }
 .strongGray{
  color: #5c5c5c;
  font-weight: bold;
  
 }
 .liteGray{
	 color: #c4c4c4;
 }
</style>
</head>
<body>

<p class="strongGray">피드백 <font class="pupple"><%= %></font></p>
<img src="image/detail/writeBtn.jpg"> <br>
<hr>

<table>
<tr>
	<td colspan="2" align="left">댓글 타이틀</td>
</tr>
<tr>
	<td colspan="2" align="left">댓글 코멘트</td>
</tr>
<tr>
	<td align="left">작성자 이름</td>
	<td align="right" class="addreply"> 답글달기</td>
	
</tr>
<tr>
	<td colspan="2"><hr> </td>
</tr>
</table>
</body>
</html>