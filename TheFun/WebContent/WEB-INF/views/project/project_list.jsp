<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:requestEncoding value="utf-8"/>   
<div class="container">
<div class="row">
<c:if test="${list.size() ne 0}">
<c:forEach items="${list }" var="dto" varStatus="i">
<div class="col-md-3 col-sm-6 mb-4">

	<hr>
	<table border="1" style="table-layout:fixed; height: 550px;">
	<col width="30%;"><col width="70%;">
	<tr>
	<td colspan="2">
	<!-- 조건문 : 리워드 / 기부 구분 위해 일단은 간략하게 글씨로 -->
	<c:choose>
		<c:when test="${dto.fundtype eq 'reward'}">리워드</c:when>
		<c:when test="${dto.fundtype eq 'donation'}">기부</c:when>
	</c:choose>
	</td>
	</tr>
	
	<tr>
	<td colspan="2" >
		<a href="detail.do?seq=${dto.seq }"><img class="img-fluid" style="object-fit: cover;cursor: pointer;" src="image/thumbnail/${dto.seq }.png" alt="프로젝트 썸네일" onerror="this.onerror=null;this.src='image/main/mainImg7.PNG'"></a>
	</td>
	</tr>
	
	<tr>
	<td>프로젝트 명 : </td><td><a href="detail.do?seq=${dto.seq }">${dto.title }</a></td>
	</tr>
	
	<tr>
	<td>요약 : </td><td><a href="detail.do?seq=${dto.seq }">${dto.summary }</a></td>
	</tr>
	
	<tr>
	<td>작성자 : </td><td>${dto.id } : 닉네임으로 고쳐야</td>
	</tr>
	
	<tr>
	<td>모금액 : </td><td><fmt:formatNumber value="${dto.fundachived }" type="number"/> 원</td>
	</tr>
	
	<tr>
	<td>목표액 : </td><td><fmt:formatNumber value="${dto.goalfund }" type="number"/> 원</td>
	</tr>
	
	<tr>
	<td>달성률 : </td><td><fmt:formatNumber value="${(dto.fundachived div dto.goalfund * 100) }" type="number" pattern="0.0"/> %</td>
	</tr>
	
	<tr>
	<td colspan="2">
	<div class="charts">
	<div class="charts__chart chart--p100 chart--inverse" >
	<div class="charts__chart chart--green" data-percent="${(dto.fundachived div dto.goalfund * 100) }%" style="width: ${(dto.fundachived div dto.goalfund * 100) }%; max-width:100%;">
	</div>
	</div>
	</div>
	</td>
	</tr>

	<tr>
	<td>구매 수 : </td><td><fmt:formatNumber value="${dto.buycount }" type="number"/> 건</td>
	</tr>
	</table>
	<hr>
</div>
</c:forEach>
</c:if>
</div>
</div>
