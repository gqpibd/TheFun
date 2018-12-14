<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<style type="text/css">
.header {
  background-color: #8152f0;
  color: white;
  font-size: 1.5em;
  padding: 0.3rem;
  text-align: center;
}

.table_img {
  border-radius: 50%;
  height: 60px;
  width: 60px;
  background: white;
}

.table-users {
  border: 1px solid #8152f0;
  border-radius: 10px;
  box-shadow: 3px 3px 0 rgba(0, 0, 0, 0.1);
  max-width: calc(100% - 2em);
  margin: 1em auto;
  overflow: hidden;
  width: 800px;
}

table {
  width: 100%;
}

table td, table th {
  color: #000;
  padding: 10px;
  text-align: center;
}

table td {
  text-align: center;
  vertical-align: middle;
}

table td:last-child {
  font-size: 0.95em;
  line-height: 1.4;
  text-align: left;
}

table th {
  background-color: #8152f0;
  font-weight: 300;
  color: #fff;
}
table tr:nth-child(2n) {
  background-color: white;
}
table tr:nth-child(2n+1) {
  background-color: #edf7f8;
}

@media screen and (max-width: 1000px) {  
  table, tr, td {
    display: block;
  }

  td:first-child {
    position: absolute;
    top: 50%;
    -webkit-transform: translateY(-50%);
            transform: translateY(-50%);
    width: 100px;
  }
  td:not(:first-child) {
    clear: both;
    margin-left: 100px;
    padding: 4px 20px 4px 90px;	
    position: relative;
    text-align: left;
  }
  td:not(:first-child):before {
    color: #8152f0;
    content: '';
    display: block;
    left: 0;
    position: absolute;
  }
  td:nth-child(2):before {
    content: 'Name:';
  }
  td:nth-child(3):before {
    content: 'Point:';
  }
  td:nth-child(4):before {
    content: 'Comments:';
  }
  
  tr {
    padding: 20px 0;
    position: relative;
  }
  tr:first-child {
    display: none;
  }
}

@media screen and (max-width: 687px) {
  .header {
    background-color: transparent;
    color: #8152f0;
    font-size: 2em;
    font-weight: 700;
    padding: 0;
    text-shadow: 2px 2px 0 rgba(0, 0, 0, 0.1);
  }
 
 
  table_img {
    border: 3px solid;
    border-color: #daeff1;
    height: 100px;
    margin: 0.5rem 0;
    width: 100px;
  }

  td:first-child {
    background-color: #8152f0;
    border-bottom: 1px solid #91ced4;
    border-radius: 10px 10px 0 0;
    position: relative;
    top: 0;
    -webkit-transform: translateY(0);
            transform: translateY(0);
    width: 100%;
  }
  td:not(:first-child) {
    margin: 0;
    padding: 5px 1em;
    width: 100%;
  }
  td:not(:first-child):before {
    font-size: .8em;
    padding-top: 0.3em;
    position: relative;
  }
  td:last-child {
    padding-bottom: 1rem !important;
  }

  tr {
    background-color: white !important;
    border: 1px solid #8152f0;
    border-radius: 10px;
    box-shadow: 2px 2px 0 rgba(0, 0, 0, 0.1);
    margin: 0.5rem 0;
    padding: 0;
    
  }

  .table-users {
    border: none;
    box-shadow: none;
    overflow: visible;
  }
}

</style>
    
    
    



<div class="table-users">
	<div class="header">MyPage</div>
	<table border="0px">
		 <tr>
	        <th>Picture</th>
	        <th>Name</th>
	        <th>Point</th>
         	<th width="230">Comments</th>
      </tr>
      <tr>
         <td><img class="table_img" alt="프로필" src="${login.profile }"></td>
         <td>${login.nickname }</td>
         <td>${login.point }점</td>
         <td>${login.info }</td>
      </tr>
      
		<%-- <tr>
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
		</tr>		 --%>
		<%-- <tr>
			<!-- <td></td> -->
			<td colspan="4" style="padding-bottom: 40px; padding-left: 10px;">${login.info}</td>
			<!-- <td></td> -->
			<!-- <td></td> -->
			<!-- <td></td> -->
		</tr>		 --%>
		<%-- <tr>
			<!-- <td></td> -->
			<td><a href="myInfo.do?id=${login.id}"><button class="btn_MyPage">나의 정보</button></a></td>
			<td><a href="myOrderList.do?id=${login.id}"><button class="btn_MyPage">나의 후원내역</button></a></td>
			<td><a href="mySchedule.do"><button class="btn_MyPage">나의 프로젝트</button></a></td>
			<td><a href="myChart.do"><button class="btn_MyPage">나의 통계보기</button></a></td>
			<!-- <td><a href="myCalendar.do"><button class="btn_MyPage">일정보기</button></a></td> -->
		</tr> --%>
	</table>				
</div>


<!-- 본문출력 묶는 태그 -->
	<jsp:include page="../common/footer.jsp"/>
	</main>
	</div> 
<!-- //본문출력 묶는 태그 -->