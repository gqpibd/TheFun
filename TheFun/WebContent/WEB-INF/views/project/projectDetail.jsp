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
 
<title>The Fun_상세페이지</title>

<!-- Custom styles for this template -->
<link href="CSS/detailcss/blog-post.css" rel="stylesheet">
 
<style type="text/css">

body{
font-family: "Nanum Gothic", sans-serif;
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
 .jbMenu {
  background-color:#ffffff;
  text-align: center; 
  padding-right: 15px;
  padding-left: 15px;
  margin-right: auto;
  margin-left: auto;
  width: 100%;
}
.jbFixed {
  text-align: center;
  padding-right: 15px;
  padding-left: 15px;
  margin-right: auto;
  margin-left: auto;
   position: fixed;
   top: 0px;
 }
.imgTd{
	text-align:right;
	padding: 20px;
	width: 70%;
}
.sTd{
	text-align:left;
	width: 30%;
	padding: 25px;
}
 </style>

<!-- 카카오 링크 설정 -->
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

Kakao.init('e53f47e84dfa687f87346382fb232397'); // 사용할 앱의 JavaScript 키를 설정해 주세요. 

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
</script>	    
<!-- 남은날짜계산 -->
<jsp:useBean id="toDay" class="java.util.Date" />
<fmt:formatDate value="${toDay}" pattern="yyyy-MM-dd HH:mm:ss" />
<fmt:parseNumber value="${toDay.time / (1000*60*60*24)}" integerOnly="true" var="strDate"></fmt:parseNumber>
<fmt:parseDate value="${projectdto.edate }" var="endDate" pattern="yyyy-MM-dd HH:mm:ss"/>
<fmt:parseNumber value="${endDate.time / (1000*60*60*24)}" integerOnly="true" var="endDate"></fmt:parseNumber>

 <!-- 카테고리 , 태그 -->
    <div class="container">
   	<br>
   	<div align="center">
   		<p><b class="pupple">${projectdto.category} </b>&nbsp;&nbsp;&nbsp;
   		<font class="strongGray">	
   		 <c:forEach items="${projectdto.tags }" var="tags">
   		 	#${tags }
   		 </c:forEach>
   		 </font></p>
   		 <p class="strongGray" style="font-size: 27px">${projectdto.title }</p>

<!-- 프로젝트 타이틀 -->
		<table style="width: 100%;" id="sTable">
		<tr height="50">
			<td rowspan="5" class="imgTd"> 이미지&nbsp;&nbsp;</td>
			<td class="strongGray sTd"><b style="font-size: 20px">${endDate - strDate }일 남음</b></td>
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
			<td> 
				<a href="goSelectReward.do?seq=${projectdto.seq }">
					<img src="image/detail/fundBtn.jpg" height="50px">
				</a> 
			</td>
		</tr>
		<tr height="50">
			<td class="strongGray imgTd">${projectdto.summary } &nbsp;&nbsp;</td>
			<td>
				<img height="50" src="image/detail/addcart2.jpg"/>&nbsp;&nbsp;&nbsp; &nbsp;
				<img id="shareBtn" height="50" src="image/detail/ShareBtn.jpg"/>
			</td>
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
			<td align="center" class="strongGray" id="notice"><font class="menubar">새소식<sup class="pupple"><b>${projectdto.noticecount}</b></sup></font></td>
			<td align="center" class="strongGray" id="feedback"><font class="menubar">피드백<sup class="pupple"><b>n</b></sup></font></td>
		</tr>
		</table>
		<hr>
		</div>
	    </div>
	 </div>
<script type="text/javascript">
$(document).ready(function () {
//	$("#shareBtn").show();
	$("#feedbackContent").hide();
	$("#noticeContent").hide();
});

/* //공유하기
$('#shareBtn').toggle(function() { 
	alert('선택'); 
	}, function() { 
		alert('선택해제'); 
		}); */

//마우스커서 모양변환
$(".menubar").mouseover(function () {	
	$(this).css("cursor","pointer");
}); 

//
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

</script>
      <div class="row">

        <!-- Main content 스토리, 댓글, 새소식 ★★★★★-->
        <div class="col-lg-8" id="storyContent">
			<jsp:include page="detailStory.jsp"/>
        </div>
        
         <div class="col-lg-8" id="feedbackContent">
			<jsp:include page="detailFeedback.jsp"/>
        </div>
        
         <div class="col-lg-8" id="noticeContent">
			<jsp:include page="detailNotice.jsp"/>
        </div>

        <!-- Sidebar 전체-->
        <div class="col-md-4">
        
          <!--side 회사정보-->
          <p class="strongGray"><b>메이커정보</b></p>
          <div class="card my-4">
            <div class="card-body">   
			<table style="width: 100%">
			<tr>
				<td rowspan="2" align="left" class="strongGray"><img src="${writer.profile}" style="width:100%"></td>
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
             <c:forEach items="${option.content}" var="item">
			   <li class="liteGray">${item}</li>
			 </c:forEach>
				</ul>
				<fmt:parseDate value="${projectdto.shipdate}" pattern="yyyy-MM-dd HH:mm:ss" var="shipdate" />
              <p class="liteGray" style="font-size: 15px">예상전달일 :<fmt:formatDate value="${shipdate}" pattern="yyyy년MM월dd일"/></p>
              <p class="pupple">제한수량 ${option.stock } 개&nbsp;&nbsp; <b>현재  ${option.stock-option.buycount }개 남음!</b></p>
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