<%@page import="java.util.Calendar"%>
<%@page import="org.springframework.expression.spel.ast.OpInc"%>
<%@page import="java.util.List"%>
<%@page import="donzo.thefun.model.OptionDto"%>
<%@page import="donzo.thefun.model.ProjectDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:requestEncoding value="utf-8"/> 
 
<title>The Fun_${projectdto.title }</title>
 
<!-- 프로젝트디테일 css 링크 -->
<link rel="stylesheet" href="CSS/project/projectDetail.css">
 
 
 
<!-- Custom styles for this template -->

  
<style type="text/css">
/* 탭부분 css */
.tabSelect{ 
	background: #8152f038;
}
.tabTable{
	width: 100%;
    border-top: 1px solid rgba(0,0,0,.1);
    border-bottom: 1px solid rgba(0,0,0,.1);
    height: 50px;
    margin-top: 1em;
    margin-bottom: 1em; 
}
/* 탭부분 css 끝 */
.pnt { 
	cursor: pointer; 
}
 .pupple{
 	color:#8152f0;
 }
 .strongGray{
  color: #5c5c5c;
  
 }
 .liteGray{
	 color: #c4c4c4;
 }

.imgTd {
	text-align: right;
	padding: 20px;
	width: 60%;
}
.sTd{
	text-align:left;
	width: 40%;
	padding: 10px;
}


/* 회사 이미지 */
.profile_img {
	float: none;
	width: 120px;
	height: 120px;
	border-radius: 50%;
	margin: 4px;
	vertical-align: middle;
	object-fit: cover;
}

/* 라디오버튼 - 승인거절시 */
.option-input {
	-webkit-appearance: none;
	-moz-appearance: none;
	-ms-appearance: none;
	-o-appearance: none;
	appearance: none;
	position: relative;
	top: 13.33333px;
	right: 0;
	bottom: 0;
	left: 0;
	height: 40px;
	width: 40px;
	transition: all 0.15s ease-out 0s;
	background: #cbd1d8;
	border: none;
	color: #fff;
	cursor: pointer;
	display: inline-block;
	margin-right: 0.5rem;
	outline: none;
	position: relative;
	z-index: 1000;
}

.option-input:hover {
  background: #9faab7;
}

.option-input:checked {
  background: #40e0d0;
}

.option-input:checked::before {
	height: 40px;
	width: 40px;
	position: absolute;
	content: '✔';
	display: inline-block;
	font-size: 26.66667px;
	text-align: center;
	line-height: 40px;
}

.option-input:checked::after {
	-webkit-animation: click-wave 0.65s;
	-moz-animation: click-wave 0.65s;
	animation: click-wave 0.65s;
	background: #40e0d0;
	content: '';
	display: block;
	position: relative;
	z-index: 100;
}

.option-input.radio {
	border-radius: 50%;
}

.option-input.radio::after {
	border-radius: 50%;
}

.label {
	display: block;
	line-height: 40px;
}
</style>

<!-- 남은날짜계산 -->
<jsp:useBean id="toDay" class="java.util.Date"/>
<fmt:parseNumber value="${toDay.time / (1000*60*60*24)}" integerOnly="true" var="nowDate"></fmt:parseNumber>
<fmt:parseDate value="${projectdto.edate }" var="endDate" pattern="yyyy-MM-dd HH:mm:ss"/>
<fmt:parseNumber value="${endDate.time / (1000*60*60*24)}" integerOnly="true" var="endDate"></fmt:parseNumber>
<fmt:parseDate value="${projectdto.sdate }" var="sDate" pattern="yyyy-MM-dd HH:mm:ss"/>
<fmt:parseNumber value="${sDate.time / (1000*60*60*24)}" integerOnly="true" var="startDate"></fmt:parseNumber>

 <!-- 카테고리 , 태그 -->
    <div class="container">
    <div align="center">
    <c:if test="${login ne null}">
 	    <c:if test="${projectdto.isWaiting() and login.isManager()}"> <%-- 상태가 대기중 이면서 관리자가 로그인해서 보는 경우 --%>
 	    	<button class="fun_btn" onclick="location.href='approve.do?projectseq=${projectdto.seq}'">프로젝트 승인</button> 
 	    	<button class="fun_btn" data-toggle="modal" data-target="#messageModal">프로젝트 승인 거절</button>
 	    </c:if>
 	    <c:if test="${login.id.equals(projectdto.id) or login.isManager()}">
 	    	<button class="fun_btn" onclick="viewStatus()">상태확인</button>
 	    </c:if>
 	</c:if>
    </div>
   	<br>
   	<div align="center">   		
   		<p><b class="pupple">${projectdto.getCategoryKr()} </b>&nbsp;&nbsp;&nbsp;
   		<font class="strongGray">	
   		 <c:forEach items="${projectdto.tags }" var="tags">
   		 	#${tags }
   		 </c:forEach>
   		 </font></p>
   		 <p class="strongGray" style="font-size: 27px">${projectdto.title }</p>

<!-- 프로젝트 타이틀 -->
		<table style="width: 100%;" id="sTable" >
		<tr height="50">
			<td rowspan="5" class="imgTd" align="center"> <img src="upload/${projectdto.seq}" width="600px;"></td>
			<td class="strongGray sTd"  >
			<c:if test="${projectdto.isPreparing()}">
				 	<b style="font-size: 25px">${startDate-nowDate+1}일후 시작</b>
			</c:if>
			<c:if test="${projectdto.isComplete_success() or projectdto.isComplete_fail()}">	
				 	<b style="font-size: 25px">종료된 리워드</b>
			</c:if>
			<c:if test="${projectdto.isOngoing()}">
				 <c:if test="${(endDate - nowDate)==0}">
				 <b style="font-size: 25px">오늘마감</b>
				 </c:if>
				 <c:if test="${(endDate - nowDate)>0}">
				 <b style="font-size: 25px">${endDate-nowDate}일 남음</b>
				 </c:if>
			</c:if>
			</td>
		</tr>
		<tr height="50">
			<td class="strongGray sTd">
				<b style="font-size: 20px"><fmt:formatNumber value="${(projectdto.fundachived div projectdto.goalfund)*100 }" pattern="0"/>
				</b>% 달성
			</td>
		</tr>
		<tr height="50">
			<td class="strongGray sTd">
			<b style="font-size: 20px"><fmt:formatNumber value="${projectdto.fundachived }" type="number"/></b>&nbsp;원 펀딩
		</tr>
		<tr height="50">
			<td class="strongGray sTd"><b style="font-size: 20px">${projectdto.buycount}</b>명의 서포터
		</tr>
		<tr height="50">		
			<td> <img class="pnt" id="hartBtn" height="50" src="image/detail/hart_${isLike=='true'?'red':'gray'}.jpg"onclick="heartClick(this)"/><span id="likeCount">${projectdto.likecount}</span><!-- 하트 버튼 -->
				명이 좋아합니다
			</td>
		</tr>
		<tr height="50">
			<td class="strongGray imgTd">${projectdto.summary } &nbsp;&nbsp;</td>
			<td>
				<select style="width: 70%; height: 30px;" id="optionSelect">
					<option selected="selected" id="beginS" value="beginS">옵션을 선택해주세요</option>
					<c:forEach items="${optionList }" var="opselect">
						<option id="select_${opselect.seq}" value="${opselect.seq}">${opselect.title }</option>
					</c:forEach>
				</select>
			</td>
		</tr>
		<tr>
		<td></td>
			<c:if test="${projectdto.isOngoing()}">
			<td>
				<%-- <a href="addBasket.do?proSeq=${projectdto.seq }&id=${login.id}&opSeq&count"> --%>
					<img data-toggle="modal" data-target="#exampleModal" data-whatever="@mdo" class="pnt" height="50" src="image/detail/addcart3.jpg"/><!-- 장바구니 버튼 -->
				<!-- </a> -->
				<a href="goSelectReward.do?seq=${projectdto.seq }&type=${projectdto.fundtype}">
					<img src="image/detail/fundBtn.jpg" height="20px"> <!-- 펀딩하기 버튼 -->
				</a>
			</td>
			</c:if>
		</tr>
		<tr height="50" style="padding: 50px">
			<td align="left">
			<p class="pupple" style="font-size: 15px;">목표금액 <b><fmt:formatNumber value="${projectdto.goalfund }" type="number"/></b>원 &nbsp;&nbsp; 
				펀딩기간  <b>
				<fmt:parseDate value="${projectdto.sdate }" pattern="yyyy-MM-dd HH:mm:ss" var="sdate" />
				<fmt:formatDate value="${sdate }" pattern="yyyy.MM.dd"/>~
				<fmt:parseDate value="${projectdto.edate }" pattern="yyyy-MM-dd HH:mm:ss" var="edate" />
				<fmt:formatDate value="${edate }" pattern="yyyy.MM.dd"/></b></p>
			<b style="font-size:15 px;">100%이상 모이면 펀딩이  성공되는 프로젝트</b><br>
			<font size="2px;">이 프로젝트는 펀딩 마감일까지 목표금액이 100%모이지 않으면 결제가 진행되지 않습니다.</font></td>
			<td><div id="shareField"></div> </td>
		</tr>
		</table>
   
   
	   <!-- 모달 -->
	   <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <img src="image/main/banner.jpg" width="120px;">
	      </div>
	      <div class="modal-body">
	        <form>
	          <div class="form-group">
	            <label for="recipient-name" class="control-label">장바구니에 추가되었습니다!</label>
	            <p>이제 <strong style="color: #8052f0">'${projectdto.title }'</strong>을 장바구니에서 만나보세요</p>
	
	          </div>
	         
	        </form>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal" id="mainBtn">이 페이지에 머무르기</button>
	        <button type="button" class="btn btn-default" data-dismiss="modal" id="mypageBtn" onclick="location.href='myBasket.do?id=${login.id}'">장바구니 확인하기</button>
	      </div>
	    </div>
	  </div>
	</div>

		<!-- 메뉴바 -->
		<div style="background-color: white;">
		<!-- <div class="jbMenu"> -->
		<table class="tabTable" style="width: 100%; background-color: white;">
		<tr>
			<td align="center" class="strongGray tabSelect" id="story" style="width: 25%; cursor:pointer"><font class="menubar">스토리</font></td>
			<td align="center" class="strongGray" id="notice" style="width: 25%; cursor:pointer"><font class="menubar">판매자 공지<sup class="pupple" id="noticecounttab"><b>${projectdto.noticecount}</b></sup></font></td>
			<td align="center" class="strongGray" id="qna" style="width: 25%; cursor:pointer"><font class="menubar">QnA<sup class="pupple"><b>${projectdto.qnacount}</b></sup></font></td>
			<td align="center" class="strongGray" id="review" style="width: 25%; cursor:pointer"><font class="menubar">후기<sup class="pupple"><b>${projectdto.reviewcount}</b></sup></font></td>
		</tr>
		</table>
		<!-- </div> -->
	    </div>
	 </div>
	 
	 
<script type="text/javascript">
$(document).ready(function () {
	$("#qnaContent").hide();
	$("#noticeContent").hide();
	$("#reviewContent").hide();
	
	$("#optionSelect").change(function(){
	   var selectOptionSeq =  $(this).val();  //선택된 옵션 시퀀스 
	   //옵션 시퀀스 값 얻어서 테블 밑에 td 더 생성 / x 누르면 remove
	   $('#optionSelect').val('beginS');	//기본값으로 되돌림
	});
});

//마우스커서 모양변환
$(".menubar").mouseover(function () {	
	$(this).css("cursor","pointer");
}); 

//show and hide
$(function () {
	$("#story").click(function () {
		$("#storyContent").show();		
		$("#noticeContent").hide();
		$("#qnaContent").hide();
		$("#reviewContent").hide();		

		$("#story").addClass("tabSelect");		
		$("#notice").removeClass("tabSelect");		
		$("#qna").removeClass("tabSelect");	
		$("#review").removeClass("tabSelect");	
	});
	$("#notice").click(function () {
		$("#storyContent").hide();
		$("#noticeContent").show();
		$("#qnaContent").hide();
		$("#reviewContent").hide();
		
		$("#story").removeClass("tabSelect");	
		$("#notice").addClass("tabSelect");		
		$("#qna").removeClass("tabSelect");	
		$("#review").removeClass("tabSelect");	
	});
	$("#qna").click(function () {
		$("#storyContent").hide();
		$("#noticeContent").hide();
		$("#qnaContent").show();
		$("#reviewContent").hide();
		
		$("#story").removeClass("tabSelect");	
		$("#notice").removeClass("tabSelect");	
		$("#qna").addClass("tabSelect");		
		$("#review").removeClass("tabSelect");	
	});
	$("#review").click(function () {
		$("#reviewContent").show();
		$("#storyContent").hide();
		$("#noticeContent").hide();
		$("#qnaContent").hide();
		
		$("#story").removeClass("tabSelect");	
		$("#notice").removeClass("tabSelect");	
		$("#qna").removeClass("tabSelect");	
		$("#review").addClass("tabSelect");		
	});
});

function heartClick(selector){	
	var img1 = document.getElementById('hartBtn');
	
	if ('${login.id}' == ''){
		location.href="login.do?callback=projectDetail.do?seq=${projectdto.seq}";
	} else {			
		$.ajax({
			url:"changeLike.do", // 접근대상
			type:"get",		// 데이터 전송 방식
			data:"id=${login.id}&projectseq=${projectdto.seq}", // 전송할 데이터
			success:function(data){
				if(data.isLike == true){ // 좋아요
					img1.src = img1.src.replace('gray', 'red');
					$("#likeCount").text(data.likeCount);
				}else{ // 좋아요 취소				
					img1.src = img1.src.replace('red', 'gray');
					$("#likeCount").text(data.likeCount);
				}
			},
			error:function(){ // 또는					 
				console.log("통신실패!");
			}
		});				
	}
}
</script>

      <div class="row">

        <!-- Main content 스토리, 댓글, 새소식 ★★★★★-->
        <div class="col-lg-8" id="storyContent">
        <p class="pupple" style="font-size: 15px;">목표금액 <b><fmt:formatNumber value="${projectdto.goalfund }" type="number"/></b>원 &nbsp;&nbsp; 
				펀딩기간  <b>
				<fmt:parseDate value="${projectdto.sdate }" pattern="yyyy-MM-dd HH:mm:ss" var="sdate" />
				<fmt:formatDate value="${sdate }" pattern="yyyy.MM.dd"/>~
				<fmt:parseDate value="${projectdto.edate }" pattern="yyyy-MM-dd HH:mm:ss" var="edate" />
				<fmt:formatDate value="${edate }" pattern="yyyy.MM.dd"/></b></p>
			<b style="font-size:15 px;">100%이상 모이면 펀딩이  성공되는 프로젝트</b><br>
			<font size="2px;">이 프로젝트는 펀딩 마감일까지 목표금액이 100%모이지 않으면 결제가 진행되지 않습니다.</font>
			<jsp:include page="detailStory.jsp"/>
        </div>
        
         <div class="col-lg-8" id="qnaContent"> <!-- QNA  -->
			<jsp:include page="qna.jsp"/>
        </div>
        
         <div class="col-lg-8" id="noticeContent">
			<jsp:include page="detailNotice.jsp"/>
        </div>
        
        <div class="col-lg-8" id="reviewContent"> <!-- 후기  -->
        	<jsp:include page="detailFeedback.jsp"/>
		</div>
        <!-- Sidebar 전체-->
        <div class="col-lg-4">
        
          <!--side 회사정보-->
          <p class="strongGray"><b>메이커정보</b></p>
          <div class="card my-4">
            <div class="card-body">   
			<table style="width: 100%">
			<tr>
				<td rowspan="2" align="left" class="strongGray"><a href="#layer_2" class="btn-example"><img class="profile_img" src="${writer.profile}"></a></td> 
				<td align="right" class="strongGray">${writer.nickname } </td>
			</tr>
			<tr>
				<td align="right" class="strongGray" style="font-size: 15px">${writer.email } </td> 
			</tr>
			</table>
            </div> 
          </div>
          
<!-- 리워드라면 -->
 <c:if test="${projectdto.isReward()}">
    <p class="strongGray"><b>리워드선택</b></p>
</c:if> 
          <!-- Side 옵션 -->
          
          <c:forEach items="${optionList}" var="option"> 
          <div class="card my-4">
            <div class="card-body">
           	 <p class="strongGray"> 
           	 	<strong  style="font-weight: bold; font-size: 20px">${option.price }원</strong> 
           	 	<font class="liteGray" style="font-size: 15px">(배송비 포함)</font> 
           	 </p>
             <p class="strongGray">${option.title }</p> 
              <ul>             	
             <c:forEach items="${fn:split(option.content,'/')}" var="item">
			   <li class="liteGray">${item}</li>
			 </c:forEach>
				</ul>
				<fmt:parseDate value="${projectdto.shipdate}" pattern="yyyy-MM-dd HH:mm:ss" var="shipdate" />
              <p class="liteGray" style="font-size: 15px">예상전달일 :<fmt:formatDate value="${shipdate}" pattern="yyyy년MM월dd일"/></p>
				<c:if test="${option.stock == option.buycount}">
				    <p class="pupple"><font style="background-color:#ebe2ff ">&nbsp;매진되었습니다&nbsp;&nbsp;</font></p>
				</c:if>
				<c:if test="${option.stock != option.buycount}">
				    <p class="pupple">제한수량 ${option.stock } 개&nbsp;&nbsp; 
				    <c:if test="${option.stock==0}">
				     	<b>제한수량 없음</b>
				    </c:if>
				    <c:if test="${option.stock>0}">
					    <b>현재  ${option.stock-option.buycount }개 남음!</b>
				    </c:if>
				   </p> 
				</c:if>
              <p class="strongGray"><b>총 ${option.buycount }개 펀딩완료</b></p>
            </div>
          </div>
          </c:forEach>
		<!-- side옵션 끝 -->
		
     	 </div>
     	<!-- sidebar 끝 -->

      </div>
      <!-- /.row -->

    </div>
    <!-- /.container -->
    
<!-- 판매자 프로필 사진 클릭시 레이어 팝업창 뷰 코드 -->
 <div class="dim-layer">
  <div class="dimBg"></div>
    <div id="layer_2" class="pop-layer">
        <div class="pop-container">
            <div class="pop-conts">
                <!--content //-->
                <p class="ctxt mb20">
                		Thank you.<br><br> 						
                    	${writer.info } <br>
                   	<c:forEach items="${projectdto.tags }" var="tags">
   		 			#${tags }
   					 </c:forEach><br><br>

                   	<span style="font-weight: bold;">${projectdto.title }</span><br>
                   	프로젝트에 참여해주셔서 감사합니다!<br>

                </p>
                <div class="btn-r">
                    <a href="#" class="btn-layerClose">Close</a>
                </div>
                <!--// content-->
            </div>
        </div>
    </div>
</div>
<!-- 판매자 프로필 사진 클릭시 레이어 팝업창 뷰 코드 -->
<!-- 판매자 정보 팝업창 스크립트 코드 -->    
<script type="text/javascript">
$('.btn-example').click(function(){
    var $href = $(this).attr('href');
    layer_popup($href);
});
function layer_popup(el){
    var $el = $(el);        //레이어의 id를 $el 변수에 저장
    var isDim = $el.prev().hasClass('dimBg');   //dimmed 레이어를 감지하기 위한 boolean 변수
    isDim ? $('.dim-layer').fadeIn() : $el.fadeIn();
    var $elWidth = ~~($el.outerWidth()),
        $elHeight = ~~($el.outerHeight()),
        docWidth = $(document).width(),
        docHeight = $(document).height();
    // 화면의 중앙에 레이어를 띄운다.
    if ($elHeight < docHeight || $elWidth < docWidth) {
        $el.css({
            marginTop: -$elHeight /2,
            marginLeft: -$elWidth/2
        })
    } else {
        $el.css({top: 0, left: 0});
    }
    $el.find('a.btn-layerClose').click(function(){
        isDim ? $('.dim-layer').fadeOut() : $el.fadeOut(); // 닫기 버튼을 클릭하면 레이어가 닫힌다.
        return false;
    });
    $('.layer .dimBg').click(function(){
        $('.dim-layer').fadeOut();
        return false;
    });
}
</script>  
<!-- 판매자 정보 팝업창 스크립트 코드 -->    
    
<script type="text/javascript">
function checkAndSendMessage(){
	if($("#rejectMessage").val().trim() == ''){
		alert("내용을 입력해 주세요");
		return;
	}else{
		$("#rejectMsgForm").submit();
	}
}

/* 프로젝트의 관리자 승인 상태를 보자 */
function viewStatus(){		
	$.ajax({
		url:"getStatusWithMessage.do", // 접근대상
		type:"get",		// 데이터 전송 방식
		data:"projectseq=${projectdto.seq}", // 전송할 데이터
		dataType :"json",
		success:function(data){
			//console.log(data);
			
			var msgBox = document.createElement('div');
			
			var items = data['items'];
			if(items.length>0){
				for (i = 0; i < items.length; i++) {
				  var msgContainer = document.createElement('div');
				  msgContainer.classList.add("blog-container");
	
			      var author = document.createElement('div');
			      author.classList.add("author");
			      if(items[i].writer == "에디터"){
			    	  console.log(items[i].writer);
			    	  author.innerHTML = "<h4><i class='fas fa-user-astronaut'></i>에디터</h4>";
			      }else{
			    	  //console.log(items[i].writer);
			    	  author.innerHTML = "<h4><i class='fas fa-wrench'></i></i>작성자</h4>";
			      }
			      var body = document.createElement('div');
			      body.classList.add("blog-body");			      
			      body.innerHTML = "<span class='msgtitle'>" + items[i].status + "</span>" +
			      				   "<div class='blog-summary' style='margin-top: 15px; margin-bottom: 15px'><i class='far fa-arrow-alt-circle-right'></i>&nbsp;" + 
			      				   items[i].message +"</div>";
			      var footer = document.createElement('div');
			      footer.classList.add("blog-footer");
			      footer.innerHTML = "<span class='published-date'>" + items[i].date +"<span>";
			      
			      msgContainer.appendChild(author);
			      msgContainer.appendChild(body);
			      msgContainer.appendChild(footer);
			      
			      
			      msgBox.appendChild(document.createElement('hr'));
			      msgBox.appendChild(msgContainer);
			    }			
				
				var msgBody = document.getElementById("msgBody");
				msgBody.replaceChild(msgBox, msgBody.childNodes[0]);
			}
			$("#readMsgModal").modal('show');
		},
		error:function(){ // 또는					 
			console.log("통신실패!");
		}
	});	
}
</script>

<!-- 프로젝트 승인 거절, 보완요청시 메시지 작성 부분 -->    
<div class="modal fade" id="messageModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel"><b>관리자 메시지</b></h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>     
	    <form action="rejectProject.do" method="post" id="rejectMsgForm">
	      <div class="modal-body">
	      	<input type="hidden" name="projectseq" value="${projectdto.seq}">
					<div>
						<label class="label"> 
							<input type="radio" class="option-input radio" name="status" value="reject" checked /> 승인 거절
						</label> 
						<label class="label"> 
							<input type="radio" class="option-input radio" name="status" value="revise" /> 보완 요청
						</label>
					</div>
				<div class="form-group">
	            <label for="message-text" class="col-form-label">메시지</label>
	            <textarea class="form-control" id="rejectMessage" name="message"></textarea>
	          </div>       
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn cancel_btn" data-dismiss="modal" id="quit">취소</button>
	        <button type="button" class="btn fun_btn" onclick="checkAndSendMessage()">메시지 전송</button>	       
	      </div>
	   </form>
    </div>
  </div>
</div>

<!-- 프로젝트 상태와 관리자가 남긴 메시지 등을 출력하는 부분 -->
<div class="modal fade" id="readMsgModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header" style="display: unset;">
        <h5 class="modal-title" id="exampleModalLabel">프로젝트 승인 현황</h5>        
			<div class="modal-body" id="msgBody">
				에디터가 프로젝트 내용을 검토중입니다.			
			</div>
			<div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
      </div>
    </div>
  </div>
</div>
</div>
    