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

.profile {
	float: none;
	width: 44px;
	height: 44px;
	border-radius: 33px;
	margin: 5px;
	vertical-align: middle;
	object-fit: cover;
}

.container-4 {
	overflow: hidden;
	width: 300px;
	vertical-align: middle;
	white-space: nowrap;
}

.container-4 input#search {
	width: 250px;
	height: 40px;
	background: #F6F6F6;
	border: none;
	font-size: 10pt;
	float: left;
	color: #000000;
	padding-left: 15px;
	-webkit-border-radius: 5px;
	-moz-border-radius: 5px;
	border-radius: 5px;
}

.container-4 button.icon {
	-webkit-border-top-right-radius: 5px;
	-webkit-border-bottom-right-radius: 5px;
	-moz-border-radius-topright: 5px;
	-moz-border-radius-bottomright: 5px;
	border-top-right-radius: 5px;
	border-bottom-right-radius: 5px;
	border: none;
	background: #F6F6F6;
	height: 50px;
	width: 50px;
	color: #4f5b66;
	opacity: 0;
	font-size: 10pt;
	-webkit-transition: all .55s ease;
	-moz-transition: all .55s ease;
	-ms-transition: all .55s ease;
	-o-transition: all .55s ease;
	transition: all .55s ease;
}

.table_content{
	color: #949494;
	text-align: left;
	padding-left: 10px;
	cursor: pointer;
}
      
/* 햄버거메뉴 */
.menu a{cursor:pointer;}
.menu .hide{display:none;}


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
	width: 90%;
	max-width: 70em;
	margin: 0 auto;
	padding: 0 1.875em;
	z-index: 1;
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

/* Examples for media queries */

@media screen and (max-width: 52.75em) { 

	.cbp-hrmenu {
		font-size: 80%;
	}

}

@media screen and (max-width: 43em) { 

	.cbp-hrmenu {
		font-size: 120%;
		border: none;
	}

	.cbp-hrmenu > ul,
	.cbp-hrmenu .cbp-hrsub-inner {
		width: 100%;
		padding: 0;
	}

	.cbp-hrmenu .cbp-hrsub-inner {
		padding: 0 2em;
		font-size: 75%;
	}

	.cbp-hrmenu > ul > li {
		display: block;
		border-bottom: 4px solid #8152f0;
	}

	.cbp-hrmenu > ul > li > a { 
		display: block;
		padding: 1em 3em;
	}

	.cbp-hrmenu .cbp-hrsub { 
		position: relative;
	}

	.cbp-hrsub h4 {
		padding-top: 0.6em;
	}

}

@media screen and (max-width: 36em) { 
	.cbp-hrmenu .cbp-hrsub-inner > div {
		width: 100%;
		float: none;
		padding: 0 2em;
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
	//Kakao.init('e53f47e84dfa687f87346382fb232397'); // 다슬
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
<div align="center" style="padding: 0px;margin: 0px;">
<span>
<img src="image/main/banner.jpg" width="150px" style="cursor: pointer;margin-top: -1%;" onclick="location.href='main.do'">
</span>
</div>
<div class="main_menu">
	<nav id="cbp-hrmenu" class="cbp-hrmenu navbar navbar-expand-lg navbar-dark top-menu" style="margin: 0px;padding: 0px;">
		<ul class="navbar-nav ml-auto">
			<li>
				<a href="#none">프로젝트 둘러보기</a>
				<div class="cbp-hrsub" style="z-index:11;">
					<div class="cbp-hrsub-inner"> 
						<div>
							<h4>더 펀 메이커</h4>
							<ul>
								<li><a href="searchProjectList.do">모든 프로젝트</a></li>
								<li><a href="#">분야별 인기 프로젝트</a></li>
								<li><a href="searchProjectList.do?s_sort=edateASC">마감 앞둔 프로젝트</a></li>
								<li><a href="searchProjectList.do?s_sort=sdateDESC">최신 프로젝트</a></li>
								<li><a href="searchProjectList.do?s_type=donation&s_complete=complete">종료된 프로젝트</a></li>
							</ul>
						</div>
						<div>
							<h4 onclick="location.href='searchProjectList.do?s_type=${ProjectDto.TYPE_DONATION}'" style="cursor: pointer;">기부</h4>
							<ul>
								<li><a href="searchProjectList.do?s_type=${ProjectDto.TYPE_DONATION}&s_category=${ProjectDto.CATEGORY_HUMAN}">인권</a></li>
								<li><a href="searchProjectList.do?s_type=${ProjectDto.TYPE_DONATION}&s_category=${ProjectDto.CATEGORY_ANIMAL}">동물</a></li>
							</ul>
							<h4 onclick="location.href='searchProjectList.do?s_type=${ProjectDto.TYPE_REWARD}'" style="cursor: pointer;">리워드</h4>
							<ul>
								<li><a href="searchProjectList.do?s_type=${ProjectDto.TYPE_REWARD}&s_category=${ProjectDto.CATEGORY_FOOD}">음식</a></li>
								<li><a href="searchProjectList.do?s_type=${ProjectDto.TYPE_REWARD}&s_category=${ProjectDto.CATEGORY_IT}">IT / 전자</a></li>
								<li><a href="searchProjectList.do?s_type=${ProjectDto.TYPE_REWARD}&s_category=${ProjectDto.CATEGORY_ANIMAL	}">동물</a></li>
							</ul>
						</div>
						<div>
							<h4>검색</h4>
							<form id="_frmFormSearch" name="frmForm1">
								<div class="box">
									<div class="container-4">
										<input class="field" type="text" placeholder="Search..."
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
								<input type="hidden" name="s_complete" value="${s_complete }">
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
		
			<button class="navbar-toggler navbar-nav ml-auto" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
		      <span class="fas fa-bars" style="color:#8152f0"></span>
		    </button>
		        
		    <div class="collapse navbar-collapse" id="navbarResponsive">
		      <ul class="navbar-nav ml-auto" style="margin-right: 15%;">
		        <li class="nav-item">              
					<c:if test="${login eq null}">
					    <a class="nav-link" href="login.do"><img src="image/main/mainLogin.jpg" height="30px"></a> <!-- 로그인 -->				
					</c:if>
					<c:if test="${login ne null}">
						<span id="profile"><img class="profile" src="${login.profile}" onclick="location.href='myPage.do?id=${login.id}'" title="마이페이지로 이동" style="cursor: pointer;"></span>
						<span onclick="location.href='myPage.do?id=${login.id}'" style="cursor: pointer;">${login.nickname}님</span>
						&nbsp;&nbsp;
						<a href="viewAlarms.do" class="notification" title="새소식">
						  <span class="fas fa-bell" style="font-size:1.5em; color:#ab9f9d" onmouseover="$(this).css('color','black')" onmouseout="$(this).css('color','#ab9f9d')"></span>
						  <span class="badge">${alarmCount}</span>
						  <span class="badge" id="alarmcount"></span>
						</a>								
						<c:choose>			
							<c:when test="${login.isManager()}">
								<a href="projectManage.do"  class="notification" title="대기중인 프로젝트">
									<span class="fas fa-eye" style="font-size:1.5em; color:#ab9f9d" onmouseover="$(this).css('color','black')" onmouseout="$(this).css('color','#ab9f9d')"></span>
									<span class="badge" id="waitcount"></span>
								</a>
							</c:when>
							<c:otherwise>
							</c:otherwise>
						</c:choose>
						<a href="#" onclick="logout()">로그아웃</a> <!-- 로그인 -->			
					</c:if>
		        </li>
		      </ul>
		    </div>
	</nav>
</div>

<%-- 원본
<nav class="navbar navbar-expand-lg navbar-dark top-menu">
  <div class="container" style="background-color: white;">
		<a class="navbar-brand" href="main.do"><img src="image/main/banner.jpg" width="130px" ></a><!--  배너 -->
		<ul class="nav mega-menu">
		<li>
			<a href="#none" onclick=""><!-- <img src="image/main/newproject.jpg" width="95px"> --><span style="width:95px;">프로젝트 둘러보기</span></a>
			<ul style="z-index: 6;background: white;padding: 5px;width: 700%;top: 100%;">
	        <li class="nav-header">
	        <table style="width: 100%;height: 90%;" border="1">
	        <col width="20%"><col width="20%"><col width="30%"><col width="30%">
			<tr>
			<th>더 펀 메이커</th>
			<th>더 펀 소개</th>
			<th rowspan="6"><img alt="" src="image/banner/in_menu_logo.png" height="50%;" style="object-fit: cover;overflow:hidden"></th>
			<th rowspan="6">태그</th>
			</tr>
			<tr>
			<td class="table_content"><a href="searchProjectList.do?">모든 프로젝트</a></td>
			<td class="table_content">더 펀 이야기</td>
			</tr>
			<tr>
			<td class="table_content">분야별 인기 프로젝트</td>
			<td class="table_content">더 펀 이야기</td>
			</tr>
			<tr>
			<td class="table_content" onclick="location.href='searchProjectList.do?s_sort=edateASC'">마감 앞둔 프로젝트</td>
			<td class="table_content">더 펀 이야기</td>
			</tr>
			<tr>
			<td class="table_content" onclick="location.href='searchProjectList.do?s_sort=sdateDESC'">최신 프로젝트</td>
			<td class="table_content">더 펀 이야기</td>
			</tr>
			<tr>
			<td class="table_content" onclick="location.href='searchProjectList.do?s_type=donation&s_complete=complete'">완료된 프로젝트</td>
			<td class="table_content">더 펀 이야기</td>
			</tr>
			</table>
			</li>
	        <!-- <img src="http://placehold.it/150x120"> -->
			</ul>
			
		</li> 
		
		
		<li style="width:90px;z-index: 5;">
			<a href="searchProjectList.do?s_type=donation" onclick="search_Enter()"><img src="image/main/donation.jpg" width="100px"></a>
			<ul>
				<li style="width:90px;text-align: center;"><a href="searchProjectList.do?s_type=donation&s_category=human" onclick="search_Enter()"><img src="image/main/human_btn.jpg" width="90px"></a></li>
				<li style="width:90px;"><a href="searchProjectList.do?s_type=donation&s_category=animal" onclick="search_Enter()"><img src="image/main/animal_btn.jpg" width="90px"></a></li>
				<li style="width:90px;"><a href="searchProjectList.do?s_type=donation&s_complete=complete"><img src="image/main/history.jpg" width="90px"></a></li>
			</ul>
		</li> 
		<li style="width:90px;text-align: center;">
			<a href="searchProjectList.do?s_type=reward" onclick="search_Enter()"><img src="image/main/reward.jpg" width="95px"></a>
			<ul style="z-index: 5;">
				<li><a href="searchProjectList.do?s_type=reward&s_category=food"  onclick="search_Enter()"><img src="image/main/food_btn.jpg" width="90px"></a></li>
				<li><a href="searchProjectList.do?s_type=reward&s_category=it" onclick="search_Enter()"><img src="image/main/it_btn.jpg" width="90px"></a></li>
				<li><a href="searchProjectList.do?s_type=reward&s_category=animal" onclick="search_Enter()"><img src="image/main/animal_btn.jpg" width="90px"></a></li>
				<li style="width:90px;"><a href="searchProjectList.do?s_type=reward&s_complete=complete"><img src="image/main/history.jpg" width="90px"></a></li>
			</ul>
		</li>
		<li style="width:90px;text-align: center;">
		  <div align="center"><a href="newProject.do"><img src="image/main/newproject.jpg" width="95px"></a> </div><!-- 새 프로젝트 만들기 -->
		</li>
		</ul>
		
    &nbsp;&nbsp;&nbsp;&nbsp;
    
    <form id="_frmFormSearch" name="frmForm1">
		<div class="box">
			<div class="container-4">
				<input class="field" type="text" placeholder="Search..."
				style="width: 300px" onkeypress="if(event.keyCode==13) {search_Enter(); return false;}"
				name="s_keyword" value="${s_keyword }" id="s_keywordTextField">
				<a href="#none" id="search_Btn"><button type="submit" class="icon"><i class="fa fa-search"></i></button></a>
			</div>
		</div>
	 	
		<!-- controller로 넘겨주기 위한 값 -->
		<input type="hidden" name="pageNumber" id="_pageNumber" value="${(empty pageNumber)?0:pageNumber}">
		<input type="hidden" name="recordCountPerPage" id="_recordCountPerPage" value="${(empty recordCountPerPage) ? 8 : recordCountPerPage}">
		<input type="hidden" name="s_type" value="${s_type }">
		<input type="hidden" name="s_category" value="${s_category }">
		<input type="hidden" name="s_complete" value="${s_complete }">
	    
	</form>
	
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
      <span class="fas fa-bars" style="color:#8152f0"></span>
    </button>
        
    <div class="collapse navbar-collapse" id="navbarResponsive">
      <ul class="navbar-nav ml-auto">
        <li class="nav-item">              
			<c:if test="${login eq null}">
			    <a class="nav-link" href="login.do"><img src="image/main/mainLogin.jpg" height="20px"></a> <!-- 로그인 -->				
			</c:if>
			<c:if test="${login ne null}">
				<span id="profile"><img class="profile" src="${login.profile}" onclick="location.href='myPage.do?id=${login.id}'" title="마이페이지로 이동" style="cursor: pointer;"></span>
				<span>${login.nickname}님</span>
				<a href="viewAlarms.do" class="notification" title="새소식">
				  <span class="fas fa-bell" style="font-size:1.5em; color:#ab9f9d" onmouseover="$(this).css('color','black')" onmouseout="$(this).css('color','#ab9f9d')"></span>
				  <span class="badge">${alarmCount}</span>
				  <span class="badge" id="alarmcount"></span>
				</a>								
				<c:choose>			
					<c:when test="${login.isManager()}">
						<a href="projectManage.do"  class="notification" title="대기중인 프로젝트">
							<span class="fas fa-eye" style="font-size:1.5em; color:#ab9f9d" onmouseover="$(this).css('color','black')" onmouseout="$(this).css('color','#ab9f9d')"></span>
							<span class="badge" id="waitcount"></span>
						</a>
					</c:when>
					<c:otherwise>
					</c:otherwise>
				</c:choose>
				<a href="#" onclick="logout()">로그아웃</a> <!-- 로그인 -->			
			</c:if>
        </li>
      </ul>
    </div>
  </div>
</nav>
 --%>
    

<script type="text/javascript">
$(document).ready(function(){
	setAlarmCount();
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
    
// 상단바 js 부분
    
var site = function() {
this.navLi = $('.nav li').children('ul').hide().end();
this.init();
};
site.prototype = {
	 	
	init : function() {
		this.setMenu();
	},
	
	// Enables the slidedown menu, and adds support for IE6
	
	setMenu : function() {
	
	$.each(this.navLi, function() {
		if ( $(this).children('ul')[0] ) {
			$(this)
				.append('<span />')
				.children('span')
				.addClass('hasChildren');
		}
	});
	
	this.navLi.hover(function() {
		// mouseover
	$(this).find('> ul').stop(true, true).slideDown('slow');
	}, function() {
		// mouseout
	$(this).find('> ul').stop(true, true).hide(); 		
	});
		
	}
}

new site();



/* 햄버거버튼 */
   // html dom 이 다 로딩된 후 실행된다.
    $(document).ready(function(){
        // menu 클래스 바로 하위에 있는 a 태그를 클릭했을때
        $(".menu>a").click(function(){
            var submenu = $(this).next("ul");
 
            // submenu 가 화면상에 보일때는 위로 보드랍게 접고 아니면 아래로 보드랍게 펼치기
            if( submenu.is(":visible") ){
                submenu.slideUp();
            }else{
                submenu.slideDown();
            }
        });
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