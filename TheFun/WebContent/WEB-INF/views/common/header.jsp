<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8;">
<meta name="google-signin-client_id" content="884451928834-qqlq8ck53ft5q6at5am0anhmkg43jq3b.apps.googleusercontent.com"> <!-- 구글 아이디로 로그인 -->
											  
<!-- 공통폰트 -->


<!-- 공유하기 api 설정 -->
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width"/> 

<!-- bootstrap icon -->
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.5.0/css/all.css" integrity="sha384-B4dIYHKNBt8Bc12p+WXckhzcICo0wtJAoU8YZTY5qE0Id1GSseTk6S+L3BlXeVIU" crossorigin="anonymous">
<link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css">
<link rel="icon" href="image/favicon.ico" type="image/x-icon" >
<!-- Bootstrap core CSS -->
<link href="CSS/mainVendor/bootstrap/css/bootstrap.min.css" rel="stylesheet"><!-- v4.1.1  -->
<!-- Custom styles for this template -->
<!-- <link href="CSS/mainCss/portfolio-item.css" rel="stylesheet"> -->
<!-- mainCSS 설정 끝 -->

<!-- Bootstrap core JavaScript -->
<script src="CSS/mainVendor/jquery/jquery.min.js"></script> <!-- jquery -->
<script src="CSS/mainVendor/bootstrap/js/bootstrap.bundle.min.js"></script> <!-- v4.1.1 -->

<!-- 계정 연동 로그인 -->
<script src="https://apis.google.com/js/platform.js" async defer></script> <!-- 구글 연동 로그인에 필요 --> 
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script> <!-- 카카오로그인, 공유하기  -->
<script src="js/naveridlogin_js_sdk_2.0.0.js" charset="utf-8"></script><!-- 네이버 아이디로 로그인 -->

<%-- <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/CSS/initial.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/CSS/table.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/CSS/button.css"> --%>

<!-- jquery UI용 -->
<link rel="stylesheet" href="http://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css" type="text/css" />
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script> <!-- jquery UI용 js -->

<!-- 구글 웹폰트 : family다음부분부터 서로 조합해서 사용가능한 폰트 목록들. 앞 목록 + 뒤 크기 원하는대로 조합하기. -->
<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic:400,700,800&amp;subset=korean" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Black+Han+Sans|Do+Hyeon|Jua|Noto+Sans+KR|Noto+Serif+KR:400,500,600,700,900" rel="stylesheet">

<!-- main CSS설정 -->
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content=""> 

<!-- 차트 css -->
<link rel="stylesheet" href="https://cdn.rawgit.com/theus/chart.css/v1.0.0/dist/chart.css" />

<style type="text/css"> /* 공통 글씨체 */
body{
	font-family: "Nanum Gothic", sans-serif;
}
/* 버튼 */
.fun_btn {
	-moz-box-shadow: inset 0px 1px 0px 0px #d3c2ff;
	-webkit-box-shadow: inset 0px 1px 0px 0px #d3c2ff;
	box-shadow: inset 0px 1px 0px 0px #d3c2ff;
	background: -webkit-gradient(linear, left top, left bottom, color-stop(0.05, #a78af2
		), color-stop(1, #8152f0));
	background: -moz-linear-gradient(top, #a78af2 5%, #8152f0 100%);
	background: -webkit-linear-gradient(top, #a78af2 5%, #8152f0 100%);
	background: -o-linear-gradient(top, #a78af2 5%, #8152f0 100%);
	background: -ms-linear-gradient(top, #a78af2 5%, #8152f0 100%);
	background: linear-gradient(to bottom, #a78af2 5%, #8152f0 100%);
	filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#a78af2',
		endColorstr='#8152f0', GradientType=0);
	background-color: #a78af2;
	-moz-border-radius: 6px;
	-webkit-border-radius: 6px;
	border-radius: 6px;
	border: 1px solid #8152f0;
	display: inline-block;
	cursor: pointer;
	color: #ffffff;
	font-family: Arial;
	font-size: 15px;
	font-weight: bold;
	padding: 6px 24px;
	text-decoration: none;
	text-shadow: 0px 1px 0px #7754d1;
	outline: none;
}

.fun_btn:hover {
	background: -webkit-gradient(linear, left top, left bottom, color-stop(0.05, #8152f0
		), color-stop(1, #a78af2));
	background: -moz-linear-gradient(top, #8152f0 5%, #a78af2 100%);
	background: -webkit-linear-gradient(top, #8152f0 5%, #a78af2 100%);
	background: -o-linear-gradient(top, #8152f0 5%, #a78af2 100%);
	background: -ms-linear-gradient(top, #8152f0 5%, #a78af2 100%);
	background: linear-gradient(to bottom, #8152f0 5%, #a78af2 100%);
	filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#8152f0',
		endColorstr='#a78af2', GradientType=0);
	background-color: #8152f0;
}

.fun_btn:active {
	position: relative;
	top: 1px;
}

.fun_btn:focus .cancel_btn:focus{
	outline: none;
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


