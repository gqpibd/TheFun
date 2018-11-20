<%@ page contentType="text/html; charset=UTF-8"%>
  
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib  prefix="form" uri="http://www.springframework.org/tags/form" %>
<fmt:requestEncoding value="UTF-8"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<!-- 패널 접었다 폈다 할 수 있는 기능(https://www.w3schools.com/bootstrap/bootstrap_collapse.asp 참고) -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

    
<!-- 와디즈? -->
<link rel="stylesheet" href="https://cdn.wadiz.kr/resources/assets/vendor.css?966a1957dbe0ea1e47a26794a40b2772">
<link rel="stylesheet" href="https://cdn.wadiz.kr/resources/assets/common.css?d20d62524c900b9f022ca2a3a0587a50">
<link rel="stylesheet" href="/resources/static/css/reset.css">


<!-- 구글 웹폰트 -->
<link href="https://fonts.googleapis.com/css?family=Black+Han+Sans|Do+Hyeon|Jua|Noto+Sans+KR|Noto+Serif+KR:400,500,600,700,900" rel="stylesheet">

<style type="text/css">
h2{
	/* font-family: 'Noto Sans KR', sans-serif;*/
	font-family: 'Do Hyeon', sans-serif;
	/* font-family: 'Jua', sans-serif;  */
	/* font-family: 'Noto Serif KR', sans-serif; */
}
tr, a{
	font-family: 'Jua', sans-serif;
}
a{
	color: black;
}
</style>

</head>
<body>
<%-- 
<div id="header">
	<jsp:include page="/WEB-INF/views/common/header.jsp" flush="false">
		<jsp:param value="${header }" name="header"/>
	</jsp:include>
</div>
<br><br><br><br> --%>

<!-- <div class="form-control" style="width: 70%; margin: 0 auto;"> -->
	 
<div class="container">
  <h2>프로젝트 개요</h2>
  <div class="panel-group" id="accordion">
  	<!-- [1] 제목 -->
    <div class="panel panel-default">
    	<!-- 위 -->
      <div class="panel-heading">
        <h4 class="panel-title">
        	<table style="width: 100%">
        		<tr>
        			<td>
        				<span>
	        				<a data-toggle="collapse" data-parent="#accordion" href="#collapse1" id="col_title">프로젝트 제목</a>
        				</span>
        			</td>
        			<td align="right">
        				<span>
							미작성.
						</span>
        			</td>
        		</tr>
			</table>
        </h4>
      </div>
      	<!-- 아래 -->
      <div id="collapse1" class="panel-collapse collapse in">
        <div class="panel-body">
        	<table style="width: 100%">
				<tr>
					<td colspan="2">
						<input type="text" class="form-control" placeholder="제목을 입력해 주세요" id="title" name="title" size="100%">
					</td>
				</tr>
				<tr>
					<td>
						<span style="color: #4B088A; margin-left: 2%;">
							30자 남았습니다.
						</span>
					</td>
					<td align="right">
						<a data-toggle="collapse" href="#col_title">
							<button style="color: #4B088A">취소하기</button>
						</a>
					</td>
				</tr>
			</table>
        </div>
      </div>
    </div>
    <!-- [2] 대표 이미지 -->
    <div class="panel panel-default">
    	<!-- 위 -->
      <div class="panel-heading">
        <h4 class="panel-title">
          <a data-toggle="collapse" data-parent="#accordion" href="#collapse2"  id="col_image">대표 이미지</a>
        </h4>
      </div>
      	<!-- 아래 -->
      <div id="collapse2" class="panel-collapse collapse">
        <div class="panel-body">
        	<form name="frmForm" id="_frmForm" action="imgupload.do" method="post" 
					enctype="multipart/form-data">
	        	<table style="width: 100%">
					<tr>
						<td colspan="2">
							<div class="desc projectimg">
								메이커와 리워드가 함께 있거나, 프로젝트의 성격이 한눈에 드러나는 사진이 좋습니다.
								<a href="#none" onclick="openImgGuide('2');">가이드</a>를 확인하세요.
							</div>
						</td>
					</tr>
					<tr>
						<td>
							<span style="color: #4B088A; margin-left: 2%;">
								<ul>
						          <li>사이즈: 가로1200px  세로675px </li>
						          <li>용량 : 3MB 미만</li>
						          <li>텍스트 및 로고 삽입 금지 </li>
						        </ul>
							</span>
						</td>
						<td align="right" style="text-align: left">
							<input type="file" name="fileload" style=" width : 400px;">
						</td>
					</tr>
				</table>
			</form>
        </div>
      </div>
    </div>
    <!-- [3] 프로젝트 요약 -->
    <div class="panel panel-default">
      <div class="panel-heading">
        <h4 class="panel-title">
          <a data-toggle="collapse" data-parent="#accordion" href="#collapse3" id="col_summary">프로젝트 요약</a>
        </h4>
      </div>
      <div id="collapse3" class="panel-collapse collapse">
        <div class="panel-body">
        	<table style="width: 100%">
				<tr>
					<td colspan="2">
						<div class="form-group">
						  <label for="comment">Comment:</label>
						  <textarea class="form-control" rows="5" id="comment"></textarea>
						</div>
					</td>
				</tr>
				<tr>
					<td>
						<span style="color: #4B088A; margin-left: 2%;">
							100자 남았습니다.
						</span>
					</td>
					<td align="right">
						<a data-toggle="collapse" href="#col_summary">
							<button style="color: #4B088A">취소하기</button>
						</a>
					</td>
				</tr>
			</table>
        </div>
      </div>
    </div>
    <!-- [4] 카테고리 선택 -->
    <div class="panel panel-default">
      <div class="panel-heading">
        <h4 class="panel-title">
          <a data-toggle="collapse" data-parent="#accordion" href="#collapse4" id="col_categoty">프로젝트 카테고리</a>
        </h4>
      </div>
      <div id="collapse4" class="panel-collapse collapse">
        <div class="panel-body">
        	<table style="width: 100%">
				<tr>
					<td>
						<div class="desc projectimg">
								프로젝트의 성격에 맞는 카테고리를 선택해 주세요.<br>
								(프로젝트 성격과 맞지 않는 카테고리를 선택하실 시 후원자가 해당 프로젝트를 찾기 어려워지기에 에디터에 의해 조정될 수 있습니다.)
						</div>
					</td>
				</tr>
				<tr style="margin-top: 10%">
					<td>
						<div class="form-group">
						  <label for="sel1">Project Purpose(택 1):</label>
							<button type="button" class="btn btn-primary btn-block">Reward (상품)</button>
							<button type="button" class="btn btn-primary btn-block">Donation (기부)</button>
						</div>
					</td>
				</tr>
				<tr>
					<td>
						<div class="form-group">
						  <label for="sel1">Project Category(택 1):</label>
						  <select class="form-control" id="sel1">
						    <option>Food</option>
						    <option>Animal</option>
						    <option>IT</option>
						  </select>
						</div>
					</td>
				</tr>
			</table>
        </div>
      </div>
    </div>
  </div> 
</div>



<!-- </div> -->

<%-- 

<div id="footer">
	<jsp:include page="/WEB-INF/views/common/footer.jsp" flush="false">
		<jsp:param value="${footer }" name="footer"/>
	</jsp:include>
</div>
 --%>




</body>
</html>