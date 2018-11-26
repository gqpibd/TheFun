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

<br><br>
<p class="strongGray"><font class="pupple" style="font-weight: bold;">#1</font> 작성자 타이틀</p>
<p class="liteGray">작성자 내용</p>

<br>

<!-- 게시글 갯수만큼 -->
<p class="strongGray"><font class="pupple" style="font-weight: bold;">#2</font> 작성자 타이틀</p>
<p class="liteGray">작성자 내용</p>
<br>


</body>
</html>