<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My Page</title>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

</head>
<body>



<div class="mypage">
<form action="" class="mypageForm" id="_mypageForm" method="post">
<table>

<tr>
	<td>프로필사진&nbsp;&nbsp;</td>
	<td>닉네임&nbsp;&nbsp;</td>
	<td>포인트</td>
</tr>

<tr style="text-align: center;">
	<td class="menubar">내 정보&nbsp;&nbsp;</td>
	<td class="menubar">나의 후원내역&nbsp;&nbsp;</td>
	<td class="menubar">내 프로젝트&nbsp;&nbsp;</td>
	<td class="menubar">캘린더</td>
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
$(function name() {
	$(".menubar").mouseover(function () {   
		   $(this).css("cursor","pointer");
		}); 
	
	
});


</script>

</body>
</html>