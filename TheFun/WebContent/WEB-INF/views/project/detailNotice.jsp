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
<style type="text/css">
 .pupple{
 	color:#8152f0;
 	font-weight: bold;
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
<table>
<tr>
	<td align="left" class="strongGray">새소식 <%= %></td>
	<td align="right" class="pupple"> <img src="image/detail/writeBtn.jpg"> </td>
</tr>
</table>

<hr color="#5c5c5c">
<p class="strongGray">작성자 타이틀<%= %></p>
<p class="liteGray">작성자 내용<%= %></p>
<hr color="#5c5c5c">

<hr color="#5c5c5c">
<p class="strongGray">작성자 타이틀<%= %></p>
<p class="liteGray">작성자 내용<%= %></p>
<hr color="#5c5c5c">


</body>
</html>