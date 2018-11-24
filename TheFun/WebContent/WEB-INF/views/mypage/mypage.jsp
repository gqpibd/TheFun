<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- myPage css -->
<link rel="stylesheet" href="CSS/mainCss/maPage.css">
 
<div align="center"> 
	<div>
		<form action="" method="post">
			<table border="1">
				<tr>
					<td><img class="profile_img" alt="프로필" src="${login.address}"></td>
					<td>${login.id}</td>
				</tr>
				<tr>
					<!-- <td></td> -->
					<td colspan="2" align="center">보유 포인트 ${login.point}점</td>
				</tr>
			</table>
		</form>
	</div>
	
	<br>
	
	<nav id="topMenu"> 
		<ul> 
			<li><a class="menuLink" href="myInfo.do?id=${login.id}">내 정보</a></li> 
			<li><a class="menuLink" href="myOrderList.do?id=${login.id}">나의후원내역</a></li>
			<li><a class="menuLink" href="#">내프로젝트</a></li>
			<li><a class="menuLink" href="#">캘린더</a></li>
		</ul>
    </nav>
</div> 