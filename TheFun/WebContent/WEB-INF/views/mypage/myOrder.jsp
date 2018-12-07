<%@page import="donzo.thefun.model.ProjectDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:requestEncoding value="utf-8"/>    

<link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css">
<link rel="stylesheet" href="CSS/mainCss/myOrder.css">
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

<header class="line_header">
  <div class="container text-center">
    <h1 class="head_title">MY SUPPORT</h1>
    <p>내 후원</p>
  </div>
</header>

<br><br>

<table class="type07" id="myOrderlist">
	<col width="200">
	<col width="360">
	<col width="150">
	<col width="150">
	<col width="150"> 
	<thead>
		<c:if test="${empty orderlist }">
		<tr>
			<th colspan="6">후원 내역이 없습니다</th>
		</tr>	
		</c:if>
	</thead>
	
	<thead>
		<c:if test="${not empty orderlist }">
		<tr>
			<th>후원일자</th>
			<th colspan="2">후원 프로젝트 정보</th>
			<th>후원금액(수량)</th>
			<th>작성자</th>
			<th>상태</th>
			<!-- <th>추가할 어떤 것</th> -->
		</tr>	
		</c:if>
	</thead><!-- head -->
	
	<tbody>
	<c:forEach items="${orderlist}" var="order" varStatus="vs">
	<!--  class="hover_tr" style="cursor:pointer" onclick="location.href='projectDetail.do?seq=${order.projectseq}'" -->
	
	<c:if test="${order.isDeleted() eq false }">
			<tr>
			<!-- 후원 일자 : 펀딩일 결제일 -->
			<td>		
				<div>후원 날짜 : ${order.getDateForm(order.regdate)}</div>
				<div>결제 날짜 : ${order.getDateForm(order.pdate) }</div>
				<div><a href="myOrderDetail.do?projectSeq=${order.projectseq}">상세내역</a></div>
			</td>
			
			<!-- 프로젝트 정보 : 썸네일 , 제목-옵션이름 -->
			<td colspan="2" >
				<div class="proTitle" style="cursor:pointer; font-weight: bold;" onclick="location.href='projectDetail.do?seq=${order.projectseq}'">
					<img alt="썸네일이미지" src="upload/${order.projectseq }" style="border-radius: 50%; height: 30px;">
					<c:choose>
						<c:when test="${order.otitle eq null }">[기부]</c:when>
						<c:otherwise>[리워드]</c:otherwise>
					</c:choose>
					${order.dot3(order.ptitle) }
				</div>
				<div class="opTitle" style="cursor:pointer" onclick="location.href='projectDetail.do?seq=${order.projectseq}'">${order.otitle }</div>
			</td>
			
			<!-- 총 금액 ( 수량 ) -->
			<td>
				<div>총 <fmt:formatNumber value="${order.price * order.count}" type="number"/>원</div>
				 <div>(${order.count }개)</div>
			</td>
			
			<!-- 프로젝트 작성자 -->
			<td>${order.id }</td>
			
			<!-- 프로젝트 상태 -->
			<td>
				<div>
					<c:choose>										
						<c:when test="${order.isOngoing()}">진행 중</c:when>
						<c:when test="${order.isComplete_success()}">
							<c:choose>
								<c:when test="${order.otitle eq null || order.score ne null}">구매 확정</c:when>
								<c:otherwise>
									<button type="button" id="latter" onclick="addReview(${order.seq},${order.price * order.count})">후기작성</button>					
								</c:otherwise>
							</c:choose>
						</c:when>
						<c:when test="${order.isComplete_fail()}">목표 미달성</c:when>
						<c:otherwise> 
							${order.status} 
						</c:otherwise>
					 </c:choose>
				 </div>					 	
			</td>
			<!-- 뭔가 더 추가할 어떤것 -->
		</tr>
	</c:if>
	
	</c:forEach>
	<tbody>

</table>

<div id="paging_wrap">	
	<jsp:include page="/WEB-INF/views/mypage/myPaging.jsp" flush="false">
		<jsp:param value="${pageNumber }" name="pageNumber"/>		
		<jsp:param value="${pageCountPerScreen }" name="pageCountPerScreen"/>
		<jsp:param value="${recordCountPerPage }" name="recordCountPerPage"/>
		<jsp:param value="${totalRecordCount }" name="totalRecordCount"/>	
	</jsp:include>	
</div>
 
</div>

<script type="text/javascript">
function addReview(seq,buytotal) { // 후기 작성
	$("input[name='seq']").val(seq);
	console.log($("input[name='seq']").val());
	$("input[name='point']").val(buytotal*0.01);
	$("#newPoint").text(buytotal*0.01);
	console.log($("input[name='point']").val());	
	$("#feedbackModal").modal('show');
}

$(".hover_tr").mouseover(function () {
	$(this).find("td").css("background-color","#F7EEF8");
	//$(this.td).first().css("background-color","#8152f0");
}).mouseout(function () {
	$(this).find("td").css("background-color","#ffffff");	
	//$(this).first().css("background-color","#8152f0");
});

//textarea 자동 크기 조절			
//동적으로 생성된 태그에 이벤트를 적용하기 위해서는 $(document).on()으로 해줘야 한다.
//$(".wrap").on('keyup', 'textarea',function(e){ --> 이렇게 하면 원래 있던 태그에만 적용됨
$(document).on('keyup', 'textarea',".wrap",function(e){
	$(this).css('height', 'auto' );
	$(this).height( this.scrollHeight );
});
$('.wrap').find( 'textarea' ).keyup();

/* 리뷰창 내용 유효성 확인 후 전송 */
function checkAndSendReview(){
	var score = $(":input:radio[name='score']:checked").val();
	var bcomment = $("textarea[name='bcomment']").val();
	console.log(score);
	console.log(bcomment);
	if(score == null){
		alert("평가를 남겨주세요");
		return;
	}
	$("#reviewForm").submit();
}

</script>


<!-- 별점 및 후기 남기는 부분 모달창 -->
<div class="modal fade" id="feedbackModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header" style="display: unset;">
	      <h5 class="modal-title" id="exampleModalLabel">리워드에 대한 후기를 남겨주세요</h5>
	    </div>
		<div class="cont">
		<form id="reviewForm" action="writeReview.do" method="post">
			<input type="hidden" name="point" />
			<input type="hidden" name="id" value="${login.id}" />
			<div class="stars">
			  <input type="hidden" name="seq"> <!-- buydto에 저장을 위한 임시 값 -->
			  <input class="star star-5" id="star-5-2" type="radio" name="score" value="5"/>
			  <label class="star star-5" for="star-5-2"></label>
			  <input class="star star-4" id="star-4-2" type="radio" name="score" value="4"/>
			  <label class="star star-4" for="star-4-2"></label>
			  <input class="star star-3" id="star-3-2" type="radio" name="score" value="3"/>
			  <label class="star star-3" for="star-3-2"></label>
			  <input class="star star-2" id="star-2-2" type="radio" name="score" value="2"/>
			  <label class="star star-2" for="star-2-2"></label>
			  <input class="star star-1" id="star-1-2" type="radio" name="score" value="1"/>
			  <label class="star star-1" for="star-1-2"></label>
			  <div class="rev-box">
			    <textarea class="review" col="30" name="bcomment" placeholder="제품에 대한 평가를 적어주세요"></textarea>		    
			  </div>			
			</div>
	    </form>
		</div>
		<div style="text-align: center; margin-bottom: 20px;">구매 확정시 적립 포인트: <span id="newPoint" style="font-weight: bold"></span> 점</div> 
		<div class="modal-footer">
	        <button type="button" class="cancel_btn" data-dismiss="modal" id="quit">취소</button>
	        <button type="button" class="fun_btn" onclick="checkAndSendReview()">후기 전송</button>	       
	    </div>
		</div>
</div>
</div>


<!-- 본문출력 묶는 태그 -->
	</main>
	</div> 
<!-- //본문출력 묶는 태그 -->