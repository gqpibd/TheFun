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




/* 햄버거메뉴 */
.menu a{cursor:pointer;}
.menu .hide{display:none;}

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
<nav class="navbar navbar-expand-lg navbar-dark" style="z-index:100;">
  <!-- 탑바 전체를 묶는 div -->	
  <div class="container" style="background-color: white;">
  	
  	<!-- 사이트 로고 a태그로 main뷰 연결 -->
	<a class="navbar-brand" href="main.do">
		<img src="image/main/banner.jpg" width="130px">
	</a>
    
    <!-- 3가지 메뉴 기부, 리워드, 프로젝트 -->
	<ul id="nav">
		<!-- 1번째 목록 -->
		<li style="width:90px; text-align: center;">
			<!-- 1번째 부모목록: 기부  -->
			<a href="searchProjectList.do?s_type=donation&s_keyword=donation" onclick="search_Enter()">
				<img src="image/main/donation.jpg" width="100px">
			</a>
			
			<!-- 자식목록 -->
			<ul>
				<!-- 인권 -->
				<li>
					<a href="searchProjectList.do?s_type=donation&s_category=human&s_keyword=human" onclick="search_Enter()">
						<img src="image/main/human_btn.jpg" width="90px">
					</a>
				</li>
				<!-- 동물 -->
				<li style="width:90px;">
					<a href="searchProjectList.do?s_type=donation&s_category=animal&s_keyword=animal" onclick="search_Enter()">
						<img src="image/main/animal_btn.jpg" width="90px">
					</a>
				</li>
				<!-- 히스토리 -->
				<li style="width:90px;">
					<a href="#">
						<img src="image/main/history.jpg" width="90px">
					</a>
				</li>
			</ul>
		</li> 
		
		<!-- 2번째 목록 -->
		<li style="width:90px; text-align: center;">		
			<!-- 2번째 부모록록: 리워드 -->
			<a href="searchProjectList.do?s_type=reward&s_keyword=reward" onclick="search_Enter()">
				<img src="image/main/reward.jpg" width="95px">
			</a>
			
			<!-- 자식목록 -->
			<ul>
				<!-- 음식 -->
				<li>
					<a href="searchProjectList.do?s_type=reward&s_category=food&s_keyword=food"  onclick="search_Enter()">
						<img src="image/main/food_btn.jpg" width="90px">
					</a>
				</li>
				<!-- IT/전자 -->
				<li>
					<a href="searchProjectList.do?s_type=reward&s_category=it&s_keyword=it" onclick="search_Enter()">
						<img src="image/main/it_btn.jpg" width="90px">
					</a>
				</li>
				<!-- 동물 -->
				<li>
					<a href="searchProjectList.do?s_type=reward&s_category=animal&s_keyword=animal" onclick="search_Enter()">
						<img src="image/main/animal_btn.jpg" width="90px">
					</a>
				</li>
				<!-- 히스토리 -->
				<li style="width:90px;">
					<a href="#">
						<img src="image/main/history.jpg" width="90px">
					</a>
				</li>
			</ul>	
		</li>
		
		<!-- 3번째 목록 -->
		<li style="width:90px; text-align: center;">
			<!-- 3번째 부모록록: 새 프로젝트 -->
			<a href="newProject.do">
				<img src="image/main/newproject.jpg" width="95px">
			</a>
			<!-- 자식목록 -->
			<ul>
				<!-- 등록하기 -->
				<li>
				<a>
					<img>
				</a>
				</li>
			</ul>
		</li>
		
	</ul>
	
	
	
	
	
	<!--///////  -->
    &nbsp;&nbsp;&nbsp;&nbsp;
    
    
    
    
    <!-- 검색바 -->
    <form id="_frmFormSearch" name="frmForm1">
		<div class="box">
			<div class="container-4">
				<input class="field" type="text" placeholder="Search..."
				style="width: 300px" onkeypress="if(event.keyCode==13) {search_Enter(); return false;}"
				value="${s_keyword }" name="s_keyword" id="s_keywordTextField">	
				<a href="#none" id="search_Btn"><button type="submit" class="icon"><i class="fa fa-search"></i></button></a>
			</div>
		</div>
	 	
	 	<%-- <input class="" type="text" placeholder="Search..."
	 	value="${s_keyword }" name="s_keyword" id="s_keywordTextField"> --%>
	 	
	 	<%-- <input class="field" type="text" placeholder="Search..."
	 	style="width: 300px" onkeypress="if(event.keyCode==13) {search_Enter(); return false;}"
	 	value="${s_keyword }" name="s_keyword" id="s_keywordTextField"> --%>
	 	
		<!-- <a href="#none" id="search_Btn"><button type="submit"  class=''>검색</button></a> -->
		<!-- controller로 넘겨주기 위한 값 -->
		<input type="hidden" name="pageNumber" id="_pageNumber" value="${(empty pageNumber)?0:pageNumber}">
		<input type="hidden" name="recordCountPerPage" id="_recordCountPerPage" value="${(empty recordCountPerPage) ? 8 : recordCountPerPage}">
	    
	</form>
	
    <!-- 로그인 하기 전 로그인 버튼-->
  	<c:if test="${login eq null}">
	    <a class="nav-link" href="login.do">
	    	<img src="image/main/mainLogin.jpg" height="20px">
	    </a> 		
	</c:if>
	
    <!-- 로그인 후 상태 -->
    <c:if test="${login ne null}">
	    <!-- 프로필이미지 -->
		<span id="profile">
			<img class="profile" src="${login.profile}" onclick="location.href='myPage.do?id=${login.id}'" 
			title="마이페이지로 이동" style="cursor: pointer;">
		</span>
		<!-- 회원 닉네임 -->
		<span>${login.nickname}님</span>		
		
		<!-- 로그인 후 햄버거 버튼 활성화 -->
	   <!--  <button class="navbar-toggler" type="button" 
	    		data-toggle="collapse" data-target="#navbarResponsive" 
	    		aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
	      <span class="navbar-toggler-icon"></span>
	    </button> -->
	    
   		<div class=" " id="">
	 
			<ul class=" " id="">
				<li class="menu">         	
					<a><!-- <img src="" alt="상위메뉴이미지1"/> -->
						<button class="menu-toggle">Menu</button>
					</a>
					
						<%-- <!-- 프로필이미지 -->
						<span id="profile">
							<img class="profile" src="${login.profile}" onclick="location.href='myPage.do?id=${login.id}'" 
							title="마이페이지로 이동" style="cursor: pointer;">
						</span>
						<!-- 회원 닉네임 -->
						<span>${login.nickname}님</span> --%>	
					
						<!-- 여기서 부터 햄버거버튼 -->
						<ul class="hide">
							<!-- 나의 정보 -->
							<li>
								<a href="#" onclick="">나의 정보</a> 		
							</li>	
							
							<!-- 나의 후원내역 -->
							<li>
								<a href="#" onclick="">나의 후원내역</a> 		
							</li>	
							
							<!-- 나의 프로젝트 -->
							<li>
								<a href="#" onclick="">나의 프로젝트</a> 		
							</li>	
							
							<!-- 나의 일정 -->
							<li>
								<a href="#" onclick="">나의 일정</a> 		
							</li>	
							
							<!-- 로그아웃 -->
							<li>
								<a href="#" onclick="logout()">로그아웃</a> 		
							</li>
							
							<%-- <c:choose>			
								<c:when test="${login.isManager()}">
									<button type="button" onclick="location.href='projectManage.do'">프로젝트 관리</button>
								</c:when>
								<c:otherwise>
								</c:otherwise>
							</c:choose> --%>
						
						</ul>
				
				</li>
			</ul>
	     
	    </div>
    
    </c:if>
  
  
  </div>
</nav>
    








    
<script type="text/javascript">
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

</script>