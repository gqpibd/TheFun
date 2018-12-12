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

<p id="yoyak" style="text-align: center;">승인대기중: ${waitCount}건&nbsp;&nbsp;승인거절:${rejCount}건&nbsp;&nbsp;준비중 : ${preCount}건&nbsp;&nbsp;진행중 : ${onCount}건&nbsp;&nbsp;성공 : ${sucCount}건&nbsp;&nbsp;실패 : ${failCount}건</p>

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
	<div class="timeline-item">
		<div class="timeline-img"></div>

		<div class="timeline-content">
        <br><br><h2>${sche.dot3(sche.title) }</h2>
        <div class="date"> ${sche.getDateForm(sche.sdate) } ~ ${sche.getDateForm(sche.edate) }</div>
        <div style="text-align: right;">${sche.getStatusKr()}</div>
        
        <div style="text-align: right;">${sche.getFundTypeKr()} : ${sche.getCategoryKr()}</div> 
        <div style="text-align: right;">결제일 : ${sche.getDateForm(sche.pdate)}</div>
        
        <c:choose>
        	<c:when test="${sche.isReward()}">
	        	<div style="text-align: right;">배송일 : ${sche.getDateForm(sche.shipdate)}</div>
        	</c:when>
        </c:choose>
        
        <a class="btnSche btn-more" href="projectDetail.do?seq=${sche.seq}">More</a>    
        <!-- 준비 중일 때만 업데이트 버튼 활성화 혹은 보이기? -->
        <c:choose>
        	<c:when test="${sche.isWaiting() or sche.isPreparing() or sche.isRevise()}">
        		<a class="btnSche btn-update" href="projectUpdate.do?seq=${sche.seq }">Update</a>
        		<a class="btnSche btn-delete" href="javascript:deleteProject(${sche.seq })">Delete</a>		        	
        	</c:when>
        	<c:when test="${sche.isReject()}">
        		<a class="btnSche btn-delete" href="javascript:deleteProject(${sche.seq })">Delete</a>		        	 
        	</c:when>
        </c:choose>  
      </div>
    </div>   	   
</c:forEach>

</div>
</section>
</c:if>  

<script type="text/javascript">
function deleteProject(seq){ // 프로젝트 삭제
	modalConfirm(function(confirm){
		if(confirm){
			location.href="projectDelete.do?seq=" + seq;
		}
	});
}

/* confirm창 콜백 처리 */
var modalConfirm = function(callback) {
	$("#confirmModal").modal('show');
	$("#delete").on("click", function() {
		callback(true);
		$("#confirmModal").modal('hide');
	});

	$("#cancel").on("click", function() {
		callback(false);
		$("#confirmModal").modal('hide');
	});
};
</script>

<div class="modal fade" id="confirmModal" tabindex="-1" role="dialog" aria-labelledby="confirmModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="confirmModalLabel">프로젝트 삭제</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
       	정말 프로젝트를 삭제하시겠습니까? 이 작업은 돌이킬 수 없습니다.
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal" id="cancel">취소</button>
        <button type="button" class="btn btn-primary" id="delete">삭제</button>
      </div>
    </div>
  </div>
</div>

<!-- 본문출력 묶는 태그 -->
</main>
</div> 
<!-- //본문출력 묶는 태그 -->