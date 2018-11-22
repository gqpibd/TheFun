<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:requestEncoding value="utf-8"/>


<meta http-equiv="Content-Type" content="text/html; charset=UTF-8;">
<meta name="google-signin-client_id" content="884451928834-qqlq8ck53ft5q6at5am0anhmkg43jq3b.apps.googleusercontent.com"> <!-- 구글 api사용 -->
<script src="https://apis.google.com/js/platform.js" async defer></script> <!-- 구글 아이디로 로그인 -->


<%-- <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/CSS/initial.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/CSS/table.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/CSS/button.css"> --%>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>


 <!-- main CSS설정 -->
 <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
 <meta name="description" content="">
 <meta name="author" content="">


<!-- Bootstrap core CSS -->
<link href="CSS/mainVendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<!-- Custom styles for this template -->
<link href="CSS/mainCss/portfolio-item.css" rel="stylesheet">
<!-- mainCSS 설정 끝 -->

<!-- Bootstrap core JavaScript -->
<script src="CSS/mainVendor/jquery/jquery.min.js"></script>
<script src="CSS/mainVendor/bootstrap/js/bootstrap.bundle.min.js"></script>

//////////////////////////////////////////////////////////////////////////////
 
 <style type="text/css">
 .pTitle{
 	font-weight: bold;
 	color: black;
 	font-size: large;
 }
 .pName{
 	color: gray;
 	font-size: small;
 }
 </style>
 
 //////////////////////////////////////////////////
 
<script type="text/javascript">

	function logout() {
		console.log("로그아웃")
		//gapi.auth2.getAuthInstance().signOut();
		//navigator.credentials.requireUserMediation();
		location.href="logout.do";
		
	}
	
	/* topbar.jsp */
	$(document).ready(function () {
	   	$("#search_Btn").click(function () {
	   		$("#frm_search").attr("action","searchProject.do").submit();
		});
	});
	    
	/* topbar.jsp */
    function search_Enter() {	// 엔터 쳤을 때 검색
    	$("#frm_search").attr("action","searchProject.do").submit();
	}
	
	
	
	
</script>
 
 
 
 

 