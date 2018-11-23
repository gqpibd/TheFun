<%@page import="donzo.thefun.model.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	MemberDto myp = (MemberDto) session.getAttribute("login");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My Page</title>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
 
 
<style type="text/css">/* a tag 링크 시에 밑줄 및 색상 변경 제거 */
	a:link { color: black; text-decoration: none;}
	a:visited { color: black; text-decoration: none;}
	a:hover { color: black; text-decoration: none;}
	a:active { color: black; text-decoration: none;}
</style>
 
</head>
<body>



<div class="mypage">
<form class="mypageForm" id="_mypageForm" method="post" action="getMypage.do">
<table>
<tr>
	<td><img alt="프로필" src="./image/profile/default.jpg">&nbsp;&nbsp;</td>
	<td>${myp.nickname } &nbsp;&nbsp;</td>
	<td>${myp.point } </td>
</tr>

<tr style="text-align: center;">
	<td class="menubar"><a href="myInfo.do?id=${login.id}">내 정보</a>&nbsp;&nbsp;</td>
	<td class="menubar">나의 후원내역&nbsp;&nbsp;</td>
	<td class="menubar">내 프로젝트&nbsp;&nbsp;</td>
	<td class="menubar"><a href="myCalendar.do?id=${login.id}">캘린더</a></td>
</tr>

<!-- 노 계획
 <tr>
	<td colspan="2">
		<button type="button" onclick="memberOut">탈퇴하기</button>
	</td>
</tr>
 -->
</table>
</form>
</div>

<script type="text/javascript">
$(function name() {		// 마우스 커서 모양 변경
	$(".menubar").mouseover(function () {   
		   $(this).css("cursor","pointer");
		}); 
	
	
});


</script>

</body>
</html>