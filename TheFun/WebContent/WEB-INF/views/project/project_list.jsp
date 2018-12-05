	<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:requestEncoding value="utf-8"/>   
<!-- <link href="CSS/detailcss/blog-post.css" rel="stylesheet"> -->
<style>

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
	padding-left: 5px;padding-right: 5px;vertical-align: middle;
}

.shadooooow{
	box-shadow:3px 3px 3px 3px #80808030;
}

</style>



<div class="container" style="background-color: #fff;">
<div class="row">
<c:if test="${list.size() ne 0}">
<c:forEach items="${list }" var="dto" varStatus="i">
<div class="col-md-3 col-sm-6 mb-4" onmouseover="shadow(this)" onmouseout="noShadow(this)" style="padding:10px;border-left: 1px solid #80808030;border-right: 1px solid #80808030;border-top: 1px solid #80808030;border-bottom: 1px solid #80808030;padding: 10px;background-color: white;">
	<table style="height: 480px;table-layout: fixed;cursor: pointer;" onclick="location.href='projectDetail.do?seq=${dto.seq }'">
	<col width="30%;"><col width="70%">
	<tr>
	<td style="text-align: left;">
	<!-- 조건문 : 리워드 / 기부 구분 위해 -->
	<span>
	<c:choose>
		<c:when test="${dto.fundtype.equalsIgnoreCase('reward')}"><img src="image/main/reward.png" width="80px;"></c:when>
		<c:when test="${dto.fundtype.equalsIgnoreCase('donation')}"><img src="image/main/donaIcon.png" width="80px;"></c:when>
	</c:choose>
	
	</span>
	</td>
	<td style="text-align: right;position: relative;top:11%;right:5%;padding: 0px;margin: 0px;">
	<span>
		<c:choose>
		<c:when test="${dto.isWaiting()}">승인 대기 중</c:when>
		<c:when test="${dto.isPreparing()}"><img src="image/main/prepare.png" width="65px;" ></c:when>
		<c:when test="${dto.isOngoing()}"><img src="image/main/ongoing.png" width="65px;"></c:when>
		<c:when test="${dto.isComplete_success()}"><img src="image/main/complete.png" width="65px;"></c:when>
		<c:when test="${dto.isComplete_fail()}"><img src="image/main/complete.png" width="65px;"></c:when>
		<c:when test="${dto.isDeleted()}">삭제된 게시글</c:when>
		</c:choose>
	</span>
	</td>
	
	</tr>
	
	<tr style="height: 20px;">
	<td colspan="2">
		<span style="text-align: left;">
		<img class="img-fluid" style="width:100%;height:250px;object-fit: cover;overflow:hidden" src="upload/${dto.seq}" alt="프로젝트 썸네일" onerror="this.onerror=null;this.src='image/main/mainImg7.PNG'">
		</span>
	</td>
	</tr>
	
	<tr>
	<td colspan="2" style="font-size: 11pt;word-break:break-all;height: 100px;">
	<!-- 60 제한 -->
	<c:set var="str" value="${dto.title }"/>
	<c:set var="len" value="${fn:length(str)}"/>
	<c:choose>
	<c:when test="${len ge 60}"><strong>&nbsp;${fn:substring(str,0,60) } ...</strong></c:when>
	<c:otherwise><strong>&nbsp;${str }</strong></c:otherwise>
	</c:choose>
	</td>
	</tr>
	
	<tr class="features">
	<td style="text-align: left;"><span title="참여자 수"><strong>&nbsp;${dto.buycount }명</strong> 참여</span></td>
	<td style="text-align: right;margin-right: 50px;" title="프로젝트 진행자">by ${dto.nickname }&nbsp;</td>
	</tr>
	
	<tr class="features">
	<td style="text-align: left;">

	<!-- 남은날짜계산 -->
	<jsp:useBean id="toDay" class="java.util.Date"/>
	<fmt:parseNumber value="${toDay.time / (1000*60*60*24)}" integerOnly="true" var="toDayDate"></fmt:parseNumber>
	<fmt:parseDate value="${dto.edate }" var="endDate" pattern="yyyy-MM-dd HH:mm:ss"/>
	<fmt:parseNumber value="${endDate.time / (1000*60*60*24)}" integerOnly="true" var="endDate"></fmt:parseNumber>
	<fmt:parseDate value="${dto.sdate }" var="startDate" pattern="yyyy-MM-dd HH:mm:ss"/>
	<fmt:parseNumber value="${startDate.time / (1000*60*60*24)}" integerOnly="true" var="startDate"></fmt:parseNumber>
	
	<span title="프로젝트 남은 기간">
	<c:choose>
		<c:when test="${dto.isPreparing()}"><strong>&nbsp;${startDate - toDayDate + 1}일</strong> 후 시작</c:when>
		<c:when test="${(endDate - toDayDate + 1)>1}"><strong>&nbsp;${endDate - toDayDate + 1}일</strong> 남음</c:when>
		<c:when test="${(endDate - toDayDate + 1)==1}"><font color="red">&nbsp;오늘 마감</font></c:when>
		<c:when test="${(endDate - toDayDate + 1)<=0}"><strong>&nbsp;종료</strong></c:when>
	</c:choose>
	</span>
	</td>
	<td style="text-align: right;"><span title="모금액"><fmt:formatNumber value="${dto.fundachived }" type="number"/> 원&nbsp;(<fmt:formatNumber value="${(dto.fundachived div dto.goalfund * 100) }" type="number" pattern="0.0"/>%)</span><%-- &nbsp;/&nbsp;<span title="목표 금액"><fmt:formatNumber value="${dto.goalfund }" type="number"/> 원</span> --%></td>
	</tr>
	
	<!-- 차트 -->
	<tr>
	<td colspan="2">
		<div class="charts" style="margin-left: 2%;margin-right: 2%;">
		<div class="charts__chart chart--p100 chart--inverse chart--sm" >
		<!-- 퍼센트가 80% 미만일 때 -->
		<c:if test="${(dto.fundachived div dto.goalfund * 100 lt 80) }">
		<div align="right" class="charts__chart chart--yellow chart--sm" title="${(dto.fundachived div dto.goalfund * 100) }%" style="width: ${(dto.fundachived div dto.goalfund * 100) }%; max-width:100%;">
		</div>
		</c:if>
		<!-- 퍼센트가 80% 이상 100% 미만일 때 색 빨강색이 별로라기에 chart--yellow 에서 변경하지 않았음-->
		<c:if test="${(dto.fundachived div dto.goalfund * 100 ge 80 && dto.fundachived div dto.goalfund * 100 lt 100) }">
		<div align="right" class="charts__chart chart--yellow chart--sm" title="${(dto.fundachived div dto.goalfund * 100) }%" style="width: ${(dto.fundachived div dto.goalfund * 100) }%; max-width:100%;">
		</div>
		</c:if>
		<!-- 퍼센트 100% 이상일 때 -->
		<c:if test="${(dto.fundachived div dto.goalfund * 100 ge 100) }">
		<div align="right" class="charts__chart chart--green chart--sm" title="${(dto.fundachived div dto.goalfund * 100) }%" style="width: ${(dto.fundachived div dto.goalfund * 100) }%; max-width:100%;">
		</div>
		</c:if>
		
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



<script>
// 그림자
function shadow(tableOne) {
	$(tableOne).addClass("shadooooow");
}
// 그림자 삭제
function noShadow(tableOne) {
	$(tableOne).removeClass("shadooooow");
}

</script>
