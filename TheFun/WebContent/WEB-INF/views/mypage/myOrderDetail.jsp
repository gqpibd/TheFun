<%@page import="donzo.thefun.model.ProjectDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<fmt:requestEncoding value="utf-8"/>    
<!-- 본문출력 묶는 태그 -->
	<main class="s-layout__content">  		
<!-- //본문출력 묶는 태그 -->

<link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css">
<link rel="stylesheet" href="CSS/mainCss/myOrder.css">

<style type="text/css">
/* 별점 + 후기 */
.cont {
	width: 93%;
	max-width: 350px;
	text-align: center;
	margin: auto;
	padding: 15px 0;
	overflow: hidden;
}

div.stars {
	width: 270px;
	display: inline-block;
}

input.star {
	display: none;
}

label.star {
	float: right;
	padding: 10px;
	font-size: 36px;
	color: #444;
	transition: all .2s;
}

input.star:checked ~ label.star:before {
	content: '\f005';
	color: #FD4;
	transition: all .25s;
}

input.star-5:checked ~ label.star:before {
	color: #FE7;
	text-shadow: 0 0 20px #952;
}

input.star-1:checked ~ label.star:before {
	color: #F62;
}

label.star:hover {
	transform: rotate(-15deg) scale(1.3);
}

label.star:before {
	content: '\f006';
	font-family: FontAwesome;
}

.rev-box {
	overflow: hidden;
	height: 0;
	width: 100%;
	transition: all .25s;
}

textarea.review {
	border: 1px solid #adadad;
	resize: none;
	width: 100%;
	max-width: 100%;
	padding: 10px;
	box-sizing: border-box;	
	overflow-y: hidden; /* prevents scroll bar flash */
	padding: 0.7em; /* prevents text jump on Enter keypress */
	line-height: 1.1;
	border-radius: 3px;
	outline: none; /* 포커스 되었을 때 아웃라인 없앰 */
}

label.review {
	display: block;
	transition: opacity .25s;
}

input.star:checked ~ .rev-box {
	height: 125px;
	overflow: visible;
}

.cancel_btn {
    box-shadow: inset 0px 1px 0px 0px #a9a9a9;
    background: linear-gradient(to bottom, #888888, #6c757d 100%);
    border-radius: 6px;
    border: 1px solid #656565;
    display: inline-block;
    cursor: pointer;
    color: #ffffff;
    font-family: Arial;
    font-size: 15px;
    font-weight: bold;
    padding: 6px 24px;
    text-decoration: none;
}
.cancel_btn:hover {
	  box-shadow: inset 0px 1px 0px 0px #bfbfbf;
    background: linear-gradient(to bottom, #6c757d, #888888 100%);
    border-radius: 6px;
    border: 1px solid #656565;
    display: inline-block;
    cursor: pointer;
    color: #ffffff;
    font-family: Arial;
    font-size: 15px;
    font-weight: bold;
    padding: 6px 24px;
    text-decoration: none;
}


</style>

<header id="line_header">
  <div class="container text-center">
    <h1 class="head_title">MY SUPPORT DETAIL</h1>
    <p>상세내역</p>
  </div>
</header>

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