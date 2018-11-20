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

    
<!-- 와디즈? --><!-- 
<link rel="stylesheet" href="https://cdn.wadiz.kr/resources/assets/vendor.css?966a1957dbe0ea1e47a26794a40b2772">
<link rel="stylesheet" href="https://cdn.wadiz.kr/resources/assets/common.css?d20d62524c900b9f022ca2a3a0587a50">
<link rel="stylesheet" href="/resources/static/css/reset.css">
 -->

<!-- 썸머노트(반응형 스마트 에디터) -->

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/js/bootstrap.min.js"></script>
<link href="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.9/summernote-bs4.css" rel="stylesheet">
<script src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.9/summernote-bs4.js"></script>


<!-- 구글 웹폰트 -->
<link href="https://fonts.googleapis.com/css?family=Black+Han+Sans|Do+Hyeon|Jua|Noto+Sans+KR|Noto+Serif+KR:400,500,600,700,900" rel="stylesheet">

<style type="text/css">
/* h2{ */
	/* font-family: 'Noto Sans KR', sans-serif;*/
	/* font-family: 'Do Hyeon', sans-serif; */
	/* font-family: 'Jua', sans-serif;  */
	/* font-family: 'Noto Serif KR', sans-serif; */
/* } */
h1, tr, a{
	font-family: 'Jua', sans-serif;
}
a{
	font-size: 1em;
	color: black;
}
tr, td, input{
	font-size: 17px;
}
/* #accordion{
	font-size: 5%;
} */
</style>



<script>
	// 썸머노트 설정
	$(document).ready(function() {
		  $('#summernote').summernote();
	});
	$('#summernote').summernote({
	  placeholder: 'Hello bootstrap 4',
	  tabsize: 2,
	  height: 600,                 // set editor height
	  minHeight: null,             // set minimum height of editor
	  maxHeight: null,             // set maximum height of editor
	  focus: true     
	});
</script>

</head>
<body>
<%-- 
<div id="header">
	<jsp:include page="/WEB-INF/views/common/header.jsp" flush="false">
		<jsp:param value="${header }" name="header"/>
	</jsp:include>
</div>
<br><br><br><br> --%>

<div style="width: 70%; margin: 0 auto;">



<!-- 상단 탭 모음 -->
<ul class="nav nav-tabs">
  <li class="active"><a data-toggle="tab" href="#home" style="font-size: 2em">프로젝트 개요</a></li>
  <li><a data-toggle="tab" href="#menu1" style="font-size: 2em">스토리텔링</a></li>
  <li><a data-toggle="tab" href="#menu2" style="font-size: 2em">Menu 2</a></li>
</ul>

<!-- 탭 하단 내용 -->
<div class="tab-content">

<!-- (1) 첫번째 탭 -->
<div id="home" class="tab-pane fade in active">
<br>

<!-- 큰 테두리 -->
<div class="container">
  <h1>프로젝트 개요</h1>
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
							<button type="button" class="btn btn-primary btn-block" style="font-size: 1em">Reward (상품)</button>
							<button type="button" class="btn btn-primary btn-block" style="font-size: 1em">Donation (기부)</button>
						</div>
					</td>
				</tr>
				<tr>
					<td>
						<div class="form-group">
						  <label for="sel1">Project Category(택 1):</label>
						  <select class="form-control" id="sel1" style="font-size: 1em; height: 10%">
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
</div>





<!-- (2) 두번째 탭 -->
<div id="menu1" class="tab-pane fade">
<br>
<!-- 큰 테두리 -->
<div class="container">
  <h1>스토리텔링</h1>
  	<div class="panel-group" id="accordion">
  	
    <!-- [5] 프로젝트 스토리(content) -->
    <div class="panel panel-default">
      <div class="panel-heading">
        <h4 class="panel-title">
          <a data-toggle="collapse" data-parent="#accordion" href="#collapse5" id="col_content">프로젝트 스토리</a>
        </h4>
      </div>
      <div id="collapse5" class="panel-collapse collapse">
        <div class="panel-body">
        	<table style="width: 100%">
				<tr>
					<td>
						<div class="desc projectimg">
							펀딩을 통해 무엇을 만들고 싶은지, 이루고 싶은 목표가 무엇인지 알려주세요.<br>
							서포터가 제품의 장점이나 특징을 잘 이해할 수 있도록 간략하게 소개해 주세요.
						</div>
					</td>
				</tr>
				<tr>
					<td>
						<form method="post">
							<textarea id="summernote" name="editordata"></textarea>
						</form>
					</td>
				</tr>
			</table>
        </div>
      </div>
    </div>
    <!-- [6] 태그 -->
    <div class="panel panel-default">
      <div class="panel-heading">
        <h4 class="panel-title">
          <a data-toggle="collapse" data-parent="#accordion" href="#collapse6" id="col_content">검색용 태그</a>
        </h4>
      </div>
      <div id="collapse6" class="panel-collapse collapse">
        <div class="panel-body">
        	<table style="width: 100%">
				<tr>
					<td>
						<div class="desc projectimg">
							내부 또는 외부 검색엔진에서 프로젝트가 잘 검색될 수 있도록, 사람들이 검색할만한 프로젝트의 핵심 단어를 입력해주세요.<br>
							최소 0개부터 최대 10개까지 입력하실 수 있습니다.
						</div>
					</td>
				</tr>
				<tr>
					<td>
						<input type="text" class="form-control" placeholder="태그는 #로 구분해주세요" id="tag" name="tag" size="100%">
					</td>
				</tr>
			</table>
        </div>
      </div>
    </div>
    <!-- [7] 목표 금액 설정 -->
    <div class="panel panel-default">
      <div class="panel-heading">
        <h4 class="panel-title">
          <a data-toggle="collapse" data-parent="#accordion" href="#collapse7" id="col_content">목표 금액 설정</a>
        </h4>
      </div>
      <div id="collapse7" class="panel-collapse collapse">
        <div class="panel-body">
        	<table style="width: 100%">
				<tr>
					<td>
						<div class="form-group">
						  <label for="sel1">목표 금액을 입력해주세요</label>
						</div>
					</td>
					<td>
						<input type="text" class="form-control" placeholder="0" id="goalfund" name="goalfund" size="100%">원
					</td>
				</tr>
			</table>
        </div>
      </div>
    </div>
    <!-- [8] 계좌 설정 -->
    <div class="panel panel-default">
      <div class="panel-heading">
        <h4 class="panel-title">
          <a data-toggle="collapse" data-parent="#accordion" href="#collapse8" id="col_bank">계좌 등록</a>
        </h4>
      </div>
      <div id="collapse8" class="panel-collapse collapse">
        <div class="panel-body">
        	<table style="width: 100%">
				<tr>
					<td>
						<div class="form-group">
						  <label for="sel1">후원금을 수령할 은행계좌를 등록해주세요</label>
						</div>
					</td>
				</tr>
				<tr>
					<td>
						<div class="form-group">
						  <label for="sel1">거래은행</label>
						  <select class="form-control" id="sel1" style="font-size: 1em; height: 10%">
						    <option>은행을 선택하세요</option>
						    <option>IBK기업은행</option>
						    <option>KB국민은행</option>
						    <option>NH농협</option>
						    <option>KEB하나은행</option>
						    <option>신한은행</option>
						    <option>씨티은행</option>
						    <option>카카오뱅크</option>
						    <option>새마을은행</option>
						    <option>우리은행</option>
						    <option>우체국</option>
						    <option>기타</option>
						  </select>
						</div>
					</td>
				</tr>
				<tr>
					<td>
						<div class="form-group">
						  <label for="sel1">계좌 번호</label>
						  <input type="text" class="form-control" id="bank" name="bank" size="100%">
						</div>
					</td>
				</tr>
			</table>
        </div>
      </div>
    </div>
    <!-- [9] 데이트 -->
    <div class="panel panel-default">
      <div class="panel-heading">
        <h4 class="panel-title">
          <a data-toggle="collapse" data-parent="#accordion" href="#collapse8" id="col_bank">프로젝트 진행 스케줄</a>
        </h4>
      </div>
      <div id="collapse8" class="panel-collapse collapse">
        <div class="panel-body">
        	<table style="width: 100%">
				<tr>
					<td>
						<div class="form-group">
						  <label for="sel1">후원금을 수령할 은행계좌를 등록해주세요</label>
						</div>
					</td>
				</tr>
				<tr>
					<td>
						<div class="form-group">
						  <label for="sel1">거래은행</label>
						  <select class="form-control" id="sel1" style="font-size: 1em; height: 10%">
						    <option>은행을 선택하세요</option>
						    <option>IBK기업은행</option>
						    <option>KB국민은행</option>
						    <option>NH농협</option>
						    <option>KEB하나은행</option>
						    <option>신한은행</option>
						    <option>씨티은행</option>
						    <option>카카오뱅크</option>
						    <option>새마을은행</option>
						    <option>우리은행</option>
						    <option>우체국</option>
						    <option>기타</option>
						  </select>
						</div>
					</td>
				</tr>
				<tr>
					<td>
						<div class="form-group">
						  <label for="sel1">계좌 번호</label>
						  <input type="text" class="form-control" id="bank" name="bank" size="100%">
						</div>
					</td>
				</tr>
			</table>
        </div>
      </div>
    </div>
    
  </div>
</div>
</div>

<!-- (3) 세번째 탭 -->
<div id="menu2" class="tab-pane fade">
  <h3>Menu 2</h3>
  <p>Some content in menu 2.</p>
</div>
</div>



</div>

<%-- 

<div id="footer">
	<jsp:include page="/WEB-INF/views/common/footer.jsp" flush="false">
		<jsp:param value="${footer }" name="footer"/>
	</jsp:include>
</div>
 --%>




</body>
</html>