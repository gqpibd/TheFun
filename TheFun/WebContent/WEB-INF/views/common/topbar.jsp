<%@page import="donzo.thefun.model.ProjectDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<fmt:requestEncoding value="UTF-8"/>

<script type="text/javascript">
window.fbAsyncInit = function() {
   FB.init({
      appId : '2123794117640622',
      cookie : true,
      xfbml : true,
      version : 'v3.2'
   });   
   window.fbApiInit = true; //init flag
}; 
//Load the SDK Asynchronously
 (function(d){
     var js, id = 'facebook-jssdk'; if (d.getElementById(id)) {return;}
     js = d.createElement('script'); js.id = id; js.async = true;
     js.src = "//connect.facebook.net/" + 
     "en_US" +
     "/all.js";
     d.getElementsByTagName('head')[0].appendChild(js);
 }(document));
</script>

<!-- topbar css파일 링크 -->
<link rel="stylesheet" href="CSS/common/topbar.css">
<style type="text/css">
/* 프로필 사진 */
.topprofile {
	float: none;
	width: 30px;
	height: 30px;
	border-radius: 50%;
	margin: 5px;
	vertical-align: middle;
	object-fit: cover;
	background: white;
}
/* /프로필 사진 */

/* megamenu */
/* Reset */
*,
*:after,
*:before {
	-webkit-box-sizing: border-box;
	-moz-box-sizing: border-box;
	box-sizing: border-box;
}

.cbp-hrmenu {
	width: 100%;
	/* margin-top: 2em; */
	border-bottom: 4px solid #8152f0;
	/* padding: 0px; */
    /* display: inline-flex; */
    /* background: #8152f0; */
}

/* general ul style */
.cbp-hrmenu ul {
	margin: 0;
	padding: 0;
	list-style-type: none;
}

/* first level ul style */
.cbp-hrmenu > ul,
.cbp-hrmenu .cbp-hrsub-inner {
	/* width: 90%; *//* 나머지 요소 가림 */
	max-width: 70em;
	margin: 0 auto;
	padding: 0 1.875em;
	z-index: 5;
}

.cbp-hrmenu > ul > li {
	display: inline-block;
}

.cbp-hrmenu > ul > li > a {
	text-decoration:none;
	font-weight: 700;
	padding: 1em 2em;
	color: #8152f0;
	display: inline-block;
}

.cbp-hrmenu > ul > li > a:hover a:not(.navbar-brand) {
	color: #8152f0;
}

.cbp-hrmenu > ul > li.cbp-hropen a:not(.navbar-brand),
.cbp-hrmenu > ul > li.cbp-hropen > a:hover a:not(.navbar-brand) {
	color: #fff;
	background: #8152f0;
}

/* sub-menu */ 
.cbp-hrmenu .cbp-hrsub {
	display: none;
	position: absolute;
	background: #8152f0;
	width: 100%;
	left: 0;
}

.cbp-hropen .cbp-hrsub {
	display: block;
	padding-bottom: 3em;
}

.cbp-hrmenu .cbp-hrsub-inner > div {
	width: 33%;
	float: left;
	padding: 0 2em 0;
}

.cbp-hrmenu .cbp-hrsub-inner:before,
.cbp-hrmenu .cbp-hrsub-inner:after {
	content: " ";
	display: table;
}

.cbp-hrmenu .cbp-hrsub-inner:after {
	clear: both;
}

.cbp-hrmenu .cbp-hrsub-inner > div a {
	line-height: 2em;
}

.cbp-hrsub h4 {
	color: #afdefa;
	padding: 2em 0 0.6em;
	margin: 0;
	font-size: 160%;
	font-weight: 300;
}

/* 드랍다운 메뉴 */
.drop-down{
    display: inline-block;
    position: relative;
    z-index: 6
}

.drop-down__button{
  /* background: linear-gradient(to right,#3d6def, #8FADFE); */
  background: linear-gradient(to right,#3a2525, #4c1010);
  display: inline-block;
  padding: 0 15px;
  text-align: left;
  border-radius: 4px;
  box-shadow: 0px 4px 6px 0px rgba(0,0,0,0.2);
  cursor: pointer;
}

.drop-down__name {
	font-size: 14px;
    color: #fff;
    font-weight: 700;
    letter-spacing: 2px;
    padding: 5px
}

.drop-down__icon {
    width: 18px;
    vertical-align: middle;
    margin-left: 14px;
    height: 18px;
    border-radius: 50%;
    transition: all 0.4s;
  -webkit-transition: all 0.4s;
  -moz-transition: all 0.4s;
  -ms-transition: all 0.4s;
  -o-transition: all 0.4s;
  
}

.drop-down__menu-box {
    padding-left: 10px;
    position: absolute;
    width: 100%;
    left: 0;
    background-color: #fff;
    border-radius: 4px;
  box-shadow: 0px 3px 6px 0px rgba(0,0,0,0.2);
     transition: all 0.3s;
  -webkit-transition: all 0.3s;
  -moz-transition: all 0.3s;
  -ms-transition: all 0.3s;
  -o-transition: all 0.3s;
 visibility: hidden;
opacity: 0;
  margin-top: 5px;
}

.drop-down__menu {
    margin: 0;
    list-style: none;
  
}
.drop-down__menu-box:before{
  content:'';
  background-color: transparent;
  border-right: 8px solid transparent;
  position: absolute;
  border-left: 8px solid transparent;
  border-bottom: 8px solid #fff;
  border-top: 8px solid transparent;
  top: -15px;
  right: 18px;

}

.drop-down__menu-box:after{
  content:'';
  background-color: transparent;
}

.drop-down__item {
	width: 95%;
    font-size: 13px;
    padding: 8px 8px;    
    font-weight: 500;
    color: #909dc2;
    cursor: pointer;
    position: relative;
    border-bottom: 1px solid #e0e2e9; 
    text-align: left;	
}

.drop-down__item-icon {
    width: 15px;
    height: 15px;
    position: absolute;
    right: 15px;
    fill: #8995b6;
  
}

.drop-down__item:hover .drop-down__item-icon{
  fill: #3d6def;
}

.drop-down__item:hover{
  color: #3d6def;
}

.drop-down__item:last-of-type{
  border-bottom: 0;
}


.drop-down--active .drop-down__menu-box{
visibility: visible;
opacity: 1;
  margin-top: 15px;
}

.drop-down__item:before{
  content:'';
  position: absolute;
width: 3px;
height: 28px;
background-color: #3d6def;
left: -10px;
top: 50%;
transform: translateY(-50%);
  display:none;
}

.drop-down__item:hover:before{
  display:block;
}

@media screen and (max-width: 43em) { 
	.logo{
		display: none;
	}
	.hideWhenSmall{
		display: none;
	}
	.drop-down__item{			
		padding: 8px 0;
	}
	.drop-down__icon{
		margin: 0;
		margin-left: 14px;
	}
	.topprofile{
		width: 40px;
		height: 40px;
	}
	.drop-down__button{
		background: #fff;
		box-shadow: 0;
	}
}
@media screen and (max-width: 36em) { 
	.cbp-hrmenu .cbp-hrsub-inner > div {
		width: 100%;
		float: none;
		padding: 0 2em;
	}
	
	.hideWhenSmall{
		display: none;
	}
	.drop-down__icon{
		margin: auto
	}
	
} 

</style>

<script type="text/javascript">
var naverLogin;
var loginAccount = "thefun"
var profile = '${login.profile}';
var auth1;

$(document).ready(function () {		
	naverLogin = new naver.LoginWithNaverId("vb6UHNxUFoBsi487fDmI", "http://localhost:8090/TheFun/");	
	/* 네아로 로그인 정보를 초기화하기 위하여 init을 호출 */
	naverLogin.init();	
	/* 카카오 로그인 정보를 초기화하기 위하여 init을 호출 */
	Kakao.init('062de807a7680278db82ca44cf5eed29'); //도현
	/* 구글 로그인 정보를 초기화하기 위하여 init */
	gapi.load('auth2', function() { 
		auth1 = gapi.auth2.init();
		if (auth1.isSignedIn.get()) {
			loginAccount = "구글";
		}
	});
});
</script>
<!-- <div class="top-menu"> -->
<!-- Navigation 헤더 -->

<div class="main_menu" style="margin-bottom:30px">
	<nav id="cbp-hrmenu" class="cbp-hrmenu navbar navbar-expand-lg navbar-dark top-menu" style="margin: 0px;padding: 0px; display: inline-flex;">
		<ul class="navbar-nav" style="margin:0;">
			<li>
				<a href="#none">프로젝트 둘러보기</a>
				<div class="cbp-hrsub" style="z-index:11;">
					<div class="cbp-hrsub-inner"> 
						<div>
							<h4>더 펀 메이커</h4>
							<ul>
								<li><a href="searchProjectList.do?doc_title=all">진행 중인 프로젝트</a></li>
								<li><a href="hotProject.do?doc_title=categoryBest">분야별 인기 프로젝트</a></li>
								<li><a href="searchProjectList.do?s_sort=edateASC&doc_title=edateASC">마감 앞둔 프로젝트</a></li>
								<li><a href="searchProjectList.do?s_sort=sdateDESC&doc_title=sdateDESC">최신 프로젝트</a></li>
								<li><a href="searchProjectList.do?s_complete=complete&doc_title=complete">종료된 프로젝트</a></li>
							</ul>
						</div>
						
						<div>
							<h4 onclick="location.href='searchProjectList.do?s_type=${ProjectDto.TYPE_DONATION}&doc_title=${ProjectDto.TYPE_DONATION}'" style="cursor: pointer;">기부</h4>
							<ul>
								<li><a href="searchProjectList.do?s_type=${ProjectDto.TYPE_DONATION}&s_category=${ProjectDto.CATEGORY_HUMAN}&doc_title=donationHuman">인권</a></li>
								<li><a href="searchProjectList.do?s_type=${ProjectDto.TYPE_DONATION}&s_category=${ProjectDto.CATEGORY_ANIMAL}&doc_title=donationAnimal">동물</a></li>
							</ul>
							<h4 onclick="location.href='searchProjectList.do?s_type=${ProjectDto.TYPE_REWARD}&doc_title=${ProjectDto.TYPE_REWARD}'" style="cursor: pointer;">리워드</h4>
							<ul>
								<li><a href="searchProjectList.do?s_type=${ProjectDto.TYPE_REWARD}&s_category=${ProjectDto.CATEGORY_FOOD}&doc_title=rewardFood">음식</a></li>
								<li><a href="searchProjectList.do?s_type=${ProjectDto.TYPE_REWARD}&s_category=${ProjectDto.CATEGORY_IT}&doc_title=rewardIt">IT / 전자</a></li>
								<li><a href="searchProjectList.do?s_type=${ProjectDto.TYPE_REWARD}&s_category=${ProjectDto.CATEGORY_ANIMAL}&doc_title=rewardAnimal">동물</a></li>
							</ul>
						</div>
						<div>
							<h4>검색</h4>
							<form id="_frmFormSearch" name="frmForm1">
								<div class="box">
									<div class="container-4">
										<input class="field" type="text" placeholder=" Search..."
										style="width: 230px" onkeypress="if(event.keyCode==13) {search_Enter(); return false;}"
										name="s_keyword" value="${s_keyword }" id="s_keywordTextField">
										<a href="#none" id="search_Btn"><button type="submit" class="icon"><i class="fa fa-search"></i></button></a>
									</div>
								</div>
							 	
								<!-- controller로 넘겨주기 위한 값 -->
								<input type="hidden" name="pageNumber" id="_pageNumber" value="${(empty pageNumber)?0:pageNumber}">
								<input type="hidden" name="recordCountPerPage" id="_recordCountPerPage" value="${(empty recordCountPerPage) ? 8 : recordCountPerPage}">
								<input type="hidden" name="s_type" value="${s_type }">
								<input type="hidden" name="s_category" value="${s_category }">
								<input type="hidden" name="s_summary" value="${s_summary }">
								<input type="hidden" name="s_sort" value="${s_sort }">
								<input type="hidden" name="s_asc_desc" value="${s_asc_desc }">
								<input type="hidden" name="s_complete" value="${s_complete }">
								<input type="hidden" name="doc_title" value="${doc_title }">
							</form>
							<h4>더 펀 소개</h4>
							<ul>
								<li><a href="#">더 펀 이야기</a></li>
								<li><a href="#">더 펀 파트너</a></li>
							</ul>
						</div>
						
					</div><!-- /cbp-hrsub-inner -->
					
				</div><!-- /cbp-hrsub -->
					
			</li>
			<li style="float: right;">
				<a href="#none" onclick="location.href='newProject.do'">새 프로젝트</a>
			</li>
			
		</ul>
		<div align="center" style="width:100%; position: absolute; z-index: 0" class="logo">			
			<img src="image/main/banner.jpg" width="150px" style="cursor: pointer;" onclick="location.href='main.do'">
		</div>
			<!-- <button class="navbar-toggler navbar-nav ml-auto" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
		      <span class="fas fa-bars" style="color:#8152f0"></span>
		    </button> -->
		        
		    <div id="navbarResponsive" style="width:20%;position:absolute;right:0;margin: auto;">		      
		    <c:if test="${login eq null}">
					    <button class="loginbtn" onclick="location.href='login.do'" style="width:85%">
					    	<img class="topprofile" src="image/profile/default.jpg">로그인/회원가입
					    </button> <!-- 로그인 -->				
			</c:if>
			<c:if test="${login ne null}">
		      	<div class="drop-down">
  				<div id="dropDown" class="drop-down__button" align="center">
   				 <span class="drop-down__name hideWhenSmall">${login.nickname} 님</span> 
   				 <span class="drop-down__icon">
   				 	<img class="topprofile" src="${login.profile}">
   				 </span>
  				</div>
         
				<div class="drop-down__menu-box">
		  			<ul class="drop-down__menu">
		  			
		  				<li class="drop-down__item"  onclick="location.href='myPage.do'">
					    	<span class="">마이페이지</span>
							<span class="drop-down__item-icon notification hideWhenSmall">					    		
								<span class="fas fa-user" style="font-size:1.5em;"></span>
							</span>
					    </li>
					 <c:if test="${!login.isManager()}">
					    <li class="drop-down__item"  onclick="location.href='myBasket.do'">
					    	<span class="">장바구니</span>
							<span class="drop-down__item-icon notification hideWhenSmall">
					    		<!-- <a href="myBasket.do" class="notification" title="장바구니" > -->
									  <span class="fas fa-shopping-cart" style="font-size:1.5em;"></span>
									  <span class="badge" id="basketcount" style="top: -30px; right: -15px;"></span>
								<!-- </a> -->
							</span>
					    </li>
					</c:if>
					    <li class="drop-down__item" onclick="location.href='viewAlarms.do'">
					    	<span class="">새소식</span>
							<span class="drop-down__item-icon notification hideWhenSmall">
						    	<!-- <a href="viewAlarms.do" class="notification" title="새소식"> -->
								  <span class="fas fa-bell" style="font-size:1.5em;"></span>
								  <span class="badge" id="alarmcount" style="top: -30px; right: -10px;"></span>
								<!-- </a> -->
							</span>
					    </li>
					   <c:if test="${login.isManager()}">
							<li class="drop-down__item" onclick="location.href='projectManage.do'">
					    		<span class="">프로젝트 관리</span>
					    		<span class="drop-down__item-icon notification hideWhenSmall">
									<!-- <a href="projectManage.do"  class="notification" title="대기중인 프로젝트"> -->
										<span class="fas fa-eye" style="font-size:1.5em;"></span>
										<span class="badge" id="waitcount" style="top: -30px; right: -12px;"></span>
									<!-- </a> -->
								</span>
							</li>
						</c:if>
					    <li class="drop-down__item" onclick="logout()">
					    	<span class="">로그아웃	</span>				    	
						    <span class="drop-down__item-icon hideWhenSmall">
						    	<span class="fas fa-door-open"style="font-size:1.5em;"></span>
						    </span>
					    </li>            
		           </ul>
	         	</div>
      		</div>
		</c:if>
		    </div>
	</nav>
</div>

<script type="text/javascript">
$(document).ready(function(){
	setAlarmCount();
	setBasketCount();
	if (document.getElementById('waitcount')) { // 관리자 모드인 경우
		setWaitCount();
	}
	

})
function setAlarmCount(){ // 알람 갯수
	$.ajax({
		type:"get",
		url:"getAlarmCount.do",
		data:"id=${login.id}",
		
		success:function(data){						
			$("#alarmcount").text(data);
		}
	});	
}

function setWaitCount(){ // 대기중인 프로젝트 갯수
	
	$.ajax({
		type:"get",
		url:"getWaitCount.do",		
		success:function(data){						
			$("#waitcount").text(data);			
			$("#waitcount1").text(data); // 이건 관리자 페이지에서만 보임			
		}
	});	
}

function setBasketCount(){ // 대기중인 프로젝트 갯수
	
	$.ajax({
		type:"get",
		url:"getBasketCount.do",
		data:"id=${login.id}",		
		success:function(data){						
			$("#basketcount").text(data);
		}
	});	
}
	/* 로그아웃 */
	function logout() {
		//console.log("로그아웃");
		console.log("로그인 계정: " +getLoginAccount());
		/* 네이버 로그아웃 */
		naverLogin.logout(function(response) { 
					console.log("네이버 로그아웃");
				}); 
		/* naverLogin.getLoginStatus(function (status) {
			if (status) { // 로그인 상태가 "true" 인 경우 
				naverLogin.logout(function(response) { 
					console.log("네이버 로그아웃");
				});
				
			}
		});		 */
		/* 페이스북 로그아웃 */
		FB.getLoginStatus(function(response) {
  			if (response.status === 'connected') {
				FB.logout(function(response) { 
					console.log("페이스북 로그아웃");
				});
  			}
		});
		/* 카카오 로그아웃 */
		Kakao.Auth.getStatus(function(statusObj){
			if(statusObj.status == "connected"){
				Kakao.Auth.logout(function(response) { 
					console.log("카카오 로그아웃");
				});
			}
		})
		/* 구글 로그아웃  */
        if (auth1.isSignedIn.get()) {
        	console.log("구글 로그아웃");
        	auth1.signOut(function(response) { 
				console.log("구글 로그아웃");
			});
        }    
		location.href="logout.do";		
	}

	function getLoginAccount() {
		/* 네이버 */
		naverLogin.getLoginStatus(function (status) {
			if (status) {
				loginAccount = "naver";
				return "naver";
			}
		});		
		/* 페이스북 */
		FB.getLoginStatus(function(response) {
  			if (response.status === 'connected') {
  				loginAccount = "facebook"; 
  			}
		});
		/* 카카오 */
		Kakao.Auth.getStatus(function(statusObj){
			if(statusObj.status == "connected"){
				loginAccount = "kakao";
			}
		})
		/* 구글  */
       /*  if (auth1.isSignedIn.get()) {
        	login = "google";
			count++;
        } */
		return loginAccount;
	}
	
	/* 검색버튼 */
     $(document).ready(function () {
    	$("#search_Btn").click(function () {
			$("#_pageNumber").val(0);
			$("#s_keywordTextField").val($("#s_keywordTextField").val());
			$("#_frmFormSearch").attr("action","searchProjectList.do").submit();
		});
	});
    
     function search_Enter() {	// 엔터 쳤을 때 검색
     	$("#_pageNumber").val(0);
     	$("#s_keywordTextField").val($("#s_keywordTextField").val());
 		$("#_frmFormSearch").attr("action","searchProjectList.do").submit();
 	}
    
/* dropdown 메뉴 설정 */
$('#dropDown').click(function(){
    $('.drop-down').toggleClass('drop-down--active');
});


/* 메가메뉴 */
var cbpHorizontalMenu=(function(){
	var b=$("#cbp-hrmenu > ul > li"),g=b.children("a"),c=$("body"),d=-1;
	function f(){g.on("click",a);
	
	b.on("click",function(h){h.stopPropagation()})}function a(j){
		if(d!==-1){b.eq(d).removeClass("cbp-hropen")}
		var i=$(j.currentTarget).parent("li"),h=i.index();
		
		if(d===h){
			i.removeClass("cbp-hropen");
			d=-1;
		}else{
			i.addClass("cbp-hropen");
			d=h;
			c.off("click").on("click",e)}return false
		}function e(h){
			b.eq(d).removeClass("cbp-hropen");
			d=-1;
		}return{init:f}})();

$(function() {
	cbpHorizontalMenu.init();
});

</script> 

