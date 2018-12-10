<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:requestEncoding value="utf-8"/> 
<!-- 스케쥴 css -->
<link rel="stylesheet" href="CSS/mainCss/calendar.css">
<!-- Custom styles for this template -->


<header class="line_header">
  <div class="container text-center">
    <h1 class="head_title">MY PROJECT</h1>
    <p>프로젝트</p>
  </div>
</header>

<p id="yoyak" style="text-align: center;">준비중 : ${preCount}건&nbsp;&nbsp;진행중 : ${onCount}건&nbsp;&nbsp;성공 : ${sucCount}건&nbsp;&nbsp;실패 : ${failCount}건</p>

<!-- 등록한 프로젝트가 없을때 -->
<c:if test="${schedule.size() eq 0}">
<br><br>
<p style="text-align: center;">등록하신 프로젝트가 없습니다.</p>
</c:if>


<!-- 등록한 프로젝트가 있다 -->
<c:if test="${schedule.size() ne 0}">
<section class="timeline" id="cal_timeline">
<div class="container">
<c:forEach items="${schedule }" var="sche">
	<c:choose>
		<c:when test="${sche.isDeleted() eq false }">
			<div class="timeline-item">
		      <div class="timeline-img"></div>
		
		      <div class="timeline-content">
		        <br><br><h2>${sche.dot3(sche.title) }</h2>
		        <div class="date"> ${sche.getDateForm(sche.sdate) } ~ ${sche.getDateForm(sche.edate) }</div>
		        <div style="text-align: right;">
					<!-- 진행 상태 status 한글화 -->
					<c:choose>
						<c:when test="${sche.isWaiting()}">승인 대기 중</c:when>
						<c:when test="${sche.isPreparing()}">준비 중</c:when>
						<c:when test="${sche.isOngoing()}">진행 중</c:when>
						<c:when test="${sche.isComplete_success()}">완료됨(성공)</c:when>
						<c:when test="${sche.isComplete_fail()}">완료됨(실패)</c:when>
						<c:when test="${sche.isDeleted()}">삭제된 게시글</c:when>
						<c:when test="${sche.isRevise() }">보안 요청</c:when>
						<c:when test="${sche.isReject() }">승인 거절</c:when>
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
		        
		        <c:choose>
		        	<c:when test="${sche.fundtype.equalsIgnoreCase('reward')}">
			        	<div style="text-align: right;">배송일 : ${sche.getDateForm(sche.shipdate) }</div>
		        	</c:when>
		        </c:choose>
		        
		        <a class="btnSche btn-more" href="projectDetail.do?seq=${sche.seq}">More</a>    
		        <!-- 준비 중일 때만 업데이트 버튼 활성화 혹은 보이기? -->
		        <c:choose>
		        	<c:when test="${sche.isWaiting() or sche.isPreparing() or sche.isRevise()}">
		        		<a class="btnSche btn-update" href="projectUpdate.do?seq=${sche.seq }">Update</a>
		        		<a class="btnSche btn-delete" href="projectDelete.do?seq=${sche.seq }">Delete</a>		        	
		        	</c:when>
		        	<c:when test="${sche.isReject()}">
		        		<a class="btnSche btn-delete" href="projectDelete.do?seq=${sche.seq }">Delete</a>		        	 
		        	</c:when>
		        </c:choose>  
		      </div>
		    </div> 
		</c:when>
		<c:otherwise>
			
		</c:otherwise>
	</c:choose>
  	   
<!------------------------------------------------------------------------->
</c:forEach>

</div>
</section>
</c:if>  

<!-- 본문출력 묶는 태그 -->
</main>
</div> 
<!-- //본문출력 묶는 태그 -->