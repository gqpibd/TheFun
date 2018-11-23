<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:requestEncoding value="utf-8"/>     
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 후원</title>

<style type="text/css">
	a:link { color: black; text-decoration: none;}
	a:visited { color: black; text-decoration: none;}
	a:hover { color: black; text-decoration: underline;}
	a:active { color: black; text-decoration: none;}
</style>

</head>
<body>

<div>
<form action="myReward.do">
<table id="donationlist">
	<c:if test="${empty donalist }">
	<tr>
		<td colspan="3">작성된 글이 없습니다</td>
	</tr>	
	</c:if>
	
	<c:forEach items="${donalist }" var="dona" varStatus="vs">	
	<tr class="_hover_tr"  style="text-align: center;">
		<td>${vs.count }</td>
		
		<!-- 테스트용으로 이미지 하나 추가 함 ( 나중에 지울것 ) -->
		<td><img alt="썸네일이미지" src="image/thumbnail/${dona.projectseq }.png" style="border-radius: 50%;"></td>
		
		<td>		
			<a href="detail.do?seq=${dona.projectseq }">
				${dona.ptitle }
			</a>			
		</td>
		<td> 
			후원 가격<br>
			${dona.price } 
		</td>
		<td>
			구매 날짜<br>
			${dona.regdate }
		</td>
		<td>			
				
			<c:choose>
				<c:when test="${dona.status eq 4 && dona.bcomment eq null}">	
					
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
</form>
</div>

<script type="text/javascript">
$(function goLatter() {
	
});
</script>

</body>
</html>