<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 본문출력 묶는 태그 -->
	<main class="s-layout__content">  		
<!-- //본문출력 묶는 태그 -->


<div>
	<table border="0px" width="50%">
		<tr>
			<td rowspan="3" style="padding: 30px;">
				<div class="" align="center">
					<img class="profile_img" alt="프로필" src="${login.profile}">					
				</div>
				<div align="center">
					<p style="font-weight: bold;">보유 포인트: ${login.point}점</p>
				</div>
			</td>
			<td colspan="4" style="width: 100%; height: 100%;text-align: center"><h1>${login.nickname} 님</h1></td>
			<!-- <td></td> -->
			<!-- <td></td> -->
			<!-- <td></td> -->
		</tr>		
		<tr>
			<!-- <td></td> -->
			<td colspan="4" style="padding-bottom: 40px; padding-left: 10px;">${login.info}</td>
			<!-- <td></td> -->
			<!-- <td></td> -->
			<!-- <td></td> -->
		</tr>		
		<tr>
			<!-- <td></td> -->
			<td><a href="myInfo.do?id=${login.id}"><button class="btn_MyPage">나의 정보</button></a></td>
			<td><a href="myOrderList.do?id=${login.id}"><button class="btn_MyPage">나의 후원내역</button></a></td>
			<td><a href="mySchedule.do?id=${login.id}"><button class="btn_MyPage">나의 프로젝트</button></a></td>
			<!-- <td><a href="myCalendar.do"><button class="btn_MyPage">일정보기</button></a></td> -->
		</tr>
	</table>				
</div>


<!-- 본문출력 묶는 태그 -->
</main>
</div> 
<!-- //본문출력 묶는 태그 -->