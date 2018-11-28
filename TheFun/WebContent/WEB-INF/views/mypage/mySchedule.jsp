<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:requestEncoding value="utf-8"/> 
<!-- 스케쥴 css -->
<link rel="stylesheet" href="CSS/Calendar/calendar.css">
<script type="text/javascript" src="CSS/Calendar/schedule.js"></script>
<link href="CSS/detailcss/blog-post.css" rel="stylesheet">
 
<style type="text/css">
body{
font-family: "Nanum Gothic", sans-serif;
}
</style>

<header id="cal_header">
  <div class="container text-center">
    <h1 class="head_title">My Scheduler</h1>
    <p>일  정</p>
  </div>
</header>

<section class="timeline" id="cal_timeline">

<c:if test="${schedule.size() ne 0}">
<c:forEach items="${schedule }" var="sche" varStatus="i">

  <div class="container">
  
    <div class="timeline-item">
      <div class="timeline-img"></div>

      <div class="timeline-content js--fadeInLeft">
        <br><br><h2>${sche.title }</h2>
        <div class="date"> ${sche.getDateForm(sche.sdate) } ~ ${sche.getDateForm(sche.edate) }</div>
        <div style="text-align: right;">
			<!-- 진행 상태 status 한글화 -->
			<c:choose>
				<c:when test="${(sche.status).equalsIgnoreCase('waiting')}">승인 대기 중</c:when>
				<c:when test="${(sche.status).equalsIgnoreCase('preparing')}">준비 중</c:when>
				<c:when test="${(sche.status).equalsIgnoreCase('ongoing')}">진행 중</c:when>
				<c:when test="${(sche.status).equalsIgnoreCase('complete_success')}">완료됨(성공)</c:when>
				<c:when test="${(sche.status).equalsIgnoreCase('complete_fail')}">완료됨(실패)</c:when>
				<c:when test="${(sche.status).equalsIgnoreCase('delete')}">삭제된 게시글</c:when>
			</c:choose>
		</div>
        
        <div style="text-align: right;">
        	<!-- 조건문 : 리워드 / 기부 구분 위해 일단은 간략하게 글씨로 -->
			<c:choose>
				<c:when test="${sche.fundtype.equalsIgnoreCase('reward')}">리워드</c:when>
				<c:when test="${sche.fundtype.equalsIgnoreCase('donation')}">기부</c:when>
			</c:choose> : 
			<c:choose>
				<c:when test="${sche.category.equalsIgnoreCase('food')}">음식</c:when>
				<c:when test="${sche.category.equalsIgnoreCase('animal')}">동물</c:when>
				<c:when test="${sche.category.equalsIgnoreCase('it')}">IT</c:when>
				<c:when test="${sche.category.equalsIgnoreCase('human')}">인권</c:when>
			</c:choose>
     	</div> 
        <div style="text-align: right;">결제일 : ${sche.getDateForm(sche.pdate) }</div>
        <div style="text-align: right;">배송일 : ${sche.getDateForm(sche.shipdate) }</div>
        <p>${sche.summary }</p>
        <a class="bnt-more" href="javascript:void(0)">해당디테일</a>
        
      </div>
    </div>

    <div class="timeline-item">
      <div class="timeline-img"></div>
      <div class="timeline-content timeline-card js--fadeInRight">
        
        <br><br><h2>후원도 같이 나와도 될...<%-- ${schedule.title } --%></h2>
        <div class="date">시작날~끝날<%-- ${schedule.sdate } --%></div>
        <div style="text-align: right;">진행중</div>
        <div style="text-align: right;">Reward : IT</div> 
        <div style="text-align: right;">결제일 : 0000-00-00</div>
        <div style="text-align: right;">배송일 : 0000-00-00</div>
        <p>이것은 한줄 소개 테스트입니다.<%-- ${schedule.summary } --%></p>
        <a class="bnt-more" href="javascript:void(0)">해당 디테일</a>
        
      </div>
    </div>
<!------------------------------왼쪽-오른쪽-한-세트------------------------------------------->
  </div>
</c:forEach>
</c:if>  
</section>
