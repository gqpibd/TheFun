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
    <h1 class="head_title">MY SUPPORT DETAIL</h1>
    <p>상세내역</p>
  </div>
</header>
<!-- 진행중....... -->
<h2>결제상세정보</h2>
<table>
<tr>
	<td>결제 일자</td>
	<td> 날짜~</td>
</tr>
</table>
<hr>
<table>
<tr>
	<td colspan="2">상품정보</td>
	<td>상품금액 (수량)</td>
	<td>판매자</td>
	<td>진행상태</td>
</tr>
<tr>
	<td>img</td>
	<td>선택한옵션title <br> 선택한옵션 content</td>
	<td>선택한옵션금액 (수량)</td>
	<td>판매자이름 <br> 판매자 전화번호</td>
	<td>진행상태</td>
</tr>
</table>
<ul>
<li>THE FUN 에서 결제한 경우 결제 완료만 표시되고 별도 거래완료 여부는 표시되지 않습니다.</li>
</ul>
<br>
<h3>결제금액정보</h3>
<table>
<tr>
<td>카드결제</td>
</tr>
<tr>
<td>은행명 ( 카드번호 - **** -****-****) 일시불 <br>
	결제 년월일
</td>
</tr>
</table>



</div>