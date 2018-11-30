<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%-- <%@taglib  prefix="form" uri="http://www.springframework.org/tags/form" %> --%>
<fmt:requestEncoding value="UTF-8"/>

<!-- 패널 접었다 폈다 할 수 있는 기능(https://www.w3schools.com/bootstrap/bootstrap_collapse.asp 참고) -->
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- 썸머노트(반응형 스마트 에디터) -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js"></script>
<link href="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.9/summernote-bs4.css" rel="stylesheet">
<script src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.9/summernote-bs4.js"></script>
<script src="./js/summernote-ko-KR.js"></script>

<style type="text/css">
/* h2{ 아래와 같은 폰트를 전부 사용할 수 있다.*/ 
	/* font-family: 'Noto Sans KR', sans-serif;*/
	/* font-family: 'Do Hyeon', sans-serif; */
	/* font-family: 'Jua', sans-serif;  */
	/* font-family: 'Noto Serif KR', sans-serif; */
/* } */
h1, h4, tr, a{
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
	
$(document).ready(function() {
		
		// 썸머노트 설정
		  $('#summernote').summernote({
			height: 300,		// 기본 높이값
			minHeight: null,	// 최소 높이값(null은 제한 없음)
			maxHeight: null,	// 최대 높이값(null은 제한 없음)
			focus: false,		// 페이지가 열릴때 포커스를 지정함
			lang : 'ko-KR'	  
		  });
		
		// 이상하게 이 페이지 들어오자마자 프로젝트 스토리가 열려서, 걍 닫아주는용.
		$("#summernoteTap").click();
		
		// 들어오자마자 글자수 판정
		checkLength($("#title"),'#titleLen',30);
		checkLength($("#summary"),'#commentLength',100);
		
		var myAccount = '${findPro.bank}'.split('/');	// 카카오뱅크/110422942251
		var bank = myAccount[0];	// 카카오뱅크
		var account = myAccount[1];	// 110422942251
		
		// 은행 select 기존 옵션으로 기본설정 세팅
		$("#bankname").val(bank).prop("selected", true);
		// 계좌도 기존 입력값으로 세팅
		$("#accountNumber").val(account);
});	
</script>





<!-- 프로젝트 생성에 필요한 입력값을 컨트롤러에 전송하기 위한 큰 form -->
<form id="updateProjectFrom" method="post" action="projectUpdateAf.do" enctype="multipart/form-data">
	<input type="hidden" id="bank" name="bank">
	<input type="hidden" id="id" name="id" value="${login.id}">
	<input type="hidden" name="seq" value="${findPro.seq }">
	<input type="hidden" id="originImage" name="originImage" value="${findPro.seq }.jpg">	<!-- PNG파일이면 어쩜..?ㅠㅠ -->


<!-- 콘텐츠를 전부 중간맞춤하기 위한 가장 외부의 div -->
<div style="width: 70%; margin: 0 auto;">

<!-- 탭 하단에 나오는 내용 div -->
<div class="tab-content">


<!-- (1) 첫번째 탭 눌렀을 때 -->
<div id="home" class="tab-pane fade show active" role="tabpanel" aria-labelledby="home-tab">
<br>

<!-- 큰 테두리 -->
<div class="container">
  <h1>등록 프로젝트 수정</h1>
  <div class="accordion" id="accordionExample">
  	<!-- [1] 프로젝트 제목 -->
	<div class="card border-secondary mb-1"   style="border: 1px solid rgba(0,0,0,.125);">
    <!-- 위 -->
      <div class="card-header" id="headionOne">
        <h4 class="mb-0">    				
	       <label style="cursor:pointer" data-toggle="collapse" data-target="#collapseOne" 
	       			aria-expanded="true" aria-controls="collapseOne" id="titleTap">프로젝트 제목</label>
        </h4>
      </div>
    <!-- 아래 -->
      <div id="collapseOne" class="collapse show" aria-labelledby="headingOne" data-parent="#accordionExample">
        <div class="card-body">
        	<table class="card-text" style="width: 100%">
				<tr>
					<td colspan="2">
						<input type="text" class="form-control" placeholder="제목을 입력해 주세요" id="title" name="title" size="100%" 
								onkeyup="checkLength(this,'#titleLen',30)" value="${findPro.title} ">
					</td>
				</tr>
				<tr>
					<td>
						<span style="color: #4B088A; margin-left: 2%;">
							<span id="titleLen">30자 남았습니다.</span>
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
    <div class="card border-secondary mb-1">
    	<!-- 위 -->
		<div class="card-header" id="headingTwo">        
		  <h4 class="mb-0">
		  	<label class="collapsed" style="cursor:pointer" data-toggle="collapse" data-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo" id="col_image">대표 이미지</label>          
		  </h4>
		</div>
      	<!-- 아래 -->
		<div id="collapseTwo" class="collapse" aria-labelledby="headingTwo" data-parent="#accordionExample">
        <div class="card-body">
	        	<table  class="card-text" style="width: 100%">
					<tr>
						<td colspan="2">
							<div class="desc projectimg">
								메이커와 리워드가 함께 있거나, 프로젝트의 성격이 한눈에 드러나는 사진이 좋습니다.
								<a href="#none" onclick="openImgGuide('2');">가이드</a>를 확인하세요.
								<!-- 나중에 시간나면 openImgGuide()함수 만들어서 가이드가 모달창으로 뜨게 해주자 -->
							</div>
						</td>
					</tr>
					<tr>
						<td>
							<span style="color: #4B088A; margin-left: 2%;">
								<ul>
						          <li>사이즈: 가로1200px  세로675px </li>
						          <li>용량 : 3MB 미만</li>
						          <li>텍스트 및 로고 삽입 금지</li>
						        </ul>
							</span>
						</td>
						<td align="right" style="text-align: left">
							<input type="file" id="newImage" name="fileload" style=" width : 400px;"
									accept="image/jpg, image/gif, image/png, image/jpeg, image/bmp">
							<!-- 이미지는 type이 file! -->
							<!-- accept를 사용해 파일찾기 클릭해서 탐색창이 나올때 이밎 외에 파일은 모이지 않게 막는다. -->
							<!-- DB에는 프로젝트 테이블의 seq 값으로 파일이름 설정해줄것. -->
						</td>
					</tr>
					<tr>
						<td colspan="2">
							<img alt="" src="D:/stsToEclipse/.metadata/.plugins/org.eclipse.wst.server.core/tmp0/wtpwebapps/TheFun/upload/1.jpg">
						</td>
					</tr>
				</table>
        </div>
      </div>
    </div>
    <!-- [3] 프로젝트 요약 -->
    <div class="card border-secondary mb-1">
    	<!-- 위 -->
		<div class="card-header" id="headingThree">        
		  <h4 class="mb-0">
		  	<label class="collapsed" style="cursor:pointer" data-toggle="collapse" data-target="#collapseThree" aria-expanded="false" aria-controls="collapseThree" id="summarryTap">프로젝트 요약</label>          
		  </h4>
		</div>
      	<!-- 아래 -->
		<div id="collapseThree" class="collapse" aria-labelledby="headingThree" data-parent="#accordionExample">
        <div class="card-body">
	        	<table style="width: 100%">
				<tr>
					<td colspan="2">
						<div class="form-group">
						  <label for="comment">Comment:</label>
						  <textarea class="form-control" rows="5" id="summary" name="summary" 
						  			onkeyup="checkLength(this,'#commentLength',100)">${findPro.summary }</textarea>
						</div>
					</td>
				</tr>
				<tr>
					<td>
						<span style="color: #4B088A; margin-left: 2%;">
							<span id="commentLength">100자 남았습니다.</span>
						</span>
					</td>
					<td align="right">
						<a data-toggle="collapse" href="#col_summary">
							<button style="color: #4B088A">취소하기</button>
							<!-- 취소하기버튼 다 없애기. 아님 다른 기능으로 만들던가. -->
						</a>
					</td>
				</tr>
			</table>
        </div>
      </div>
    </div>
    <!-- [4] 프로젝트 스토리(content) -->
	<div class="card border-secondary mb-1"   style="border: 1px solid rgba(0,0,0,.125);">
    <!-- 위 -->
      <div class="card-header" id="headionFour">
        <h4 class="mb-0">    				
	       <label style="cursor:pointer" data-toggle="collapse" data-target="#collapseFour" aria-expanded="true" aria-controls="collapseFour" id="summernoteTap">프로젝트 스토리</label>		
        </h4>
      </div>
    <!-- 아래 -->
      <div id="collapseFour" class="collapse show" aria-labelledby="headingFour" data-parent="#accordionExample">
        <div class="card-body">
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
							<textarea id="summernote" name="content">${findPro.content }</textarea>
					</td>
				</tr>
			</table>
        </div>
      </div>
    </div>
    <!-- [5] 계좌 등록 -->
    <div class="card border-secondary mb-1">
    	<!-- 위 -->
		<div class="card-header" id="headingFive">        
		  <h4 class="mb-0">
		  	<label class="collapsed" style="cursor:pointer" data-toggle="collapse" data-target="#collapseFive" aria-expanded="false" aria-controls="collapseFive"
		  			id="bankTap">계좌 등록</label>          
		  </h4>
		</div>
      	<!-- 아래 -->
		<div id="collapseFive" class="collapse" aria-labelledby="headingFive" data-parent="#accordionExample">
        <div class="card-body">
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
						  <select class="form-control" id="bankname" style="font-size: 1em; height: 10%">
						    <option>은행을 선택하세요</option>
						    <option>IBK기업은행</option>
						    <option>KB국민은행</option>
						    <option>NH농협</option>
						    <option>KEB하나은행</option>
						    <option>신한은행</option>
						    <option>씨티은행</option>
						    <option>카카오뱅크</option>
						    <option>새마을금고</option>
						    <option>우리은행</option>
						    <option>우체국</option>
						  </select>
						</div>
					</td>
				</tr>
				<tr>
					<td>
						<div class="form-group">
						  <label for="sel1">계좌 번호</label>
						  <input type="text" class="form-control" id="accountNumber" placeholder="중간바(-)는 빼고 숫자만 입력해주세요" style="font-size: 15px" size="100%">
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






</div>


<!-- 전송버튼 -->
<input type="button" id="btn_submit" value="수정하기">
</form>


<script>


//수정하기 버튼 눌렀을 때
$("#btn_submit").click(function () {
	alert("업뎃!");
	
	/* 공란 거르기 */
	
		// [1] 첫번째 탭 값
	var title = $("#title").val();
	var mainImage = $("#newImage").val();
	var summary = $("#summary").val();
	var summernote = $("#summernote").val();
	var bankname = $("#bankname").val();
	var accountNumber = $("#accountNumber").val();
	
	alert("bankname = " + bankname);
	
	
	// 1. 공통입력사항 공란 판정
	if(title == null || title == ""){
		alert("제목을 입력해주세요");
		$("#titleTap").click();
		return;
	} else if(title.length > 30){
		alert("제목이 너무 깁니다. 줄여주세요.");
		$("#home-tab").click();
		$("#titleTap").click();
	} else if(mainImage == null || mainImage == ""){
		alert("이미지를 등록주세요");
		$("#col_image").click();
		return;
	} else if(summary == null || summary == ""){
		alert("프로젝트 요약을 등록해주세요");
		$("#summarryTap").click();
		return;
	} else if(summary.length > 100){
		alert("프로젝트 요약이 너무 깁니다. 줄여주세요");
		$("#home-tab").click();
		$("#summarryTap").click();
	} else if(summernote == null || summernote == ""){
		alert("프로젝트 스토리를 등록해주세요");
		$("#summernoteTap").click();
		return;
	} else if(summernote.length > 4000){
		alert("프로젝트 스토리가 너무 깁니다. 줄여주세요.");
		$("#menu-tab1").click();
		$("#summernoteTap").click();
	} else if(bankname == null || bankname == "" || bankname == "은행을 선택하세요" || accountNumber == null || accountNumber == ""){
		alert("은행을 선택해주세요");
		$("#bankTap").click();
		return;
	} else if(accountNumber.length > 15){
		alert("계좌번호가 너무 깁니다. 줄여주세요.");
		$("#menu-tab1").click();
		$("#bankTap").click();
	} else{	// 공통 입력사항을 모두 기입했을 때
		
		formSubmit(bankname, accountNumber);
		  
	}
	
});

// form에 submit 최종실행 함수!
function formSubmit(bankname, accountNumber) {
	// 선택한 은행+계좌번호 가져와
	alert(bankname + accountNumber);
	// hidden에 bank값 세팅
	$("#bank").val(bankname + "/" + accountNumber);
	
	// form 실행! 컨트롤러로~
	$("#updateProjectFrom").submit();
}

/* 글자 길이 확인 */
function checkLength (selector,messageSelector,maxlength){
	var curr = $(selector).val().length;
	var left = maxlength-curr;
	if(left>0){
		$(messageSelector).text(maxlength-curr + "자 남았습니다.");
		$(messageSelector).css("color", "#4B088A");
	}else{
		$(messageSelector).text(curr-maxlength + "자 초과했습니다.");
		$(messageSelector).css("color", "red");
	}
}


</script>
 


