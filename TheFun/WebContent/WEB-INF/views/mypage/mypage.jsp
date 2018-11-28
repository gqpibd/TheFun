<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- myPage css -->
<link rel="stylesheet" href="CSS/mainCss/maPage.css">
 
<!-- <style>
* { margin:0; padding:0; }
ul { line-style:none; }
nav { width:320px; height: 35px; background-color:#444; border-radius: 5px; margin:5px 0px 0px 0px; padding:0 0px 0px 0px; }
nav li { display:inline; }
nav li a { float: left; margin-right:5px; padding: 0px 20px; line-height:35px; }
nav li a:hover { color:#fff; }
nav ul ul { position:absolute; opt:25px; width:100px; border:1px solid #ccc; border-top:none; }
nav ul li:hover > ul { display: block; }
nav ul ul li a { width:100px; padding:10px 20px; line-height:1.4em; }
nav ul ul li a:hover { background: #444;}
a.nav_a { color:#33ccff; }
.clear { clear:both; }
</style> -->
 
<div align="center">
	<div>
			<table border="1">
				<tr>
					<td rowspan="3" style="padding: 25px;"><img class="profile_img" alt="프로필" src="${login.profile}.png"></td>
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
				<tr>
					<!-- <td></td> -->
					
					<td><a href="myInfo.do?id=${login.id}"><button>내 정보</button></a></td>
					<td><a href="myOrderList.do?id=${login.id}"><button>나의후원내역</button></a></td>
					<td><a href="mySchedule.do?id=${login.id}"><button>내프로젝트</button></a></td>
					<td><a href="myCalendar.do"><button>일정보기</button></a></td>
				</tr>
			</table>				
	</div>
</div> 
<%-- 
<nav>
	<ul>
	<li><a href="myInfo.do?id=${login.id}" class="nav_a"><button>내 정보</button></a></li>
	<li><a href="myOrderList.do?id=${login.id}" class="nav_a"><button>나의후원내역</button></a></li>
	<li><a href="mySchedule.do?id=${login.id}" class="nav_a"><button>내프로젝트</button></a></li>
	<li><a href="myCalendar.do" class="nav_a"><button>일정보기</button></a></li>	
	</ul>
</nav>
 --%>

