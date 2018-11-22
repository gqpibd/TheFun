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
<form action="myInfo.do" name="infoForm" id="_infoForm" method="post">
<table class="info_table">

<tr><!-- 아이디 변경 불가 -->
	<td style="text-align: left;">아이디</td>
	<td>&nbsp;<input type="text" value="${myi.id }" readonly="readonly"></td>
</tr>

<tr><!-- null 이면 readonly -->
	<td style="text-align: left;">비밀번호</td>
	<td>&nbsp;<input type="text" name="mypwd" value="${myi.pwd }"></td>
</tr>

<tr>
	<td style="text-align: left;">별명</td>
	<td>&nbsp;<input type="text" name="mynickname" value="${myi.nickname }"></td>
</tr>

<tr>
	<td style="text-align: left;">연락처</td>
	<td>&nbsp;<input type="text" name="myphone" value="${myi.phone }"></td>
</tr>

<tr>
	<td style="text-align: left;">이메일</td>
	<td>&nbsp;<input type="text" name="myemail" value="${myi.email }"></td>
</tr>

<tr>
	<td style="text-align: left;">주소</td>
	<td>&nbsp;<input type="text" name="myaddress" value="${myi.address }"></td>
</tr>

<tr>
	<td style="text-align: left;">나를 소개하는 한줄</td>
	<td>&nbsp;<input type="text" name="myintro" value="${myi.info }"></td>
</tr>

<tr>
	<td style="text-align: left;">포인트</td>
	<td>&nbsp;<input type="text" value="${myi.point }" readonly="readonly"></td>
</tr>

<tr>
	<td colspan="2">
		<button type="button" onclick="infoUpdate">수정하기</button>
	</td>
</tr>

</table>
</form>
</div>

<script type="text/javascript">
$("#button").click(function infoUpdate() {
	// [도현누나]랑 연결 :: 회원정보 수정
});
</script>

</body>
</html>