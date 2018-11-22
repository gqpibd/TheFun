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
		<td>
			<a href="goOrderReward.do?seq=${dona.seq }">
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
			
			<button type="button">후기작성</button>
		
		</td>	
	</tr>		
	</c:forEach>

</table>
</form>
</div>

</body>
</html>