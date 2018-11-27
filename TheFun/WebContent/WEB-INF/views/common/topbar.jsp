<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<fmt:requestEncoding value="UTF-8"/>

<link href="//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet">

<link rel="stylesheet" href="CSS/common/topbar.css">
<style type="text/css">
.profile{   
    float: none;
    width: 44px;
    height: 44px;
    border-radius: 33px;
    margin: 5px;
    vertical-align: middle;
    object-fit: cover;
}


.container-4{
  overflow: hidden;
  width: 300px;
  vertical-align: middle;
  white-space: nowrap;
}

.container-4 input#search{
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

.container-4 button.icon{
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

.btn_MyPage{
border:1px solid #8a66f4; 
-webkit-border-radius: 3px; 
-moz-border-radius: 3px;
border-radius: 3px;
font-size:12px;
font-family:arial, helvetica, sans-serif; 
padding: 5px 5px 5px 5px; 
text-decoration:none; 
display:inline-block;
text-shadow: -1px -1px 0 rgba(0,0,0,0.3);
font-weight:bold; color: #FFFFFF;
 background-color: #b29af8; background-image: -webkit-gradient(linear, left top, left bottom, from(#b29af8), to(#9174ed));
 background-image: -webkit-linear-gradient(top, #b29af8, #9174ed);
 background-image: -moz-linear-gradient(top, #b29af8, #9174ed);
 background-image: -ms-linear-gradient(top, #b29af8, #9174ed);
 background-image: -o-linear-gradient(top, #b29af8, #9174ed);
 background-image: linear-gradient(to bottom, #b29af8, #9174ed);filter:progid:DXImageTransform.Microsoft.gradient(GradientType=0,startColorstr=#b29af8, endColorstr=#9174ed);
}

.btn_MyPage:hover{
 border:1px solid #693bf1;
 background-color: #8e6af5; background-image: -webkit-gradient(linear, left top, left bottom, from(#8e6af5), to(#6d47e7));
 background-image: -webkit-linear-gradient(top, #8e6af5, #6d47e7);
 background-image: -moz-linear-gradient(top, #8e6af5, #6d47e7);
 background-image: -ms-linear-gradient(top, #8e6af5, #6d47e7);
 background-image: -o-linear-gradient(top, #8e6af5, #6d47e7);
 background-image: linear-gradient(to bottom, #8e6af5, #6d47e7);filter:progid:DXImageTransform.Microsoft.gradient(GradientType=0,startColorstr=#8e6af5, endColorstr=#6d47e7);
}


/* MENU */

#nav {
 text-align : center;
 /* background: #e5e5e5; */
 float: left;
 margin: 0; padding: 0;
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
 background: -webkit-gradient(linear, left top, left 25, from(#dddddd), color-stop(4%, #dddddd), to(#dddddd));
 /* border-right: 1px solid #3c3c3c;
 border-left: 1px solid #292929;
 border-bottom: 1px solid #232323;
 border-top: 1px solid #545454; */
}

#nav li a:hover {
 /* background: #dddddd; */
 background: -moz-linear-gradient(top, #dddddd, #dddddd);
 background: -webkit-gradient(linear, left top, left bottom, from(#dddddd), to(#dddddd));
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
 padding: 0; margin: 0;
}

#nav li:hover > ul {
 display: block;
}

#nav li ul li, #nav li ul li a {
 float: none;
}

#nav li ul li {
 /* _display: inline; /* for IE6 */ */
 	display:table;
    margin:0px auto 0px auto;
}

#nav li ul li a {
/*  width: 150px;
 */ display: block;
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


</style>

<script type="text/javascript">
window.fbAsyncInit = function() {
	FB.init({
		appId : '2123794117640622',
		cookie : true,
		xfbml : true,
		version : 'v3.2'
	});	
	
	FB.getLoginStatus(function(response) {
		if (response.status === 'connected') {
			FB.api('/me',{fields: 'name,email,picture'}, function(res) {			     
				profile = res.picture.data.url;		
				console.log("페이스북 로그인 되어있음");
				console.log(profile);
				//$("#profile").attr("src",profile);
			});
			
		} else {
			//console.log("페이스북 로그인 되어있지 않음")
		}
	});
};
(function(d, s, id) {
	var js, fjs = d.getElementsByTagName(s)[0];
	if (d.getElementById(id)) {
		return;
	}
	js = d.createElement(s);
	js.id = id;
	js.src = "https://connect.facebook.net/en_US/sdk.js";
	fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));		
</script>

<!-- <div class="top-menu"> -->
<!-- Navigation 헤더 -->
<nav class="navbar navbar-expand-lg navbar-dark">
  <div class="container" style="background-color: white;">
<a class="navbar-brand" href="main.do"><img src="image/main/banner.jpg" width="130px"></a><!--  배너 --> 
    
<ul id="nav">
<li style="width:90px;">
<a href="searchProjectList.do?s_type=donation&s_keyword=donation" onclick="search_Enter()"><img src="image/main/donation_btn.jpg" width="90px"></a><!--  기부 -->
<ul>
	<li style="width:90px;text-align: center;"><a href="searchProjectList.do?s_type=donation&s_category=human&s_keyword=human" onclick="search_Enter()"><img src="image/main/human_btn.jpg" width="90px"></a></li>
	<li style="width:90px;"><a href="searchProjectList.do?s_type=donation&s_category=animal&s_keyword=animal" onclick="search_Enter()"><img src="image/main/animal_btn.jpg" width="90px"></a></li>
	<li style="width:90px;"><a href="#"><img src="image/main/history.jpg" width="90px"></a></li>
</ul>
</li> 
<li style="width:90px;text-align: center;">
<a href="searchProjectList.do?s_type=reward&s_keyword=reward" onclick="search_Enter()"><img src="image/main/funding.jpg" width="60px"></a><!--  펀딩 -->
<ul>
	<li><a href="searchProjectList.do?s_type=reward&s_category=food&s_keyword=food"  onclick="search_Enter()"><img src="image/main/food_btn.jpg" width="90px"></a></li>
	<li><a href="searchProjectList.do?s_type=reward&s_category=it&s_keyword=it" onclick="search_Enter()"><img src="image/main/it_btn.jpg" width="90px"></a></li>
	<li><a href="searchProjectList.do?s_type=reward&s_category=animal&s_keyword=animal" onclick="search_Enter()"><img src="image/main/animal_btn.jpg" width="90px"></a></li>
	<li style="width:90px;"><a href="#"><img src="image/main/history.jpg" width="90px"></a></li>
</ul>
</li>
  <li>
  <a href="newProject.do"><img src="image/main/newproject.jpg" width="90px"></a> <!-- 새 프로젝트 만들기 -->
  </li>
  </ul>

    &nbsp;&nbsp;&nbsp;&nbsp;
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
				<span id="profile"><img class="profile" src="${login.profile}"></span>
				<span>${login.nickname}님</span>			
				<a href="#" onclick="logout()">로그아웃</a> <!-- 로그인 -->				
				<c:choose>			
					<c:when test="${login.isManager()}">
						<button type="button" onclick="location.href='projectManage.do'">프로젝트 관리</button>
					</c:when>
					<c:otherwise>
						<button type="button" onclick="location.href='myPage.do?id=${login.id}'"
						class="btn_MyPage">마이페이지</button>		
					</c:otherwise>
				</c:choose>
			</c:if>
        </li>
      </ul>
    </div>
  </div>
</nav>
    

    
<script type="text/javascript">
	var naverLogin = new naver.LoginWithNaverId("vb6UHNxUFoBsi487fDmI", "http://localhost:8090/TheFun/");
	/* 네아로 로그인 정보를 초기화하기 위하여 init을 호출 */
	naverLogin.init();	
	/* 카카오 로그인 정보를 초기화하기 위하여 init을 호출 */
	Kakao.init('062de807a7680278db82ca44cf5eed29'); //도현
	//Kakao.init('e53f47e84dfa687f87346382fb232397'); // 다슬
	/* 로그아웃 */
	function logout() {
		console.log("로그아웃");
		/* 네이버 로그아웃 */
		naverLogin.getLoginStatus(function (status) {
			if (status) {
				/* 로그인 상태가 "true" 인 경우  */
				naverLogin.logout();
			}
		});		
		/* 페이스북 로그아웃 */
		FB.getLoginStatus(function(response) {
  			if (response.status === 'connected') {
				FB.logout(function(response) { /* user is now logged out */	}); 
  			}
		});
		/* 카카오 로그아웃 */
		Kakao.Auth.logout(function () {  alert("카카오로그아웃");});
    
		location.href="logout.do";		
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
</script>