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

<link rel="stylesheet" href="CSS/common/topbar.css">
<style type="text/css">
body{
	font-family: "Nanum Gothic", sans-serif;
}

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

/* MENU */
#nav {
	text-align: center;
	/* background: #e5e5e5; */
	float: left;
	margin: 0;
	padding: 0;
	/* border: 1px solid white; */
	/* border-bottom: none; */
}

#nav li a, #nav li {
	float: left;
}

#nav li {
	list-style: none;
	position: relative;
}

#nav li a {
	/* padding: 1em 2em; */
	text-decoration: none;
	color: #8152f0;
	background: #FFF;
	background: -moz-linear-gradient(top, black, #dddddd 1px, #dddddd 25px);
	background: -webkit-gradient(linear, left top, left 25, from(#dddddd),
		color-stop(4%, #dddddd), to(#dddddd));
	/* border-right: 1px solid #3c3c3c;
 border-left: 1px solid #292929;
 border-bottom: 1px solid #232323;
 border-top: 1px solid #545454; */
}

#nav li a:hover {
	/* background: #dddddd; */
	background: -moz-linear-gradient(top, #dddddd, #dddddd);
	background: -webkit-gradient(linear, left top, left bottom, from(#dddddd),
		to(#dddddd));
}

/* Submenu */

/* .hasChildren {
	position: absolute;
	width: 5px; height: 5px;
	background: black;
	right : 0;
	bottom: 0;
} */
#nav li ul {
	display: none;
	position: absolute;
	left: 0;
	top: 100%;
	padding: 0;
	margin: 0;
}

#nav li:hover>ul {
	display: block;
}

#nav li ul li, #nav li ul li a {
	float: none;
}

#nav li ul li {
	/* _display: inline; /* for IE6 */ */
	display: table;
	margin: 0px auto 0px auto;
}

#nav li ul li a {
	/*  width: 150px; */
	display: block;
}
/* SUBSUB Menu */
#nav li ul li ul {
	display: none;
}

#nav li ul li:hover ul {
	left: 100%;
	top: 0;
}
#nav li ul
/* megamenu : 둘러보기 css */
.mega-menu {
	padding: 10px 0px ! important;
	width: 540px;
  border-radius: 0;
  margin-top: 0px;
	}

	.mega-menu li {
		display: inline-block;
		float: left;
		font-size: 0.94rem;
		padding: 3px 0px;
		}

		.mega-menu li.mega-menu-column {
			margin-right: 20px;
			width: 150px;
			}

			.mega-menu .nav-header {
			padding: 0 !important;
			margin-bottom: 10px;
			display: inline-block;
			width: 100%;
			border-bottom: 1px solid #ddd;
			}
      .mega-menu img { padding-bottom: 10px;}
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
<nav class="navbar navbar-expand-lg navbar-dark">
  <div class="container" style="background-color: white;">
	<a class="navbar-brand" href="main.do"><img src="image/main/banner.jpg" width="130px"></a><!--  배너 --> 
    
		<ul id="nav">
		<li style="width:90px;">
		<img src="image/main/donation.jpg" width="100px">
        <li class="dropdown">
            <a href="#" class="dropdown-toggle" data-toggle="dropdown">Mega Menu <b class="caret"></b></a>                      

		<ul class="dropdown-menu mega-menu">

		    <li class="mega-menu-column">
		    <ul>
		        <li class="nav-header">Mega menu 1</li>
		        <img src="image/main/donation.jpg">
				<li><a href="#">Mega-menu link</a></li>
		        <li><a href="#">Mega-menu link</a></li>
		        <li><a href="#">Mega-menu link</a></li>
		        <li><a href="#">Mega-menu link</a></li>
		        <li><a href="#">Mega-menu link</a></li>
		        <li><a href="#">Mega-menu link</a></li>
		    </ul>
		    </li> 
	    </ul>
		</li>
		
		
		<li style="width:90px;">
			<a href="searchProjectList.do?s_type=donation" onclick="search_Enter()"><img src="image/main/donation.jpg" width="100px"></a><!--  기부 -->
			<ul>
				<li style="width:90px;text-align: center;"><a href="searchProjectList.do?s_type=donation&s_category=human&" onclick="search_Enter()"><img src="image/main/human_btn.jpg" width="90px"></a></li>
				<li style="width:90px;"><a href="searchProjectList.do?s_type=donation&s_category=animal" onclick="search_Enter()"><img src="image/main/animal_btn.jpg" width="90px"></a></li>
				<li style="width:90px;"><a href="searchProjectList.do?s_type=donation&s_complete=complete"><img src="image/main/history.jpg" width="90px"></a></li>
			</ul>
			
		</li> 
		<li style="width:90px;text-align: center;">
			<a href="searchProjectList.do?s_type=reward" onclick="search_Enter()"><img src="image/main/reward.jpg" width="95px"></a><!--  리워드 -->
			<ul style="z-index: 5;">
				<li><a href="searchProjectList.do?s_type=reward&s_category=food"  onclick="search_Enter()"><img src="image/main/food_btn.jpg" width="90px"></a></li>
				<li><a href="searchProjectList.do?s_type=reward&s_category=it" onclick="search_Enter()"><img src="image/main/it_btn.jpg" width="90px"></a></li>
				<li><a href="searchProjectList.do?s_type=reward&s_category=animal" onclick="search_Enter()"><img src="image/main/animal_btn.jpg" width="90px"></a></li>
				<li style="width:90px;"><a href="searchProjectList.do?s_type=reward&s_complete=complete"><img src="image/main/history.jpg" width="90px"></a></li>
			</ul>
		</li>
		<li style="width:90px;text-align: center;">
		  <a href="newProject.do"><img src="image/main/newproject.jpg" width="95px"></a> <!-- 새 프로젝트 만들기 -->
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
      <span class="navbar-toggler-icon"></span>
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
				  <%-- <span class="badge">${alarmCount}</span> --%>
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
this.navLi = $('#nav li').children('ul').hide().end();
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
				.addClass('hasChildren')
		}
	});
	
	this.navLi.hover(function() {
		// mouseover
	$(this).find('> ul').stop(true, true).slideDown('slow');
	}, function() {
		// mouseout
	$(this).find('> ul').stop(true, 	true).hide(); 		
	});
		
	}
}

new site();
</script>