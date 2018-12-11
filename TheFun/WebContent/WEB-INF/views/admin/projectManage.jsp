<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:requestEncoding value="utf-8"/> 

<style type="text/css">
/* 머릿글css */
.h1 {
	font-size: 250%; 
	font-weight: bold; 
	text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.2); 
	color: #666; 
	border-bottom: 2px solid #F7EEF8; 
	border-left: 10px solid #8152f0; 
	text-height:200%; 
	padding: 3px 5px; 
	margin: 5px 0; 
	letter-spacing: 1px; 
	word-spacing: 3px; 
	width: 75%;
	text-align: left;
}

.column1 {
  width: 120px;
  padding-left: 40px;
  text-align: center;
}

.column2 {
  width: 120px;
  text-align: center;
}

.column3 {
  width: 280px;
}

.column4 {
  width: 120px;
  text-align: center;
}

.column5 {
  width: 170px;
  text-align: center;
}

.column6 {
  width: 170px;
  text-align: center;  
}

.column7 {
  width: 130px;
  text-align: left;
  /* padding-right: 62px; */
}

@media screen and (max-width: 992px) {
  .funTable tbody tr td:nth-child(1):before {
     content: "펀드 타입";
  }
  .funTable tbody tr td:nth-child(2):before {
    content: "카테고리";
  }
  .funTable tbody tr td:nth-child(3):before {
    content: "제목";
  }
  .funTable tbody tr td:nth-child(4):before {
    content: "목표금액(원)";
  }
  .funTable tbody tr td:nth-child(5):before {
    content: "등록일";
  }
  .funTable tbody tr td:nth-child(6):before {
    content: "시작일";
  }
  .funTable tbody tr td:nth-child(7):before {
    content: "작성자";
  }
}
</style>
<link rel="stylesheet" href="CSS/common/table.css">

<div align="center">
	<div class="h1">
		<h1>관리자 페이지</h1>
	</div>
	<span>승인을 기다리는 프로젝트가 <span id="waitcount1"></span>개 있습니다.</span>
	<div class="container-table100">
	<div class="wrap-table100">
	<div class="table100">
		<table class="funTable">
			<thead>
				<tr class="table100-head">					
					<th class="column1">펀드 타입</th>
					<th class="column2">카테고리</th>
					<th class="column3">제목</th>
					<th class="column4">목표금액</th>
					<th class="column5">등록일</th>
					<th class="column6">시작일</th>
					<th class="column7">작성자</th>
				</tr>
			</thead>
			<tbody class="funTbody">
				<c:choose>
				<c:when test="${pList eq null}">			
					<tr>
						<td colspan="4">작성된 글이 없습니다</td>
					</tr>
				</c:when>
				<c:otherwise>
				<c:forEach items="${pList}" var="project" varStatus="i">			
				<tr style="cursor:pointer" onclick="location.href='projectDetail.do?seq=${project.seq}'">					
					<td class="column1">${project.getFundTypeKr()}</td>
					<td class="column2">${project.getCategoryKr()}</td>
					<td class="column3">${project.title}</td>
					<td class="column4">${project.goalfund}</td>
					<td class="column5">${project.getDateForm(project.regdate)}</td>				
					<td class="column6">${project.getDateForm(project.sdate)}</td>
					<td class="column7">${project.nickname}</td>
				</tr>
				</c:forEach>
	
				</c:otherwise>
				</c:choose>
			</tbody>
		</table>
		</div>
	</div>		
	</div>
	<div class="">	
		<jsp:include page="/WEB-INF/views/common/paging.jsp" flush="false">
			<jsp:param value="${pageNumber }" name="pageNumber"/>		
			<jsp:param value="${pageCountPerScreen }" name="pageCountPerScreen"/>
			<jsp:param value="${recordCountPerPage }" name="recordCountPerPage"/>
			<jsp:param value="${totalRecordCount }" name="totalRecordCount"/>		
			<jsp:param value="projectManage.do" name="actionPath"/>	
		</jsp:include>	
	</div>
</div>
<script type="text/javascript">
$(".hover_tr").mouseover(function () {
	$(this).children().css("background-color","#F7EEF8");
}).mouseout(function () {
	$(this).children().css("background-color","#ffffff");		
});
</script>