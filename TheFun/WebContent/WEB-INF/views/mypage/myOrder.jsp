<%@page import="donzo.thefun.model.ProjectDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:requestEncoding value="utf-8"/>     

<style type="text/css">
	a:link { color: black; text-decoration: none;}
	a:visited { color: black; text-decoration: none;}
	a:hover { color: black; text-decoration: underline;}
	a:active { color: black; text-decoration: none;}
</style>

<div>
<!-- <form action="myReward.do"> --> <!-- 여기서 form 필요한가? -->
<table id="myOrderlist">
	<c:if test="${empty orderlist }">
	<tr>
		<td colspan="3">구매 내역이 없습니다</td>
	</tr>	
	</c:if>
	
	<tr>
		<th> 번호 </th> <th colspan="2">프로젝트</th> <th>후원금액</th> <th>후원 날짜</th> <th>상태</th>
	</tr>
	<c:forEach items="${orderlist }" var="order" varStatus="vs">
	<tr class="_hover_tr"  style="text-align: center;">
		<td>${vs.count }</td>
		
		<!-- 테스트용으로 이미지 하나 추가 함 ( 나중에 지울것 ) -->
		<td><img alt="썸네일이미지" src="image/thumbnail/${order.projectseq }.png" style="border-radius: 50%;"></td>
		
		<td>		
			<a href="projectDetail.do?seq=${order.projectseq }">
				${order.ptitle }
			</a>			
		</td>
		<td>
			${order.price * order.count} 
		</td>
		<td>
			${order.regdate}
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

</table>
<!-- </form> -->
</div>

<script type="text/javascript">
$(function goLatter() {
	
});
</script>