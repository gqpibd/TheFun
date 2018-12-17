<%@page import="donzo.thefun.model.ProjectDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8"/>
<style type="text/css">
.Fee{
	background-color:transparent;
	border:none;
	text-align:left;
}
</style>

<header class="line_header">
  <div class="container text-center" style="padding-top: 50px;">
    <h1 class="head_title">MY FUNDING DETAIL</h1>
    <p>후원 상세 내역</p>
  </div>
</header>


<div style="padding-left: 10%; padding-top: 20px;">
<h2>주문상세정보</h2>
<p>주문일자 : 	${buydto[0].getDateKr()}
</p>
<table style="width: 70%">
<tr style="border-bottom: 1px solid gray;">
	<td colspan="2" style="padding: 10px;">
	<c:if test="${buydto[0].optionseq ne 0}">리워드정보</c:if>
	<c:if test="${buydto[0].optionseq eq 0}">기부</c:if>
	</td>
	<td style="padding: 10px;">
		<c:if test="${buydto[0].optionseq ne 0}">리워드금액 (수량)</c:if>
		<c:if test="${buydto[0].optionseq eq 0}">기부금액</c:if>
	</td>
	<td style="padding: 10px;">진행상태</td>
</tr>
<c:forEach items="${buydto}" var="buy">
<tr style="border-bottom: 1px solid gray;">
	<td style="padding: 10px;"><img src="upload/${buy.projectseq}" height="80px;"></td>
	<td style="padding: 10px;">
		<b style="text-align: center;">${buy.ptitle}</b><br>
		${buy.otitle}<br>  
		<c:if test="${buydto[0].optionseq ne 0}">
		<c:forEach items="${fn:split(buy.ocontent,'/')}" var="item">
		 <li>${item}</li>
		</c:forEach>
		</c:if>
	</td>
	<td style="padding: 10px;">
		<font><fmt:formatNumber value="${buy.price}" type="number"/></font>원
		<c:if test="${buydto[0].optionseq ne 0}">(${buy.count}개)</c:if> 
	</td>
	<td style="padding: 10px;">
		<c:if test="${buy.status eq ProjectDto.ONGOING}">
			결제대기 <br>
			<button type="button" onclick="deleteBuy(${buy.seq})">예약취소</button>
		</c:if>
		<c:if test="${buy.status eq ProjectDto.COMPLETE_SUCCESS}">
			결제완료
		</c:if>
		<c:if test="${buy.status eq ProjectDto.COMPLETE_FAIL}">
			결제취소
		</c:if>
	</td>
</tr>
</c:forEach>
</table>

<br><br>
<h3>결제상세정보</h3>

<!-- 총주문금액 설정 -->
<c:set var="totalprice" value="0"/>
<c:forEach items="${buydto}" var="buy">
	<c:set var="process" value="${buy.price * buy.count }"/>
	<c:set var="totalprice" value="${totalprice + process}"/>
</c:forEach>

<table style="width: 70%;">
<tr style="border-bottom: 1px solid gray;">
	<td width="20%" style="padding: 10px; ">
	<c:if test="${buydto[0].optionseq ne 0}">상품금액</c:if>
	<c:if test="${buydto[0].optionseq eq 0}">기부금액</c:if>
	</td>
	<td style="text-align: left; padding: 10px;"><fmt:formatNumber value="${totalprice}" type="number"/>원</td> 
</tr>

<c:if test="${empty buydto[0].ocontent}">	<!-- 기부일때 -->
<tr style="border-bottom: 1px solid gray;">	
	<td style="padding: 10px;">할인금액</td> <!-- 포인트사용 내역 -->
	<td style="text-align: left;padding: 10px; ">${buydto[0].usepoint} 원</td>
</tr>
</c:if>

<tr style="border-bottom: 1px solid gray;">
	<td style="padding: 10px;padding: 10px; ">결제예정금액</td>
	<td style="text-align: left;padding: 10px; ">	<!-- 포인트 db생기면 - 포인트 추가 -->
	<b style="color: #8152f0;"><fmt:formatNumber value="${totalprice-buydto[0].usepoint}" type="number"/>원</b>
	</td>
</tr>
<c:if test="${totalprice-buydto[0].usepoint ne 0}">
<tr style="border-bottom: 1px solid gray;">
	<td style="padding: 10px;padding: 10px; ">결제예정수단</td>
	<td  style="padding: 10px;padding: 10px; ">${buydto[0].bankName} 
	(${fn:substring(buydto[0].cardNumber,0,4) } - ${fn:substring(buydto[0].cardNumber,4,6)}** - **** - **** )</td>
</tr>
</c:if>
</table>

<c:if test="${not empty buydto[0].ocontent}">	<!-- 리워드라면 배송지 표시 -->
<br><br>
<h3>배송지 정보</h3>
<table style="width: 70%">
<tr style="border-bottom: 1px solid gray;">
	<td style="width: 15%; padding: 10px;">수령인 </td>
	<td style="padding: 10px;">${buydto[0].name} </td>
</tr>
<tr style="border-bottom: 1px solid gray;">
	<td style="width: 15%; padding: 10px;">연락처</td>
	<td style="text-align: left; padding: 10px;">${buydto[0].phone} </td>
</tr>
<tr style="border-bottom: 1px solid gray;">
	<td style="width: 15%; padding: 10px;">배송지</td>
	<td  style="padding: 10px;">${buydto[0].roadaddress}${buydto[0].detailaddress}</td>
</tr>

</table>
</c:if>

</div>


<!-- 결제취소 최종확인 모달창 -->
<div class="modal fade" id="messageModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel"><b>결제취소</b></h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>     
      <div class="modal-body">
          <div class="form-group">
            <label for="recipient-name" class="col-form-label">정말 결제를 취소하시겠습니까?</label>
          </div>       
      </div>
      <div class="modal-footer">
        <button type="button" class="btn cancel_btn" data-dismiss="modal" id="exit">아니오</button>
        <button type="button" class="btn fun_btn" onclick="checkAndResubmitProject()">네</button>
        <input type="hidden" id="deleteSeq">
      </div>
    </div>
  </div>
</div>


<script>
function deleteBuy(seq) {
	// 정말 삭제할지 물어보는 모달창
	$("#messageModal").modal('show');
	$("#deleteSeq").val(seq);
}
// 실제 삭제
function checkAndResubmitProject(){
	var seq = $("#deleteSeq").val();
	location.href="deleteBuy.do?seq="+seq;
}

</script>

<!-- 본문출력 묶는 태그 -->
	<jsp:include page="../common/footer.jsp"/>
	</main>
	</div> 
<!-- //본문출력 묶는 태그 -->