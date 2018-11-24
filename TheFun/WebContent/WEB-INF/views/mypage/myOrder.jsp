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
		<td colspan="3">작성된 글이 없습니다</td>
	</tr>	
	</c:if>
	
	<c:forEach items="${orderlist }" var="order" varStatus="vs">	
	<tr class="_hover_tr"  style="text-align: center;">
		<td>${vs.count }</td>
		
		<!-- 테스트용으로 이미지 하나 추가 함 ( 나중에 지울것 ) -->
		<td><img alt="썸네일이미지" src="image/thumbnail/${order.projectseq }.png" style="border-radius: 50%;"></td>
		
		<td>		
			<a href="orderdetail.do?seq=${order.projectseq }">
				${order.ptitle }
			</a>			
		</td>
		<td> 
			후원 가격<br>
			${order.price } 
		</td>
		<td>
			구매 날짜<br>
			${order.regdate }
		</td>
		<td>							
			<c:choose>
				<c:when test="${order.status eq 4 && order.bcomment eq null}">						
					<button type="button" id="latter" onclick="goLatter()">후기작성</button>					
				</c:when>
				<c:otherwise>
					<button type="button" id="latter2" disabled="disabled">후기작성</button>				
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