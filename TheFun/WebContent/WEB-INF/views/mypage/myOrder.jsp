<%@page import="donzo.thefun.model.ProjectDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:requestEncoding value="utf-8"/>    

<link rel="stylesheet" href="CSS/mainCss/myOrder.css">
<link href="CSS/detailcss/blog-post.css" rel="stylesheet">
<style type="text/css">
body{
font-family: "Nanum Gothic", sans-serif;
}
</style>

<div align="center">

<br><br><br><br>
<header id="line_header">
  <div class="container text-center">
    <h1 class="head_title">MY SUPPORT</h1>
    <p>내 후원</p>
  </div>
</header>

<br><br>

<!-- <form action="myReward.do"> --> <!-- 여기서 form 필요한가? -->

<table class="type07" id="myOrderlist">
	<col width="200">
	<col width="410">
	<col width="150">
	<col width="150">
	<col width="150">
	<thead>
		<c:if test="${empty orderlist }">
		<tr>
			<th colspan="6">후원 내역이 없습니다</th>
		</tr>	
		</c:if>
	</thead>
	
	<thead>
		<c:if test="${not empty orderlist }">
		<tr>
			<th>후원일자</th>
			<th colspan="2">후원 프로젝트 정보</th>
			<th>후원금액(수량)</th>
			<th>프로젝트 주인</th>
			<th>프로젝트 상태</th>
			<!-- <th>추가할 어떤 것</th> -->
		</tr>	
		</c:if>
	</thead><!-- head -->
	
	<tbody>
	<c:forEach items="${orderlist}" var="order" varStatus="vs">
	<!--  class="hover_tr" style="cursor:pointer" onclick="location.href='projectDetail.do?seq=${order.projectseq}'" -->
	
	<c:choose>
		<c:when test="${order.isDeleted() eq false}">
			<tr>
			<!-- 후원 일자 : 펀딩일 결제일 -->
			<td><!-- white-space: nowrap;  word-break:break-all  -->		
				<div>후원 날짜 : ${order.getDateForm(order.regdate)}</div>
				<div>결제 날짜 : ${order.getDateForm(order.pdate) }</div>
				<div><a href="projectDetail.do?seq=${order.projectseq}">상세내역</a></div>
			</td>
			
			<!-- 프로젝트 정보 : 썸네일 , 제목-옵션이름 -->
			<td colspan="2" >
				<div class="proTitle" style="cursor:pointer" onclick="location.href='projectDetail.do?seq=${order.projectseq}'">
					<img alt="썸네일이미지" src="upload/${order.projectseq }" style="border-radius: 50%; height: 30px;">${order.ptitle }
				</div>
				<div class="opTitle" style="cursor:pointer" onclick="location.href='projectDetail.do?seq=${order.projectseq}'">${order.otitle }</div>
			</td>
			
			<!-- 총 금액 ( 수량 ) -->
			<td>
				<div><fmt:formatNumber value="${order.price * order.count}" type="number"/>원</div>
				 <div>(${order.count }개)</div>
			</td>
			
			<!-- 프로젝트 작성자 -->
			<td>${order.id }</td>
			
			<!-- 프로젝트 상태 -->
			<td>
				<div>
					<c:choose>										
						<c:when test="${order.isWaiting()}">승인 대기 중</c:when>
						<c:when test="${order.isPreparing()}">준비 중</c:when>
						<c:when test="${order.isOngoing()}">진행 중</c:when>
						<c:when test="${order.isComplete_success()}">
							<c:choose>
								<c:when test="${order.otitle eq null || order.bcomment ne null}">구매 확정</c:when>
								<c:when test="${order.bcomment eq null }">
									<button type="button" id="latter" onclick="goLatter()">후기작성</button>
								</c:when>
							</c:choose>
						</c:when>
						<c:when test="${order.isComplete_fail()}">목표 미달성</c:when>
						<c:when test="${order.isDeleted()}">삭제된 게시글</c:when>
						<c:otherwise> 
							${order.status} 
						</c:otherwise>
					 </c:choose>
				 </div>	
			</td>
			<!-- 뭔가 더 추가할 어떤것 -->
		</tr>
		</c:when>
	</c:choose>
	
	</c:forEach>
	<tbody>

</table>
<%-- 
<div id="paging_wrap">	
	<jsp:include page="/WEB-INF/views/common/paging.jsp" flush="false">
		<jsp:param value="${pageNumber }" name="pageNumber"/>		
		<jsp:param value="${pageCountPerScreen }" name="pageCountPerScreen"/>
		<jsp:param value="${recordCountPerPage }" name="recordCountPerPage"/>
		<jsp:param value="${totalRecordCount }" name="totalRecordCount"/>	
	</jsp:include>	
</div>
 --%>
</div>

<script type="text/javascript">
$(function goLatter() {
	
});

$(".hover_tr").mouseover(function () {
	$(this).find("td").css("background-color","#F7EEF8");
	//$(this.td).first().css("background-color","#8152f0");
}).mouseout(function () {
	$(this).find("td").css("background-color","#ffffff");	
	//$(this).first().css("background-color","#8152f0");
});
/* 
/* 페이지 번호 클릭 했을때 */
function goPage(pageNumber) {
	$("#_pageNumber").val(pageNumber);
	$("#_frmFormSearch").attr({"target":"_self", "action":"bbslist.do"}).submit();
} */
</script> 