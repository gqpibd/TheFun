<%@page import="donzo.thefun.model.ProjectDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:requestEncoding value="utf-8"/>    
<!-- 본문출력 묶는 태그 -->
	<main class="s-layout__content">  		
<!-- //본문출력 묶는 태그 -->

<link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css">
<link rel="stylesheet" href="CSS/mainCss/myOrder.css">
<<<<<<< HEAD

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
=======
<link href="CSS/detailcss/blog-post.css" rel="stylesheet">
>>>>>>> refs/remotes/origin/dh

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