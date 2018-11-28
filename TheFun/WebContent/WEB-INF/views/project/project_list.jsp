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
	font-size: 15px;
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
	font-size: 15px;
	text-transform: uppercase;
	margin: 20px auto 35px;
}
.charlie button{
	background: #b29af8;
}
a:link { color: black; text-decoration: none;}
a:visited { color: black; text-decoration: none;}
a:hover { color: black; text-decoration: underline;}
</style>



<div class="container">
<div class="row">
<c:if test="${list.size() ne 0}">
<c:forEach items="${list }" var="dto" varStatus="i">
<div class="col-md-3 col-sm-6 mb-4">
	<hr>
	<table >
	<col width="20%;"><col width="80%;">
	<tr>
	<td>
	<!-- 조건문 : 리워드 / 기부 구분 위해 일단은 간략하게 글씨로 -->
	<c:choose>
		<c:when test="${dto.fundtype.equalsIgnoreCase('reward')}"><img src="image/main/reward.png" width="80px;"></c:when>
		<c:when test="${dto.fundtype.equalsIgnoreCase('donation')}"><img src="image/main/done.png" width="80px;"></c:when>
	</c:choose>
	</td>
	<td>
	<!-- 진행 상태 status 확인하려고 / 일단 전부 써두었습니다 -->
	<%-- <c:choose>
		<c:when test="${(dto.status).equalsIgnoreCase('waiting')}">승인 대기 중</c:when>
		<c:when test="${(dto.status).equalsIgnoreCase('preparing')}">준비 중</c:when>
		<c:when test="${(dto.status).equalsIgnoreCase('ongoing')}"><img src="image/main/ongoing.png" width="65px;" style="position: sticky;top: 50px;left: 130px;z-index:1;"></c:when>
		<c:when test="${(dto.status).equalsIgnoreCase('complete_success')}">완료됨(성공)</c:when>
		<c:when test="${(dto.status).equalsIgnoreCase('complete_fail')}">완료됨(실패)</c:when>
		<c:when test="${(dto.status).equalsIgnoreCase('delete')}">삭제된 게시글</c:when>
	</c:choose> --%>
	</td>
	</tr>
	
	<tr>
	<td colspan="2">
		<a href="projectDetail.do?seq=${dto.seq }"><img class="img-fluid" style="object-fit: cover;cursor: pointer;border-radius: 5px;" src="image/thumbnail/${dto.seq }.png" alt="프로젝트 썸네일" onerror="this.onerror=null;this.src='image/main/mainImg7.PNG'"></a>
		<div class="charts" style="cursor:pointer; position: relative;top: -40px;margin-left: 5px;margin-right: 5px;" onclick="javascript:location.href='projectDetail.do?seq=${dto.seq }'">
		<div class="charts__chart chart--p100 chart--inverse " >
		<div align="center" class="charts__chart chart--green" data-percent="${(dto.fundachived div dto.goalfund * 100) }%" style="width: ${(dto.fundachived div dto.goalfund * 100) }%; max-width:100%;">
		</div>
		</div>
		</div>
		
		<div align="right">
			<c:choose>
			<c:when test="${(dto.status).equalsIgnoreCase('waiting')}">승인 대기 중</c:when>
			<c:when test="${(dto.status).equalsIgnoreCase('preparing')}"><img src="image/main/prepare.png" width="65px;" ></c:when>
			<c:when test="${(dto.status).equalsIgnoreCase('ongoing')}"><div class="ref" style="position: absolute;"><div class="stat" style="position: relative;top: -240px;left: 165px;z-index:1;"><img src="image/main/ongoing.png" width="65px;"></div></div></c:when>
			<c:when test="${(dto.status).equalsIgnoreCase('complete_success')}"><img src="image/main/complete.png" width="65px;">(성공)</c:when>
			<c:when test="${(dto.status).equalsIgnoreCase('complete_fail')}"><img src="image/main/complete.png" width="65px;">(실패)</c:when>
			<c:when test="${(dto.status).equalsIgnoreCase('delete')}">삭제된 게시글</c:when>
			</c:choose>
		</div>
	</td>
	</tr>
	
	<tr>
	<td colspan="2" style="padding: 10px;text-align: center;width: 90%;">
	
	<a href="projectDetail.do?seq=${dto.seq }">
	<!-- 50자수 제한 -->
	<c:set var="str" value="${dto.title }"/>
	<c:set var="len" value="${fn:length(str)}"/>
	<c:choose>
	<c:when test="${len ge 50}"><strong>${fn:substring(str,0,50) } ...</strong></c:when>
	<c:otherwise><strong>${str }</strong></c:otherwise>
	</c:choose>
	</a>
	</td>
	</tr>
	
	<tr>
	<td colspan="2" style="text-align: right;margin-right: 50px;">by ${dto.nickname }</td>
	</tr>
	
	<tr>
	<td colspan="2" style="text-align: right;"><span title="모금액"><fmt:formatNumber value="${dto.fundachived }" type="number"/> 원</span>&nbsp;/&nbsp;<span title="목표 금액"><fmt:formatNumber value="${dto.goalfund }" type="number"/> 원</span></td>
	</tr>
	
	<tr>
	<td colspan="2">
	</td>
	</tr>

	</table>
	<hr>


</div>
</c:forEach>
</c:if>
</div>
</div>
