<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:requestEncoding value="utf-8"/>   
<link href="CSS/detailcss/blog-post.css" rel="stylesheet">
<style>
/* 글씨체 */
body{
font-family: "Nanum Gothic", sans-serif;
}

/* 
th, td{
	font-size: 11pt;
} */
.price_card{
	/* width: 300px; */
	background: rgb(255, 255, 255);
	display: inline-table;
	top: 0;
}
.price_card:not(:last-child){
	margin-right: 40px;
}
.header{
	color: rgb(255, 255, 255);
}
.charlie .header{
	background: rgb(129, 082, 240);
}
.name{
	width: 100%;
	font-size: 15px;
	font-weight: 700;
	display: block;
	text-align: center;
	padding: 0 0 30px;
}
.features{
	list-style: none;
	text-align: center;
	color: rgb(138, 138, 138);
	margin: 0;
	padding: 0;
}
.features li{
	margin: 0 35px;
	padding: 20px 15px;
	/* width: 200px; */
}
.features li:not(:last-child){
	border: 1px solid rgb(242, 242, 242);
	border-top: 0;
	border-left: 0;
	border-right: 0;
}
.btn{
	color: rgb(255, 255, 255);
	border: 0;
	border-radius: 5px;
	height: 40px;
	/* width: 200px; */
	display: block;
	font-weight: 700;
	font-size: 15px;
	text-transform: uppercase;
	margin: 20px auto 35px;
}
.charlie button{
	background: rgb(48, 219, 181);
}
</style>



<div class="container">
<div class="row">
<c:if test="${list.size() ne 0}">
<c:forEach items="${list }" var="dto" varStatus="i">
<div class="col-md-3 col-sm-6 mb-4">
	<hr>
	<table  style="table-layout:fixed; height: 600px;">
	<col width="35%;"><col width="65%;">
	<tr>
	<td>
	<!-- 조건문 : 리워드 / 기부 구분 위해 일단은 간략하게 글씨로 -->
	<c:choose>
		<c:when test="${dto.fundtype.equalsIgnoreCase('reward')}">리워드</c:when>
		<c:when test="${dto.fundtype.equalsIgnoreCase('donation')}">기부</c:when>
	</c:choose>
	</td>
	<td>
	<!-- 진행 상태 status 확인하려고 / 일단 전부 써두었습니다 -->
	<c:choose>
		<c:when test="${(dto.status).equalsIgnoreCase('waiting')}">승인 대기 중</c:when>
		<c:when test="${(dto.status).equalsIgnoreCase('preparing')}">준비 중</c:when>
		<c:when test="${(dto.status).equalsIgnoreCase('ongoing')}">진행 중</c:when>
		<c:when test="${(dto.status).equalsIgnoreCase('complete_success')}">완료됨(성공)</c:when>
		<c:when test="${(dto.status).equalsIgnoreCase('complete_fail')}">완료됨(실패)</c:when>
		<c:when test="${(dto.status).equalsIgnoreCase('delete')}">삭제된 게시글</c:when>
	</c:choose>
	</td>
	</tr>
	
	<tr>
	<td colspan="2" >
		<a href="projectDetail.do?seq=${dto.seq }"><img class="img-fluid" style="object-fit: cover;cursor: pointer;" src="image/thumbnail/${dto.seq }.png" alt="프로젝트 썸네일" onerror="this.onerror=null;this.src='image/main/mainImg7.PNG'"></a>
	</td>
	</tr>
	
	<tr>
	<th>프로젝트 : </th><td><a href="projectDetail.do?seq=${dto.seq }">${dto.title }</a></td>
	</tr>
	
	<tr>
	<td colspan="2"><a href="projectDetail.do?seq=${dto.seq }">${dto.summary }</a></td>
	</tr>
	
	<tr>
	<th>by </th><td>${dto.nickname }</td>
	</tr>
	
	<tr>
	<th>모금액 : </th><td><fmt:formatNumber value="${dto.fundachived }" type="number"/> 원</td>
	</tr>
	
	<tr>
	<th>목표액 : </th><td><fmt:formatNumber value="${dto.goalfund }" type="number"/> 원</td>
	</tr>
	
	<tr>
	<th>달성률 : </th><td><fmt:formatNumber value="${(dto.fundachived div dto.goalfund * 100) }" type="number" pattern="0.0"/> %</td>
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
	<th>구매 수 : </th><td><fmt:formatNumber value="${dto.buycount }" type="number"/> 건</td>
	</tr>
	</table>
	<hr>


<!-- ///////////////////////////////// -->
<%-- <div class="price_card charlie">
		<div class="header">
			<!-- <span class="price">$25</span> -->
			<span>
				<a href="projectDetail.do?seq=${dto.seq }"><img class="img-fluid" style="object-fit: cover;cursor: pointer;" src="image/thumbnail/${dto.seq }.png" alt="프로젝트 썸네일" onerror="this.onerror=null;this.src='image/main/mainImg7.PNG'"></a>
			</span>
			<span class="name">${dto.nickname}</span>
		</div>
		<ul class="features">
			<li>Complete documentation</li>
			<li>Working materials in PSD, Sketch and EPS format</li>
			<li>1 year access to the library</li>
			<li>2GB cloud storage</li>
		</ul>
		<button class="btn">Add to cart</button>
	</div>
--%>
</div> 
<!-- ///////////////////////////////// -->

</c:forEach>
</c:if>
</div>
</div>
