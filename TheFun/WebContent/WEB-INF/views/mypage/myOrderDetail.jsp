<%@page import="donzo.thefun.model.ProjectDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<fmt:requestEncoding value="utf-8"/>    

<header id="line_header">
  <div class="container text-center">
    <h1 class="head_title">MY FUNDING DETAIL</h1>
    <p>후원 상세 내역</p>
  </div>
</header>
<div align="center">
<h2>주문상세정보</h2>
<p>주문일자 : 
	<fmt:parseDate value="${buydto[0].regdate}" pattern="yyyy-MM-dd HH:mm:ss" var="rDate" />
	<fmt:formatDate value="${rDate}" pattern="yyyy년MM월dd일"/>
</p>

<hr>
<table style="width: 80%">
<tr style="border-bottom: 1px solid gray;">
	<td colspan="2" style="padding: 10px;">상품정보</td>
	<td style="padding: 10px;">상품금액 (수량)</td>
	<td style="padding: 10px;">판매자</td>
	<td style="padding: 10px;">진행상태</td>
</tr>
<c:forEach items="${buydto}" var="buy">
<tr style="border-bottom: 1px solid gray;">
	<td style="padding: 10px;"><img src="upload/${buy.projectseq}" height="80px;"></td>
	<td style="padding: 10px;">
		<b style="text-align: center;">${buy.ptitle}</b><br>
		${buy.otitle}<br>  
		<c:forEach items="${fn:split(buy.ocontent,'/')}" var="item">
		 <li>${item}</li>
		</c:forEach>
	</td>
	<td style="padding: 10px;"><font><fmt:formatNumber value="${buy.price}" type="number"/></font>원 (${buy.count}개)</td>
	<td style="padding: 10px;">판매자이름 <br> 판매자 전화번호</td>
	<td style="padding: 10px;">
		<c:if test="${buy.status eq 'ongoing'}">
			결제대기
		</c:if>
		<c:if test="${buy.status eq 'complete_success'}">
			결제완료
		</c:if>
		<c:if test="${buy.status eq 'complete_fail'}">
			결제취소
		</c:if>
	</td>
</tr>
</c:forEach>
</table>

<br><br>
<h3>결제상세정보</h3>


	<c:set var="totalprice" value="0"/>

<c:forEach items="${buydto}" var="buy"> <!-- 총주문금액 설정 -->
	<c:set var="process" value="${buy.price * buy.count }"/>
	<c:set var="totalprice" value="${totalprice + process}"/>
</c:forEach>

<table style="width: 80%;">
<tr style="border-bottom: 1px solid gray;">
	<td width="20%" style="padding: 10px; ">상품금액</td>
	<td style="text-align: left; padding: 10px;"><font id="productPrice"></font>원</tr>

<c:if test="${not empty buydto[0].ocontent}">	<!-- 리워드일때 -->
<tr style="border-bottom: 1px solid gray;">	
	<td style="padding: 10px;">할인금액</td> <!-- 포인트사용 내역 -->
	<td style="text-align: left;padding: 10px; ">n원</td>
</tr>
</c:if>

<tr style="border-bottom: 1px solid gray;">
	<td style="padding: 10px;padding: 10px; ">결제예정금액</td>
	<td style="text-align: left;padding: 10px; ">	<!-- 포인트 db생기면 - 포인트 추가 -->
	<b style="color: #8152f0;"><fmt:formatNumber value="${totalprice }" type="number"/>원</b>
	</td>
</tr>
<tr style="border-bottom: 1px solid gray;">
	<td style="padding: 10px;padding: 10px; ">결제예정수단</td>
	<td  style="padding: 10px;padding: 10px; ">${buydto[0].bankName} 
	(${fn:substring(buydto[0].cardNumber,0,4) } - ${fn:substring(buydto[0].cardNumber,4,6)}** - **** - **** )</td>
</tr>
</table>

<c:if test="${not empty buydto[0].ocontent}">
<br><br>
<h3>배송지 정보</h3>
<table style="width: 80%">
<tr style="border-bottom: 1px solid gray;">
	<td style="width: 15%; padding: 10px;">수령인 </td>
	<td style="padding: 10px;">${buydto[0].name} </td>
</tr>
<tr style="border-bottom: 1px solid gray;">
	<td style="width: 15%; padding: 10px;">연락처</td>
	<td style="text-align: left; padding: 10px;">${buydto[0].phone} </td>
</tr>
<tr style="border-bottom: 1px solid gray;">
	<td style="width: 15%; padding: 10px;">배송지</td>
	<td  style="padding: 10px;">${buydto[0].roadaddress}${buydto[0].detailaddress}</td>
</tr>

</table>

</c:if>
</div>
<!-- 본문출력 묶는 태그 -->
	</main>
	</div> 
<!-- //본문출력 묶는 태그 -->

<script>

$(document).ready(function (){
	var len = "${fn:length(buydto)}";
	
	if(len==1){
		
		$("#productPrice").val();	
	}else if(len>1){
		$("#productPrice").val();		
	}
	
});


</script>