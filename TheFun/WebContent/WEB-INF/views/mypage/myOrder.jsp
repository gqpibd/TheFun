<%@page import="donzo.thefun.model.ProjectDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:requestEncoding value="utf-8"/>    

<link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css">

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
/* 
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
} */

.column1 {
  width: 200px;
  padding-left: 40px;
}

.column2 {
  width: 350px;
}

.column3 {
  width: 180px;
}

.column4 {
  width: 140px;
}

.column5 {
  width: 140px;
}

.funTable tbody tr {
    height: 80px;
}

</style>
<link rel="stylesheet" href="CSS/common/table.css"><!-- 위치 바뀌면 제대로 안 들음! -->
<style type="text/css">
/* 테이블 화면 작아졌을 때 */
@media screen and (max-width: 992px) {
  .funTable tbody tr td:nth-child(1):before {
     content: "후원일자";
  }
  .funTable tbody tr td:nth-child(2):before {
    content: "프로젝트 정보";
  }
  .funTable tbody tr td:nth-child(3):before {
    content: "후원금액(수량)";
  }
  .funTable tbody tr td:nth-child(4):before {
    content: "작성자";
  }
  .funTable tbody tr td:nth-child(5):before {
    content: "상태";
  }
  .funTable td.c {
    text-align: left;
  }

}
@media screen and (max-width: 700px) {
	.funTable tbody tr td {
		padding-left: 40% !important;
	} 
	.table100 {
		width: 100%;
	}
}
</style>

<header class="line_header">
  <div class="container text-center">
    <h1 class="head_title">MY FUNDING HISTORY</h1>
    <p>내 후원 내역</p>
  </div>
</header>

<br><br>
<div align="center">
<div class="container-table100">
<div class="table100">
<table class="funTable" id="myOrderlist">
	<thead>
		<tr class="table100-head">
		<c:choose>
		<c:when test="${empty orderlist}">
			<th class="column2 c">후원 내역이 없습니다</th>
		</c:when>
		<c:otherwise>
			<th class="column1 c">후원일자</th>
			<th class="column2 c">후원 프로젝트 정보</th>
			<th class="column3 c">후원금액(수량)</th>
			<th class="column4 c">작성자</th>
			<th class="column5 c">상태</th>
		</c:otherwise>
		</c:choose>
		</tr>	
	</thead><!-- head -->
	
	<tbody class="funTbody">
	<c:forEach items="${orderlist}" var="order">
	<tr>
		<!-- 후원 일자 : 펀딩일 결제일 -->
		<td class="column1 c">		
			<div>후원 날짜 : ${order.getDateForm(order.regdate)}</div>
			<div>결제 날짜 : ${order.getDateForm(order.pdate)}</div>
			<div><a href="myOrderDetail.do?projectSeq=${order.projectseq}&regiDate=${order.regdate}">상세내역</a></div>
		</td>
		
		<!-- 프로젝트 정보 : 썸네일 , 제목-옵션이름 -->
		<td class="column2">
			<div style="display: inline-flex;">
			<img src="upload/${order.projectseq }" style="border-radius: 50%; height: 50px; width: 50px; margin:5px; object-fit: cover;">
			<div class="proTitle" style="cursor:pointer; font-weight: bold; margin: auto; color: black" onclick="location.href='projectDetail.do?seq=${order.projectseq}'">					
				<c:choose>
					<c:when test="${order.otitle eq null }">[기부]</c:when>
					<c:otherwise>[리워드]</c:otherwise>
				</c:choose>
				${order.dot3(order.ptitle) }
				<div style="cursor:pointer; color:#8a7777ad;" onclick="location.href='projectDetail.do?seq=${order.projectseq}'">${order.otitle }</div>				
			</div>
			</div>
		</td>
		
		<!-- 총 금액 ( 수량 ) -->
		<td class="column3 c">
			<div>총 <fmt:formatNumber value="${order.price}" type="number"/>원</div>
			 <div>(${order.count }개)</div>
		</td>
		
		<!-- 프로젝트 작성자 -->
		<td class="column4 c">${order.id}</td>
		
		<!-- 프로젝트 상태 -->
		<td class="column5 c">
			<div>
				${order.getStatusKr()}<br>
				<c:if test="${order.otitle ne null and order.isFinished()}">
					<c:choose>
					<c:when test="${order.score eq 0}">
						<button type="button" class="fun_btn" id="latter" onclick="addReview(${order.seq},${order.price},${order.projectseq})">후기작성</button>
					</c:when>
					<c:otherwise>
					<c:forEach begin="1" end="5" step="1" var="i">
			    		<c:if test="${order.score >= i}">
			    			<span class='fas fa-star' style='color:#8152f0;font-size:0.8em;'></span>
			    		</c:if>
			    		<c:if test="${order.score < i}">
							<span class='far fa-star' style='color:#8152f0;font-size:0.8em;'></span>
			    		</c:if>
			      	</c:forEach>      
					</c:otherwise>	
					</c:choose>				
				</c:if>	
			 </div>					 	
		</td>
	</tr>
	
	</c:forEach>
	</tbody>
</table>
</div>
</div>

<div id="paging_wrap" align="center">	
	<jsp:include page="/WEB-INF/views/common/paging.jsp" flush="false">
		<jsp:param value="${pageNumber }" name="pageNumber"/>		
		<jsp:param value="${pageCountPerScreen }" name="pageCountPerScreen"/>
		<jsp:param value="${recordCountPerPage }" name="recordCountPerPage"/>
		<jsp:param value="${totalRecordCount }" name="totalRecordCount"/>	
		<jsp:param value="myOrderList.do" name="actionPath"/>	
	</jsp:include>	
</div>
 


<script type="text/javascript">
function addReview(seq,price,projectseq) { // 후기 작성
	$("input[name='seq']").val(seq);
	//console.log($("input[name='seq']").val());
	
	$("input[name='price']").val(price);
	$("input[name='projectseq']").val(projectseq);
	
	$("#newPoint").text(price*0.01);
	//console.log($("input[name='point']").val());	
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
			<!-- <input type="hidden" name="point" /> -->
			<input type="hidden" name="price"/> <!-- 가격 (포인트 적립용)-->
			<input type="hidden" name="count" value='1'/> <!-- 수량 (포인트 적립용) -- 총액으로 나오므로 수량은 무조건 1 -->
			<input type="hidden" name="projectseq"/> <!-- 알람 생성용 -->
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
	        <button type="button" class="cancel_btn" data-dismiss="modal" id="quit">취소</button><br>
	        <button type="button" class="fun_btn" onclick="checkAndSendReview()">후기 전송</button>	       
	    </div>
		</div>
</div>
</div>


<!-- 본문출력 묶는 태그 -->
	<jsp:include page="../common/footer.jsp"/>
	</main>
	</div> 
<!-- //본문출력 묶는 태그 -->