<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- myPage css -->
<link rel="stylesheet" href="CSS/mainCss/maPage.css">
 
<div align="center">
	<div>
			<table border="1">
				<tr>
					<td rowspan="3" style="padding: 25px;"><img class="profile_img" alt="프로필" src="${login.profile}"></td>
					<td colspan="4" style=""><h1>${login.id}</h1></td>
					<!-- <td></td> -->
					<!-- <td></td> -->
					<!-- <td></td> -->
				</tr>
				<tr>
					<!-- <td></td> -->
					<td colspan="4" >보유 포인트 ${login.point}점</td>
					<!-- <td></td> -->
					<!-- <td></td> -->
					<!-- <td></td> -->
				</tr>		
				<tr">
					<!-- <td></td> -->
					<td><a href="myInfo.do?id=${login.id}"><button>내 정보</button></a></td>
					<td><a href="myOrderList.do?id=${login.id}"><button>나의후원내역</button></a></td>
					<td><a href="#"><button>내프로젝트</button></a></td>
					<td><a href="#"><button>캘린더</button></a></td>
				</tr>
			</table>				
	</div>
</div> 



