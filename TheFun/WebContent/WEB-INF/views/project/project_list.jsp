<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
	/* border-radius: 10px; */
	top: 0;
}
.price_card:not(:last-child){
	margin-right: 40px;
}
.header{
	color: rgb(255, 255, 255);
}
.charlie .header{
	/* background: rgb(129, 082, 240); */
}
.name{
	width: 100%;
	font-size: 11pt;
	font-weight: 700;
	display: block;
	text-align: right;
}
.features{
	list-style: none;
	text-align: center;
	color: rgb(138, 138, 138);
	margin: 0;
	padding: 0;
	font-size: 10pt;
}
.features li{
	/* margin: 0 35px; */
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
	color: #FFF;
	border: 0;
	border-radius: 5px;
	height: 40px;
	/* width: 200px; */
	display: block;
	font-weight: 700;
	/* font-size: 15px; */
	text-transform: uppercase;
	margin: 20px auto 35px;
}
.charlie button{
	background: #b29af8;
}
a:link { color: black; text-decoration: none;}
a:visited { color: black; text-decoration: none;}
a:hover { color: black; text-decoration: underline;}
td{
	padding-left: 5px;
	padding-right: 5px;
	vertical-align: middle;
}
</style>



<div class="container">
<div class="row">
<c:if test="${list.size() ne 0}">
<c:forEach items="${list }" var="dto" varStatus="i">
<div class="col-md-3 col-sm-6 mb-4" style="padding:10px;border-left: 1px solid #80808030;border-right: 1px solid #80808030;border-top: 1px solid #80808030;border-bottom: 1px solid #80808030;padding: 10px;">
	<table style="height: 400px;" >
	<tr>
	<td style="text-align: left;">
	<!-- 조건문 : 리워드 / 기부 구분 위해 -->
	<span>
	<c:choose>
		<c:when test="${dto.fundtype.equalsIgnoreCase('reward')}"><img src="image/main/reward.png" width="80px;"></c:when>
		<c:when test="${dto.fundtype.equalsIgnoreCase('donation')}"><img src="image/main/done.png" width="80px;"></c:when>
	</c:choose>
	
	</span>
	</td>
	<td style="text-align: right;position: relative;top:10%;">
	<span>
		<c:choose>
		<c:when test="${(dto.status).equalsIgnoreCase('waiting')}">승인 대기 중</c:when>
		<c:when test="${(dto.status).equalsIgnoreCase('preparing')}"><img src="image/main/prepare.png" width="65px;" ></c:when>
		<c:when test="${(dto.status).equalsIgnoreCase('ongoing')}"><img src="image/main/ongoing.png" width="65px;"></c:when>
		<c:when test="${(dto.status).equalsIgnoreCase('complete_success')}"><img src="image/main/complete.png" width="65px;"></c:when>
		<c:when test="${(dto.status).equalsIgnoreCase('complete_fail')}"><img src="image/main/complete.png" width="65px;"></c:when>
		<c:when test="${(dto.status).equalsIgnoreCase('delete')}">삭제된 게시글</c:when>
		</c:choose>
	</span>
	</td>
	
	</tr>
	
	<tr>
	<td colspan="2">
		<span style="text-align: left;"><a href="projectDetail.do?seq=${dto.seq }"><img class="img-fluid" style="object-fit: cover;cursor: pointer;" src="image/thumbnail/${dto.seq }.png" alt="프로젝트 썸네일" onerror="this.onerror=null;this.src='image/main/mainImg7.PNG'"></a></span>
	</td>
	</tr>
	
	<tr>
	<td colspan="2" style="font-size: 11pt;">
	<a href="projectDetail.do?seq=${dto.seq }">
	<!-- 30자수 제한 -->
	<c:set var="str" value="${dto.title }"/>
	<c:set var="len" value="${fn:length(str)}"/>
	<c:choose>
	<c:when test="${len ge 50}"><strong>${fn:substring(str,0,30) } ...</strong></c:when>
	<c:otherwise><strong>${str }</strong></c:otherwise>
	</c:choose>
	</a>
	</td>
	</tr>
	
	<tr class="features">
	<td colspan="2" style="text-align: right;margin-right: 50px;">by ${dto.nickname }</td>
	</tr>
	
	<tr class="features">
	<td colspan="2" style="text-align: right;"><span title="모금액"><fmt:formatNumber value="${dto.fundachived }" type="number"/> 원</span><%-- &nbsp;/&nbsp;<span title="목표 금액"><fmt:formatNumber value="${dto.goalfund }" type="number"/> 원</span> --%></td>
	</tr>
	
	<tr>
	<td colspan="2">
		<div class="charts" style="position: relative;margin-left: 5px;margin-right: 5px;">
		<div class="charts__chart chart--p100 chart--inverse chart--sm" >
		<div align="center" class="charts__chart chart--green chart--sm" data-percent="${(dto.fundachived div dto.goalfund * 100) }%" style="width: ${(dto.fundachived div dto.goalfund * 100) }%; max-width:100%;">
		</div>
		</div>
		</div>
	</td>
	</tr>

	</table>

</div>
</c:forEach>
</c:if>
</div>
</div>
