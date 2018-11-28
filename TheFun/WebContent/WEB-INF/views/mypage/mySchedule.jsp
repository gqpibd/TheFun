<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:requestEncoding value="utf-8"/> 
<!-- 스케쥴 css -->
<link rel="stylesheet" href="CSS/Calendar/calendar.css">
<!-- Custom styles for this template -->
<link href="CSS/detailcss/blog-post.css" rel="stylesheet">
 
<style type="text/css">

body{
font-family: "Nanum Gothic", sans-serif;
}
</style>

<header id="cal_header">
  <div class="container text-center">
    <h1 class="head_title">MY PROJECT</h1>
    <p>프로젝트</p>
  </div>
</header>

<body>
<!-- 등록한 프로젝트가 없을때 -->
<c:if test="${schedule.size() eq 0}">
<br><br>
<p style="text-align: center;">등록하신 프로젝트가 없습니다.</p>
</c:if>

<!-- 등록한 프로젝트가 있다 -->
<c:if test="${schedule.size() ne 0}">
<section class="timeline" id="cal_timeline">
<div class="container">
<c:forEach items="${schedule }" var="sche" varStatus="vStat" begin="1" end="${schedule.size()}" step="1">
     
     <!-- 홀수일때 왼쪽에 나타나게 하기 -->
     
     <div class="timeline-item">
      <div class="timeline-img"></div>

      <div class="timeline-content">
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
        
        <a class="bnt-more" href="projectDetail.do?seq=${sche.seq }">More</a>      
        <a class="bnt-more" href="projectUpdate.do?seq=${sche.seq }">Update</a>      
      </div>
    </div>    
<!------------------------------------------------------------------------->
</c:forEach>

</div>
</section>
</c:if>  
</body>