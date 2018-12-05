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
 
<!-- Custom styles for this template -->
<link href="CSS/detailcss/blog-post.css" rel="stylesheet">
 
<style type="text/css">

body{
font-family: "Nanum Gothic", sans-serif;
}
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
.imgTd{
	text-align:right;
	padding: 20px;
	width: 70%;
}
.sTd{
	text-align:left;
	width: 30%;
	padding: 10px;
}

/* 버튼 */
.fun_btn {
	-moz-box-shadow:inset 0px 1px 0px 0px #d3c2ff;
	-webkit-box-shadow:inset 0px 1px 0px 0px #d3c2ff;
	box-shadow:inset 0px 1px 0px 0px #d3c2ff;
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #a78af2), color-stop(1, #8152f0));
	background:-moz-linear-gradient(top, #a78af2 5%, #8152f0 100%);
	background:-webkit-linear-gradient(top, #a78af2 5%, #8152f0 100%);
	background:-o-linear-gradient(top, #a78af2 5%, #8152f0 100%);
	background:-ms-linear-gradient(top, #a78af2 5%, #8152f0 100%);
	background:linear-gradient(to bottom, #a78af2 5%, #8152f0 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#a78af2', endColorstr='#8152f0',GradientType=0);
	background-color:#a78af2;
	-moz-border-radius:6px;
	-webkit-border-radius:6px;
	border-radius:6px;
	border:1px solid #8152f0;
	display:inline-block;
	cursor:pointer;
	color:#ffffff;
	font-family:Arial;
	font-size:15px;
	font-weight:bold;
	padding:6px 24px;
	text-decoration:none;
	text-shadow:0px 1px 0px #7754d1;
}
.fun_btn:hover {
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #8152f0), color-stop(1, #a78af2));
	background:-moz-linear-gradient(top, #8152f0 5%, #a78af2 100%);
	background:-webkit-linear-gradient(top, #8152f0 5%, #a78af2 100%);
	background:-o-linear-gradient(top, #8152f0 5%, #a78af2 100%);
	background:-ms-linear-gradient(top, #8152f0 5%, #a78af2 100%);
	background:linear-gradient(to bottom, #8152f0 5%, #a78af2 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#8152f0', endColorstr='#a78af2',GradientType=0);
	background-color:#8152f0;
}
.fun_btn:active {
	position:relative;
	top:1px;
	
}
.fun_btn:focus{
	outline: none;
}
/* 회사 이미지 */
.profile_img{   
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

<!-- 카카오 링크 설정 -->
<!-- 
<script> 
var firstImg=$(".imageblock:first-of-type img"); 
var contents=""; 
if(firstImg.attr("src")){ 
	var firstImgSrc=firstImg.attr("src"); 
	var firstImgRatio = parseInt(firstImg.css("height"))/parseInt(firstImg.css("width")); 
	if (firstImgRatio <=0.27) var firstImgRatio=0.27; 
}else{
	var firstImgSrc=location.origin+"/favicon.ico";
	var firstImgRatio=1
} 

//Kakao.init('e53f47e84dfa687f87346382fb232397'); // 사용할 앱의 JavaScript 키를 설정해 주세요. 

function sendLink() { 
	Kakao.Link.sendTalkLink({ 
		label: '[##_page_title_##]', // 공유할 메세지의 제목을 설정
		image: { 
			src: firstImgSrc, 
			width: '300', 
			height: parseInt(300*firstImgRatio)  // 이건 썸네일을 설정 하는 겁니다.
		},
		webButton: {text: 'TheFun_더 아름다운 세상을 위한 펀딩', 
					url : "http://www.naver.com"  }
	}); 
} 
</script>	     -->

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
    <c:if test="${projectdto.isWaiting() and login ne null and login.isManager()}"> <%-- 상태가 대기중 이면서 관리자가 로그인해서 보는 경우 --%>
    	<button class="fun_btn" onclick="location.href='approve.do?projectseq=${projectdto.seq}'">프로젝트 승인</button> 
    	<button class="fun_btn" data-toggle="modal" data-target="#messageModal">프로젝트 승인 거절</button>
    </c:if>
    <c:if test="${projectdto.isOnsubmission() and login ne null and (login.isManager() or login.id eq proejctdto.id)}">
    	<button class="fun_btn" onclick="viewStatus()">상태확인</button>
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
		<table style="width: 100%;" id="sTable">
		<tr height="50">
			<td rowspan="5" class="imgTd" align="center"> <img src="upload/${projectdto.seq}" width="600px;"></td>
			<td class="strongGray sTd">
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
		<c:if test="${projectdto.isOngoing()}">
			<td> 
				<a href="goSelectReward.do?seq=${projectdto.seq }&type=${projectdto.fundtype}">
					<img src="image/detail/fundBtn.jpg" height="50px"> <!-- 펀딩하기 버튼 -->
				</a> 
			</td>
		</c:if>
		</tr>
		<tr height="50">
			<td class="strongGray imgTd">${projectdto.summary } &nbsp;&nbsp;</td>
			<c:if test="${projectdto.isOngoing()}">
			<td>
				<img class="pnt" id="hartBtn" height="50" src="image/detail/hart_${isLike=='true'?'red':'gray'}.jpg"onclick="heartClick(this)"/><span id="likeCount">${projectdto.likecount}</span> &nbsp;&nbsp;<!-- 하트 버튼 -->
				<img class="pnt" height="50" src="image/detail/addcart3.jpg" onclick="addCart()"/>&nbsp;	<!-- 장바구니추가 버튼 -->
				<img class="pnt" id="shareBtn" height="50" src="image/detail/ShareBtn1.jpg"/> <!-- 공유하기 버튼 -->
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
   
		<!-- 메뉴바 -->
		<div style="background-color: white;">
		<div class="jbMenu">
		<hr>
		<table style="width: 100%; background-color: white;">
		<tr>
			<td align="center" class="strongGray" id="story"><font class="menubar">스토리</font></td>
			<td align="center" class="strongGray" id="notice"><font class="menubar">판매자 공지<sup class="pupple" id="noticecounttab"><b>${projectdto.noticecount}</b></sup></font></td>
			<td align="center" class="strongGray" id="feedback"><font class="menubar">QnA<sup class="pupple"><b>${projectdto.qnacount}</b></sup></font></td>
		</tr>
		</table>
		<hr>
		</div>
	    </div>
	 </div>
	 
	 
<script type="text/javascript">
$(document).ready(function () {
	$("#feedbackContent").hide();
	$("#noticeContent").hide();
});


//마우스커서 모양변환
$(".menubar").mouseover(function () {	
	$(this).css("cursor","pointer");
}); 

//show and hide
$(function () {
	$("#story").click(function () {
		//alert("스토리 클릭");
		$("#storyContent").show();
		$("#noticeContent").hide();
		$("#feedbackContent").hide();
	});
	$("#notice").click(function () {
		//alert("새소식 클릭");	
		$("#storyContent").hide();
		$("#noticeContent").show();
		$("#feedbackContent").hide();
	});
	$("#feedback").click(function () {
		//alert("피드백 클릭");	
		$("#storyContent").hide();
		$("#noticeContent").hide();
		$("#feedbackContent").show();
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
			<jsp:include page="detailStory.jsp"/>
        </div>
        
         <div class="col-lg-8" id="feedbackContent"> <!-- 후기 혹은 QNA  -->
			<c:if test="${projectdto.isComplete_success() or projectdto.isComplete_fail()}">
				<jsp:include page="detailFeedback.jsp"/>
			</c:if>
			<c:if test="${projectdto.isOngoing() or isPreparing()}">
				<jsp:include page="qna.jsp"/>
			</c:if>
        </div>
        
         <div class="col-lg-8" id="noticeContent">
			<jsp:include page="detailNotice.jsp"/>
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
          
          <p class="strongGray"><b>리워드선택</b></p>
          
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

<!-- 판매자 프로필 사진 클릭시 레이어 팝업창 코드 -->
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
<!-- 판매자 정보 팝업창 코드 -->       
<style>

.pop-layer .pop-container {
  padding: 20px 25px;
}

.pop-layer p.ctxt {
  color: #666;
  line-height: 25px;
}

.pop-layer .btn-r {
  width: 100%;
  margin: 10px 0 20px;
  padding-top: 10px;
  border-top: 1px solid #DDD;
  text-align: right;
}

.pop-layer {
  display: none;
  position: absolute;
  top: 50%;
  left: 50%;
  width: 410px;
  height: auto;
  background-color: #fff;
  border: 5px solid #8152f0;
  z-index: 10;
}

.dim-layer {
  display: none;
  position: fixed;
  _position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  z-index: 100;
}

.dim-layer .dimBg {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background: #000;
  opacity: .5;
  filter: alpha(opacity=50);
}

.dim-layer .pop-layer {
  display: block;
}

a.btn-layerClose {
  display: inline-block;
  height: 25px;
  padding: 0 14px 0;
  border: 1px solid #304a8a;
  background-color: #8152f0;
  font-size: 13px;
  color: #fff;
  line-height: 25px;
}

a.btn-layerClose:hover {
  border: 1px solid #091940;
  background-color: #1f326a;
  color: #fff;
}

</style>      
<!-- 판매자 정보 팝업창 코드 -->    
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
<!-- 판매자 정보 레이어팝업코드 -->    
    
 
    
    
    
<script type="text/javascript">
function checkAndSendMessage(){
	if($("#rejectMessage").val().trim() == ''){
		alert("내용을 입력해 주세요");
		return;
	}else{
		$("#rejectMsgForm").submit();
	}
}

function viewStatus(){	
	
	$.ajax({
		url:"getStatusWithMessage.do", // 접근대상
		type:"get",		// 데이터 전송 방식
		data:"projectseq=${projectdto.seq}", // 전송할 데이터
		dataType :"json",
		success:function(data){
			console.log(data);
			var msgBody = document.getElementById("msgBody");
			var msgul = document.createElement('div');
			var items = data['items'];
			for (i = 0; i < items.length; i++) {
		      var listItem = document.createElement('div');
		      listItem.textContent = items[i].status;
		      listItem.textContent += items[i].message;
		      listItem.textContent += items[i].date;
		      msgul.appendChild(listItem);
		    }			
			msgBody.replaceChild(msgul,msgBody.childNodes[0]);
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
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">프로젝트 승인 현황</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body" id="msgBody">
        <div>
        </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
      </div>
    </div>
  </div>
</div>
    