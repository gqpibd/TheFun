<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<div id="myInfo"> 
<form action="getMyinfo.do" name="infoForm" id="_infoForm" method="post">
<table class="info_table">

<tr>
	<td style="text-align: left;">아이디</td>
	<td>&nbsp;</td>
</tr>

<tr>
	<td style="text-align: left;">비밀번호</td>
	<td>&nbsp;</td>
</tr>

<tr>
	<td style="text-align: left;">별명</td>
	<td>&nbsp;</td>
</tr>

<tr>
	<td style="text-align: left;">연락처</td>
	<td>&nbsp;</td>
</tr>

<tr>
	<td style="text-align: left;">이메일</td>
	<td>&nbsp;</td>
</tr>

<tr>
	<td style="text-align: left;">주소</td>
	<td>&nbsp;</td>
</tr>

<tr>
	<td style="text-align: left;">나를 소개하는 한줄</td>
	<td>&nbsp;</td>
</tr>

<tr>
	<td colspan="2">
		<button type="button" onclick="infoUpdate">수정하기</button>
	</td>
</tr>

<tr>
	<td colspan="2">
		<button type="button" onclick="memberOut">탈퇴하기</button>
	</td>
</tr>

</table>
</form>
</div>

</body>
</html>