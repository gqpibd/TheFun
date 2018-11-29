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

<br><br><br><br><br>
<header id="line_header">
  <div class="container text-center">
    <h1 class="head_title">MY SUPPORT</h1>
    <p>내 후원</p>
  </div>
</header>

<br><br>

<!-- <form action="myReward.do"> --> <!-- 여기서 form 필요한가? -->
<table class="type07" id="myOrderlist">
	<col width="70">
	<col width="410">
	<col width="150">
	<col width="150">
	<col width="150">
	<thead>
		<c:if test="${empty orderlist }">
		<tr>
			<th colspan="6">구매 내역이 없습니다</th>
		</tr>	
		</c:if>
	</thead>
	
	<thead>
		<c:if test="${not empty orderlist }">
		<tr>
			<th>번호</th>
			<th colspan="2">프로젝트</th>
			<!-- <th></th> -->
			<th>후원금액</th>
			<th>후원 날짜</th>
			<th>상태</th>
		</tr>	
		</c:if>
	</thead>
	
	<tbody>
	<c:forEach items="${orderlist}" var="order" varStatus="vs">
	<tr class="hover_tr" style="cursor:pointer" onclick="location.href='projectDetail.do?seq=${order.projectseq}'">
		<th>${vs.count }</th>
		
		<!-- 테스트용으로 이미지 하나 추가 함 ( 나중에 지울것 ) -->
		<td colspan="2" >
		<img alt="썸네일이미지" src="image/thumbnail/${order.projectseq }.png" style="border-radius: 50%;">
			${order.ptitle }
		</td>
		
		<%-- <td>		
			<a href="projectDetail.do?seq=${order.projectseq }">
				${order.ptitle }
			</a>			
		</td> --%>
		
		<td>
			<fmt:formatNumber value="${order.price * order.count}" type="number"/>  
		</td>
		
		<td>
			<fmt:parseDate var="reg_date" value="${order.regdate}" pattern="yyyy-MM-dd"/>
			<fmt:formatDate value="${reg_date }" pattern="yyyy-MM-dd"/>
		</td>
		
		<td>							
			<c:choose>
				<c:when test="${order.status eq 'complete_success' && order.bcomment eq null}">						
					<button type="button" id="latter" onclick="goLatter()">후기작성</button>					
				</c:when>
				<c:otherwise>						
					<c:choose>		<%-- 임시.. 더 나은 방법을 생각해 보자 --%>								
						<c:when test="${order.status eq 'preparing'}"> 
							준비중
						</c:when>
						<c:when test="${order.status eq 'ongoing'}"> 
							진행중
						</c:when>
						<c:when test="${order.status eq 'complete_success'}"> <!-- bcomment가 null이 아니므로 후기 작성 했음 --> 
							구매 확정
						</c:when>
						<c:when test="${order.status eq 'complete_fail'}"> 
							종료(목표 미달성)
						</c:when>
						<c:when test="${order.status eq 'delete'}"> 
							삭제됨
						</c:when>
						<c:otherwise> 
							${order.status} 
						</c:otherwise>
					 </c:choose>
					<!-- <button type="button" id="latter2" disabled="disabled">후기작성</button> -->				
				</c:otherwise>
			</c:choose>
		</td>	
	</tr>
	</c:forEach>
	<tbody>

</table>
<!-- </form> -->
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




</script>