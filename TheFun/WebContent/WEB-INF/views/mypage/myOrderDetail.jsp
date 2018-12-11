<%@page import="donzo.thefun.model.ProjectDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<fmt:requestEncoding value="utf-8"/>    

<header class="line_header">
  <div class="container text-center">
    <h1 class="head_title">MY FUNDING DETAIL</h1>
    <p>후원 상세 내역</p>
  </div>
</header>
<div align="center">
<h2>결제상세정보</h2>
<p>결제일자 : 
	<fmt:parseDate value="${buydto[0].regdate}" pattern="yyyy-MM-dd HH:mm:ss" var="rDate" />
	<fmt:formatDate value="${rDate}" pattern="yyyy년MM월dd일"/>
</p>

<hr>
<table border="1" style="width: 80%">
<tr>
	<td colspan="2">상품정보</td>
	<td>상품금액 (수량)</td>
	<td>판매자</td>
	<td>진행상태</td>
</tr>
<c:forEach items="${buydto}" var="buy">
<tr>
	<td><img src="upload/${buy.projectseq}" height="80px;"></td>
	<td>
		<b style="text-align: center;">${buy.ptitle}</b><br>
		${buy.otitle}<br>  
		<c:forEach items="${fn:split(buy.ocontent,'/')}" var="item">
		 <li>${item}</li>
		</c:forEach>
	</td>
	<td>${buy.price}원 (${buy.count})</td>
	<td>판매자이름 <br> 판매자 전화번호</td>
	<td>${buy.status}</td>
</tr>
</c:forEach>
</table>

<br>
<h3>결제금액정보</h3>
<table border="1" style="width: 80%">
<tr>
	<td class="20width">상품금액</td>
	<td class="20width">할인금액</td>
	<td class="20width">상품금액</td>
	<c:if test="${empty buydto[0].ocontent}">
	<td class="20width">n원</td>
	</c:if>
</tr>
<tr>
	<td style="text-align: right;">n원</td>
	<td style="text-align: right;">n원</td>
	<td>할인금액</td>
	<c:if test="${empty buydto[0].ocontent}">
	<td>(-)n원</td>
	</c:if>
</tr>
<tr>
<td>카드결제</td>
<td>${buydto[0].bankName} (${buydto[0].cardNumber}) 일시불 <br>
	<fmt:parseDate value="${buydto[0].pdate}" pattern="yyyy-MM-dd HH:mm:ss" var="pDate" />
	<fmt:formatDate value="${pDate}" pattern="yyyy년MM월dd일"/>
</td>
<td>결제금액</td>
<td>n원</td>
</tr>
</table>

<c:if test="${not empty buydto[0].ocontent}">
<br><br>
<h3>배송지 정보</h3>
<table border="1" style="width: 80%">
<tr>
	<td style="width: 15%">수령인 </td>
	<td>000</td>
</tr>
<tr>
	<td style="width: 15%">연락처</td>
	<td style="text-align: left;">000</td>
</tr>
<tr>
	<td style="width: 15%">배송지</td>
	<td>000</td>
</tr>

</table>

</c:if>
</div>
<!-- 본문출력 묶는 태그 -->
	</main>
	</div> 
<!-- //본문출력 묶는 태그 -->
