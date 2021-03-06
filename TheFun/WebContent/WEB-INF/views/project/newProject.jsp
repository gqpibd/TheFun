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
<script src="./js/summernote-ko-KR.js"></script>	<!-- 스마트 에디터 한글설정(메뉴 설명 등이 영어->한글로 나옴) -->

<style type="text/css">
h1, .mb-0, #createProjectFrom, #home-tab, #menu-tab1, #menu-tab2, .notChangedOption, .changedOption{
	font-family: 'Jua', sans-serif;
}
#home-tab, #menu-tab1, #menu-tab2, .notChangedOption, .changedOption{
	font-size: 1em;
	color: black;
}
tr, td, input{
	font-size: 17px;
}
.fundingBox{
	box-shadow: 5px 5px 10px 0px #c3c3c380;
	padding: 0;
	margin-top: 10px;
}
.cardLabel{
	margin:0;
}

.accordion{
	border-top: 5px solid #8152f0;
	border-radius: 0;
}

.card{
	border:0;
	border-bottom: 1px solid rgba(0,0,0,.125);
}
</style>

<script>
var dayName=["일", "월", "화", "수", "목", "금", "토"];
var monthName = ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"];
function onDateSelect(d, selector){
	// 연,월,일 구하기
	// alert(d + "선택됐습니다");
	var arr = d.split("-");
	$(selector).text(arr[0]);
	$(selector).append(arr[1]);
	$(selector).append(arr[2]);
	
	// 요일 구하기
	var date = new Date( $(selector).datepicker({dateFormat:'yy-mm-dd'}).val() );
	//alert(selector+ " : "+date.getDay() );	// 0(일요일)~6(토요일)
			
	var week = new Array("일", "월", "화", "수", "목", "금", "토");
	$(selector).append( week[ date.getDay() ] );
}
function onDatePicketClose(selectedDate, preDate, availDate){ // preDate: 앞에서 설정한 날짜. availDate: 앞으로 설정 가능한 날짜
	if( selectedDate != "" ) {
		// 펀딩 시작일은 내일날짜부터 선택가능하게
		var curDate = $(preDate).datepicker("getDate");  // Date return
		curDate.setDate( curDate.getDate() + 1 );
		// 펀딩 종료일은 선택된 시작일 담날부터 가능하게
		$(availDate).datepicker("option", "minDate", curDate);
		// 종료일 태그 활성화
		$(availDate).attr("disabled", false);
		scheduleCheck(); // 검사
	}
}

$(document).ready(function() {
	
	/* var $target = $('#category');
	$target.find('option:gt(2)').css('display', 'none'); */
		
	/* 각 리워드마다 하단 상세내용 보여주는 a태그 일단 비활성화 */
	$(".changedOption").hide();


	// 썸머노트 설정
	$('#summernote').summernote({
		height: 300,		// 기본 높이값
		placeholder : "Draw your dream!!",
		minHeight: null,	// 최소 높이값(null은 제한 없음)
		maxHeight: null,	// 최대 높이값(null은 제한 없음)
		focus: true,		// 페이지가 열릴때 포커스를 지정함
		lang : 'ko-KR',		// 한글설정
     	//onlmageUpload callback함수 -> 미설정시 data형태로 에디터 그대로 삽입
		callbacks: {
        	onImageUpload: function(files, editor) {
	       	  	console.log("onImageUpload 업로드 이벤트 발생");
	           	//for (var i = files.length - 1; i >= 0; i--) {
	             sendFile(files[0], this);
	           	//}
         	},
		 	onChange: function() { 
		 		summernoteCheck(); 
		 	}
       }	  
	});										
	// 썸머노트 이미지 컨트롤러에 실시간 업로드할 AJAX 함수
	function sendFile(file, editor) {
		var form_data = new FormData();
		form_data.append('summerFile', file);
		$.ajax({
			data: form_data,
			type: "POST",
			url: 'summernotePhotoUpload.do',
			enctype: 'multipart/form-data',
			cache: false,
			contentType: false,
			processData: false,
			success: function(data) {
				console.log("받은 데이터 = " + data);
				$(editor).summernote('editor.insertImage', data);
				//$('#imageBoard > ul').append('<li><img src="'+url+'" width="480" height="auto"/></li>');
				//$(editor).summernote('editor.insertImage', data);
				$('#summernote').append('<img src="'+data+'" width="480" height="auto"/>');
			}
		});
	}
  
  	/* 프로젝트 진행 스케줄 날짜 설정 */
	// 시작일
	$("#date1").datepicker({
		minDate : 0,
		dateFormat:"yy-mm-dd",
		dayNamesMin:dayName,
		monthNames: monthName,
		onSelect:function( d ){
			onDateSelect(d,"#date1");
		},
		onClose : function (selectedDate) {
			 onDatePicketClose(selectedDate,"#date1","#date2");		     
		}
	});
	// 종료일
	$("#date2").datepicker({
		dateFormat:"yy-mm-dd",
		dayNamesMin:dayName,				
		monthNames: monthName,
		onSelect:function( d ){
			onDateSelect(d,"#date2");
		},
		onClose : function( selectedDate ) {  // 날짜를 설정 후 달력이 닫힐 때 실행		           
			onDatePicketClose(selectedDate,"#date2","#date3");
        }
	});
	// 정산일
	$("#date3").datepicker({
		dateFormat:"yy-mm-dd",
		dayNamesMin:dayName,				
		monthNames: monthName,
		onSelect:function( d ){
			onDateSelect(d,"#date3");
		},
        onClose : function( selectedDate ) {  // 날짜를 설정 후 달력이 닫힐 때 실행		           
			onDatePicketClose(selectedDate,"#date3","#date4");
        }
	});
	// 배송일
	$("#date4").datepicker({
		dateFormat:"yy-mm-dd",
		dayNamesMin:dayName,				
		monthNames: monthName,
		onSelect:function( d ){
			onDateSelect(d,"#date4");
		},
		onClose : function( selectedDate ) {  // 날짜를 설정 후 달력이 닫힐 때 실행
            if( selectedDate != "" ) {
                // xxx의 maxDate를 yyy의 날짜로 설정
                $("#date3").datepicker("option", "maxDate", selectedDate);  
                scheduleCheck();
            }
        }
	});			
});	
</script>

<!-- 프로젝트 생성에 필요한 입력값을 컨트롤러에 전송하기 위한 큰 form -->
<form id="createProjectFrom" method="post" action="newProjectAf.do" enctype="multipart/form-data">
	<input type="hidden" id="bank" name="bank">
	<input type="hidden" id="id" name="id" value="${login.id}">
	<input type="hidden" id="optionSelected" value="NO">

<!-- 콘텐츠를 전부 중간맞춤하기 위한 가장 외부의 div -->
<div style="width: 70%; margin: 0 auto;">

<!-- 상단 탭 모음 -->
<ul class="nav nav-tabs">  
  <%-- <li class="active"> --%>
  <li class="nav-item">
  	<a class= "nav-link active" href="#home" id="home-tab" data-toggle="tab" style="font-size: 2em" role="tab" aria-controls="home" aria-selected="true">프로젝트 개요
  		<span id="introChecked" style="margin-left: 10px;float: right;display:none;color:green">✔</span>
  	</a>
  </li>  
  <li class="nav-item">
  	<a class= "nav-link" href="#menu1" id="menu-tab1"  data-toggle="tab" style="font-size: 2em" role="tab" aria-controls="menu1" aria-selected="false">스토리텔링
  		<span id="storytellingChecked" style="margin-left: 10px;float: right;display:none;color:green">✔</span>
  	</a>
  	
  </li>
  <li class="nav-item">
  	<a class= "nav-link" href="#menu2" id="menu-tab2"  data-toggle="tab" style="font-size: 2em" role="tab" aria-controls="menu2" aria-selected="false">리워드 등록
  		<span id="rewardChecked" style="margin-left: 10px;float: right;display:none;color:green">✔</span>
  	</a>
  </li>
</ul>

<!-- 탭 하단에 나오는 내용 div -->
<div class="tab-content">


<!-- (1) 첫번째 탭 눌렀을 때 -->
<div id="home" class="tab-pane fade show active" role="tabpanel" aria-labelledby="home-tab">

<!-- 큰 테두리 -->
<div class="container fundingBox" >
  <!-- <h1>프로젝트 개요</h1> -->
  <!-- card 샘플 시작 : 탭 하나 누르면 다른 탭은 자동으로 닫히는 기능 여기서 시작. accordion의 id값을 각 탭의 data-parent로 넣어주면 된다. -->
  <div class="accordion" id="accordionExample">
  	<!-- [1] 프로젝트 제목 -->
	<div class="card">
    <!-- 위 -->
       <div class="card-header" id="headionOne">
         <h4 class="mb-0">    				
	       <label class="cardLabel cardLabel" style="cursor:pointer" data-toggle="collapse" data-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne" id="titleTap">프로젝트 제목</label>		
	       <span id="titleChecked" style="float: right;opacity:0;color:green">✔</span>
	     </h4>        
      </div>
      <!-- 아래 -->
      <div id="collapseOne" class="collapse show" aria-labelledby="headingOne" data-parent="#accordionExample">
        <div class="card-body">
        	<table class="card-text" style="width: 100%">
				<tr>
					<td>
						<input type="text" class="form-control" placeholder="제목을 입력해 주세요" id="title" name="title" size="100%" onkeyup="checkLength(this,'#titleLen',40)" onblur="checkTitle()">
					</td>
				</tr>
				<tr>
					<td>
						<span style="color: #4B088A; margin-left: 2%;">
							<span id="titleLen">40자 남았습니다.</span>
						</span>
					</td>
				</tr>
			</table>
        </div>
      </div>
    </div>    
    <!-- [2] 대표 이미지 -->
    <div class="card">
    	<!-- 위 -->
		<div class="card-header" id="headingTwo">        
		  <h4 class="mb-0">
		  	<label class="collapsed cardLabel" style="cursor:pointer" data-toggle="collapse" data-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo" id="col_image">대표 이미지</label>
		  	<span id="imageChecked" style="float: right;opacity:0;color:green">✔</span>          
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
								<!-- Button trigger modal -->
							<a href="#none" data-toggle="modal" data-target="#exampleModalCenter">
								가이드
							</a>를 확인해주세요
							<!-- Modal창 내용 -->
							<div class="modal fade" id="exampleModalCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
							  <div class="modal-dialog modal-dialog-centered" role="document">
							    <div class="modal-content">
							      <div class="modal-header">
							        <h5 class="modal-title" id="exampleModalLongTitle" style="color: #FF8000">프로젝트 대표 이미지 가이드라인</h5>
							        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
							          <span aria-hidden="true">&times;</span>
							        </button>
							      </div>
							      <div class="modal-body">
							        	프로젝트 대표 이미지는 프로젝트 카드의 가장 중요한 시각적 요소입니다. 후원자들이 프로젝트를 쉽게 발견하고 더 편안한 경험을 할 수 있도록 하기 위해 THE FUN에서는 대표 이미지에 다음과 같은 가이드라인을 적용하고 있습니다.<br><br>
							        	<ul style="color: #585858">
							        		<li>제공할 선물 또는 창작 활동이 잘 드러나는 이미지를 사용해야 합니다. 프로젝트의 내용과 무관하거나 후원자를 호도할 수 있는 대표 이미지는 사용할 수 없습니다.</li>
							        		<li>작은 사이즈에서도 잘 보일 수 있도록 복잡하지 않게 구성하세요. 모바일 기기에서 대표 이미지는 손톱만한 크기로 줄어듭니다. 단순한 이미지여야 작아도 잘 보입니다.</li>
							        	</ul>
							      </div>
							      <div class="modal-footer">
							        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
							        <!-- <button type="button" class="btn btn-primary">Save changes</button> -->
							      </div>
							    </div>
							  </div>
							</div>
							<!-- Modal창 끝 -->
							</div>
						</td>
					</tr>
					<tr>
						<td>
							<div style="color: #4B088A; margin-left: 2%;">
								<ul>
						          <li>사이즈: 가로1200px  세로675px </li>
						          <li>용량 : 3MB 미만</li>
						          <li>텍스트 및 로고 삽입 금지 </li>
						        </ul>
							</div>
							<input type="file" id="mainImage" name="fileload" style=" margin-left: 6%;" 
									accept="image/jpg, image/gif, image/png, image/jpeg, image/bmp">
									<!-- 이미지는 type이 file! -->
									<!-- accept를 사용해 파일찾기 클릭해서 탐색창이 나올때 이밎 외에 파일은 모이지 않게 막는다. -->
									<!-- DB에는 프로젝트 테이블의 seq 값으로 파일이름 설정해줄것. -->
						</td>
						<td>
							<img src="" id="imgPreview" class="card-img-top" style="object-fit: cover; max-width: 400px; max-height: 400px;">
						</td>
					</tr>
				</table>
        </div>
      </div>
    </div>
    <!-- [3] 프로젝트 요약 -->
    <div class="card">
    	<!-- 위 -->
		<div class="card-header" id="headingThree">        
		  <h4 class="mb-0">
		  	<label class="collapsed cardLabel" style="cursor:pointer" data-toggle="collapse" data-target="#collapseThree" aria-expanded="false" aria-controls="collapseThree" id="summarryTap">프로젝트 요약</label>
		  	<span id="summaryChecked" style="float: right;opacity:0;color:green">✔</span>          
		  </h4>
		</div>
      	<!-- 아래 -->
		<div id="collapseThree" class="collapse" aria-labelledby="headingThree" data-parent="#accordionExample">
        <div class="card-body">
	        	<table style="width: 100%">
				<tr>
					<td>
						<div class="form-group">
						  <label for="comment">Comment:</label>
						  <textarea class="form-control" rows="5" id="summary" name="summary" onkeyup="checkLength(this,'#commentLength',100)" onblur="checkSummary()"></textarea>
						</div>
					</td>
				</tr>
				<tr>
					<td>
						<span style="color: #4B088A;">
							<span id="commentLength">100자 남았습니다.</span>
						</span>
					</td>
				</tr>
			</table>
        </div>
      </div>
    </div>
    <!-- [4] 카테고리 선택 -->
    <div class="card ">
    	<!-- 위 -->
		<div class="card-header" id="headingFour">        
		  <h4 class="mb-0">
		  	<label class="collapsed cardLabel" style="cursor:pointer" data-toggle="collapse" data-target="#collapseFour" aria-expanded="false" aria-controls="collapseFour" id="categoryTap">프로젝트 카테고리</label>
		  	<span id="categoryChecked" style="float: right;opacity:1;color:green">✔</span>          
		  </h4>
		</div>
      	<!-- 아래 -->
		<div id="collapseFour" class="collapse" aria-labelledby="headingFour" data-parent="#accordionExample">
        <div class="card-body">
	        	<table style="width: 100%">
				<tr>
					<td>
						<div class="desc projectimg">
								프로젝트의 성격에 맞는 카테고리를 선택해 주세요.<br>
								<span style="color:#8152f0">리워드</span>는 후원자분들께 드릴 선물 구성을 등록해야 합니다.<br>
								<span style="color:#8152f0">기부는</span>은 목표금액이 달성되면 후원금 전액을 목표한 곳에 기부해야 합니다.<br>
								(프로젝트 성격과 맞지 않는 카테고리를 선택하실 시 후원자가 해당 프로젝트를 찾기 어려워지기에 에디터에 의해 조정권고를 받을 수 있습니다)<br>
						</div>
					</td>
				</tr>
				<tr style="margin-top: 10%">
					<td>
						<span>프로젝트 타입</span>      
						<label for="fundtype1" class="btn btn-primary btn-block" style="font-size: 1em">
						  <input type="radio" name="fundtype" id="fundtype1" autocomplete="off" value="reward" checked="checked"> 리워드
						</label>
						<label for="fundtype2" class="btn btn-primary btn-block" style="font-size: 1em">
						  <input type="radio" name="fundtype" id="fundtype2" autocomplete="off" value="donation"> 기부
						</label>
					</td>
				</tr>
				<tr>
					<td>
						<div class="form-group">
						  <span for="sel1">프로젝트 카테고리(택 1):</span>
						  <select class="form-control" id="category" name="category" style="font-size: 1em; height: 10%">
						    <option value="food">음식</option>
							<option value="animal">동물</option>
							<option value="it">IT / 생활</option>
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
<!-- 첫번째 탭 끝 -->


<!-- (2) 두번째 탭 눌렀을 때 -->
<div id="menu1" class="tab-pane fade" role="tabpanel" aria-labelledby="menu-tab1">

<!-- 큰 테두리 -->
<div class="container fundingBox">
  <!-- <h1>스토리텔링</h1> -->
  <!-- card 샘플 시작 -->
  <div class="accordion" id="accordion1">
  	<!-- [5] 프로젝트 스토리(content) -->
	<div class="card">
    <!-- 위 -->
      <div class="card-header" id="headionFive">
        <h4 class="mb-0">    				
	       <label class="cardLabel" style="cursor:pointer" data-toggle="collapse" data-target="#collapseFive" aria-expanded="true" aria-controls="collapseFive" id="summernoteTap">프로젝트 스토리</label>
	       <span id="summernoteChecked" style="float: right;opacity:0;color:green">✔</span>		
        </h4>
      </div>
    <!-- 아래 -->
      <div id="collapseFive" class="collapse show" aria-labelledby="headingFive" data-parent="#accordion1">
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
						<textarea id="summernote" name="content"></textarea>
					</td>
				</tr>
			</table>
        </div>
      </div>
    </div>    
    <!-- [6] 태그 -->
    <div class="card">
    	<!-- 위 -->
		<div class="card-header" id="headingSix">        
		  <h4 class="mb-0">
		  	<label class="collapsed cardLabel" style="cursor:pointer" data-toggle="collapse" data-target="#collapseSix" aria-expanded="false" aria-controls="collapseSix" id="tagTap">검색용 태그</label>
		  	<span id="tagChecked" style="float: right;opacity:0;color:green">✔</span>          
		  </h4>
		</div>
      	<!-- 아래 -->
		<div id="collapseSix" class="collapse" aria-labelledby="headingSix" data-parent="#accordion1">
        <div class="card-body">
	        	<table style="width: 100%">
				<tr>
					<td>
						<div class="desc projectimg">
							내부 또는 외부 검색엔진에서 프로젝트가 잘 검색될 수 있도록, 사람들이 검색할만한 프로젝트의 핵심 단어를 입력해주세요.<br>
							최소 1개부터 최대 10개까지 입력하실 수 있습니다.
						</div>
					</td>
				</tr>
				<tr>
					<td>
						<input type="text" class="form-control" placeholder="태그는 #으로 구분해주세요. 띄어쓰기 시 자동으로 #이 입력됩니다." id="tag" name="tag" size="100%" onblur="tagCheck()">
					</td>
				</tr>
			</table>
        </div>
      </div>
    </div>
    <!-- [7] 목표 금액 설정 -->
    <div class="card  ">
    	<!-- 위 -->
		<div class="card-header" id="headingSeven">        
		  <h4 class="mb-0">
		  	<label class="collapsed cardLabel" style="cursor:pointer" data-toggle="collapse" data-target="#collapseSeven" aria-expanded="false" aria-controls="collapseSeven" id="goalfundTap">목표 금액 설정</label>
		  	<span id="goalfundChecked" style="float: right;opacity:0;color:green">✔</span>          
		  </h4>
		</div>
      	<!-- 아래 -->
		<div id="collapseSeven" class="collapse" aria-labelledby="headingSeven" data-parent="#accordion1">
        <div class="card-body">
	        	<table style="width: 100%">
				<tr>
					<td>
						<div class="form-group" style="padding-top: 10%">
						  <label for="sel1" size="20%">목표 금액을 입력해주세요</label>
						</div>
					</td>
					<td>
						<input type="text" class="form-control" placeholder="0" id="goalfund" name="goalfund" size="70%" onblur="goalfundCheck()">
					</td>
					<td>
						원
					</td>
				</tr>
			</table>
        </div>
      </div>
    </div>
    <!-- [8] 계좌 등록 -->
    <div class="card  ">
    	<!-- 위 -->
		<div class="card-header" id="headingEight">        
		  <h4 class="mb-0">
		  	<label class="collapsed cardLabel" style="cursor:pointer" data-toggle="collapse" data-target="#collapseEight" aria-expanded="false" aria-controls="collapseEight" id="bankTap">계좌 등록</label>
		  	<span id="accountChecked" style="float: right;opacity:0;color:green">✔</span>          
		  </h4>
		</div>
      	<!-- 아래 -->
		<div id="collapseEight" class="collapse" aria-labelledby="headingEight" data-parent="#accordion1">
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
						  <select class="form-control" id="bankname" style="font-size: 1em; height: 10%" onchange="accountCheck()">
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
						  <input type="text" class="form-control" id="accountNumber" placeholder="중간바(-)는 빼고 숫자만 입력해주세요" style="font-size: 15px" size="100%" onblur="accountCheck()">
						</div>
					</td>
				</tr>
			</table>
        </div>
      </div>
    </div>
    <!-- [9] 프로젝트 진행 스케줄 -->
    <div class="card ">
    	<!-- 위 -->
		<div class="card-header" id="headingNine">        
		  <h4 class="mb-0">
		  	<label class="collapsed cardLabel" style="cursor:pointer" data-toggle="collapse" data-target="#collapseNine" aria-expanded="false" aria-controls="collapseNine" id="dateTap">프로젝트 진행 스케줄</label>
		  	<span id="scheduleChecked" style="float: right;opacity:0;color:green">✔</span>          
		  </h4>
		</div>
      	<!-- 아래 -->
		<div id="collapseNine" class="collapse" aria-labelledby="headingNine" data-parent="#accordion1">
        <div class="card-body">
	        	<table style="width: 100%">
				<tr>
					<td colspan="3">
						<div class="form-group">
						  <!-- <label for="sel1"> -->
						  <div class="desc projectimg">
						  	프로젝트의 시작일, 종료일 , 정산일, 배송일을 각각 선택해주세요.<br>
						  	※기부 카테고리를 선택하셨다면, 배송일을 지정할 필요가 없습니다.※<br>
						  </div>
						  <!-- </label> -->
						</div>
					</td>
				</tr>
				<tr>
					<td>
						<div class="form-group">
						  <label for="sel1">프로젝트 시작일</label>
						</div>
					</td>
					<td>
						<input type="text" class="date" id="date1" name="sdate" placeholder="오늘부터 선택 가능합니다" size="30%" autocomplete="off">
						  <!-- autocomplete="off" : 자동완성 끄기 -->
					</td>
				</tr>
				<tr>
					<td>
						<div class="form-group">
						  <label for="sel1">프로젝트 종료일</label>
						</div>
					</td>
					<td>
						<input type="text" class="date" id="date2" name="edate" placeholder="시작일의 다음날부터 선택 가능합니다" size="30%" autocomplete="off" disabled="disabled">
					</td>
				</tr>
				<tr>
					<td>
						<div class="form-group">
						  <label for="sel1">프로젝트 정산일·결제일</label>
						</div>
					</td>
					<td>
						<input type="text" class="date" id="date3" name="pdate" placeholder="종료일의 다음날부터 선택 가능합니다" size="30%" autocomplete="off" disabled="disabled">
					</td>
				</tr>
				<tr>
					<td>
						<div class="form-group">
						  <label for="sel1">프로젝트 배송일</label>
						</div>
					</td>
					<td>
						<input type="text" class="date" id="date4" name="shipdate" placeholder="정산일의 다음날부터 선택 가능합니다" size="30%" autocomplete="off" disabled="disabled">
					</td>
					<td>
						<!-- 초기화 버튼 -->
						<button type="button" id="btn_resetDates" class="btn btn-outline-primary">Reset Date</button>
					 </td>
				</tr>
			</table>
        </div>
      </div>
    </div>
    
    </div>
	
</div>
</div>


<!-- (3) 세번째 탭 눌렀을 때 -->
<div id="menu2" class="tab-pane fade" role="tabpanel" aria-labelledby="menu-tab2">

<!-- 큰 테두리 -->
<div class="container fundingBox">
  <!-- <h1>리워드 등록</h1> -->
  <!-- card 샘플 시작 -->
  <div class="accordion" id="accordion2">
  	<!-- [10] 옵션 개수 선택 -->
	<div class="card ">
    <!-- 위 -->
      <div class="card-header" id="headionTen">
        <h4 class="mb-0">    				
	       <label class="cardLabel" style="cursor:pointer" data-toggle="collapse" data-target="#collapseTen" aria-expanded="true" aria-controls="collapseTen" id="optiontotalTap">
	       	<a data-toggle="collapse" data-parent="#accordion2" href="#collapseTen">옵션 개수 선택</a>	       	
	       </label>	
	       <span id="optionAllChecked" style="float: right;opacity:0;color:green">✔</span>	
        </h4>
      </div>
    <!-- 아래 -->
      <div id="collapseTen" class="collapse show" aria-labelledby="headingTen" data-parent="#accordion2">
        <div class="card-body">
        	<table style="width: 100%">
					<tr>
						<td>
							<div class="desc projectimg">
								후원자 분들에게 어떤 상품을 드릴까요?
							</div>
						</td>
						<td>
							<div class="form-group">
							  <label for="sel1">옵션 총 개수</label>
							  <select class="form-control" id="option_total" name="option_total" onchange="optionChange(this)" style="font-size: 1em; height: 10%">
							    <%for(int i=1; i <= 10; i++){
									%>
									<option <%=(10+"").equals(i+"")?"selected='selected'":"" %> value="<%=i%>" ><%=i%></option>
									<%
								}%>
							  </select>
							</div>
						</td>
					</tr>
				</table>
        </div>
      </div>
    </div>    
    <!-- [11] 리워드 등록 -->
	    <%
		for(int i=1; i <= 10; i++){
			%>
	    <div id="_option<%=(i+10 + "")%>">
	    
	    <div class="card ">
			    <div class="panel panel-default">
			    	<!-- 위 -->
				    <div class="card-header" id="headion<%=(i + "") %>">
				        <h5 class="mb-0">
								<a data-toggle="collapse" data-parent="#accordion" href="#collapseTen" class="notChangedOption"><%=(i + "") %>번째 상품</a>			
				          		<a data-toggle="collapse" data-parent="#accordion" href="#collapse<%=(i+10 + "")%>" id="option<%=i %>" class="changedOption"><%=(i + "") %>번째 선물</a>
				          		<span id="optionChecked<%=i%>" style="float: right;opacity:0;color:green">✔</span>
				      	</h5>
				    </div>
			    <!-- 아래 -->
			    <div id="collapse<%=(i+10 + "")%>" class="panel-collapse collapse" aria-labelledby="heading<%=(i + "") %>" data-parent="#accordion2">
        			<div class="card-body">
			        	<table style="width: 100%">
							<tr>
								<td colspan="2">
									<div class="desc projectimg">
										후원자 분들에게 드릴 상품 내용을 입력해주세요
									</div>
								</td>
							</tr>
							<tr>
								<td colspan="2">
									<div class="form-group">
									  <label for="sel1">옵션 제목</label>
									  <input type="text" class="form-control" id="op_title<%=i %>" name="op_title" placeholder="[얼리버드] 등 대표 제목을 작성해주세요" style="font-size: 15px" size="100%" onblur="optionCheck()">
									</div>
								</td>
							</tr>
							<tr>
								<td colspan="2">
									<div class="form-group">
									  <label for="sel1">아이템</label>
									  <textarea class="form-control" rows="5" id="op_content<%=i %>" name="op_content" style="font-size: 15px" placeholder="아이템은 선물에 포함되는 구성 품목을 말합니다. 각 품목은 줄바꿈으로 구분해주세요."  onblur="optionCheck()"></textarea>
									</div>
								</td>
							</tr>
							<tr>
								<td>
									<div class="form-group">
									  <label for="sel1">후원 금액</label>
									  <input type="text" class="form-control" id="op_price<%=i %>" name="op_price" placeholder="해당 옵션의 적정가를 책정해주세요" style="font-size: 15px" size="50%" maxlength="8" onblur="optionCheck()">
									</div>
								</td>
								<td>
									<div class="form-group">
									  <label for="sel1">보유 수량</label>
									  <input type="text" class="form-control" id="op_stock<%=i %>" name="op_stock" placeholder="재고 제한이 없는 경우 공란으로 비워두세요" style="font-size: 15px" size="50%" maxlength="8" onblur="optionCheck()">
									</div>
								</td>
							</tr>
						</table>
			        </div>
			      </div>
		    </div>
	    </div>	    
	    </div>
	    	<%
		}
		%>
</div>

</div>
<!-- 3번째 탭 내용 끝 -->


</div>
<!-- 전송버튼 -->
	<div align="center">
	<input type="button" class="btn btn-lg btn-primary" id="btn_submit"
		style="font-family: 'Noto Sans KR', sans-serif; margin-top: 10px;" value="프로젝트 등록">	
	</div>
</div>
</div>
</form>

<!-- 프로젝트 등록 최종확인 모달창 -->
<div class="modal fade" id="messageModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel"><b>프로젝트 등록</b></h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>     
      <div class="modal-body">
          <div class="form-group">
            <label for="recipient-name" class="col-form-label">이대로 등록하시겠습니까?</label>
          </div>       
      </div>
      <div class="modal-footer">
        <button type="button" class="btn cancel_btn" data-dismiss="modal" id="exit">취소</button>
        <button type="button" class="btn fun_btn" onclick="checkAndResubmitProject()">제출</button>
      </div>
    </div>
  </div>
</div>

<script>
// 리워드옵션 갯수 선택한만큼 리워드 row 보여주기
function optionChange( me ) {
	
	// 나중에 전송전에 리워드 갯수 선택여부만 판별해줄 용도의 변수.
	$("#optionSelected").val("OK");
	
	$(".notChangedOption").hide();
	$(".changedOption").show();
	
	var num = me.options[me.selectedIndex].value;
	//alert(num + "개");
	
	for(i=1; i <= 10; i++){		// 초기화(일단 다 숨기고)
		$("#_option" + (i+10)).val("");
		$("#_option" + (i+10)).hide();
	}
	for(i=1; i <= num; i++){	// 갯수만큼만 다시 보여짐
		$("#_option" + (i+10)).show();
		$("#col_content").click();
	}
	optionCheck();
}
//전송버튼 눌렀을 때
$("#btn_submit").click(function () {
	/* 공란 거르기 */
	
		// [1] 첫번째 탭 값
	var title = $("#title").val();
	var mainImage = $("#mainImage").val();
	var summary = $("#summary").val();
		// fundtype과 category는 기본선택값이 있어서 공란판정 필요없다.(공란이될 수 없음)
	var fundtype = $("input[name='fundtype']:checked").val();	// reward / donation 라디오버튼 선택 값 가져오기
	var category = $("#category").val();
		// [2] 두번째 탭 값
	var summernote = $("#summernote").val();
	var tag = $("#tag").val();
	var _goalfund = $("#goalfund").val();
	var goalfund = _goalfund.replace(/,/gi, "");
	var bankname = $("#bankname").val();
	var accountNumber = $("#accountNumber").val();
	var date1 = $("#date1").val();
	var date2 = $("#date2").val();
	var date3 = $("#date3").val();
		// *여기까지 공통 입력사항
		// *기부는 아래 값들 불필요(공란허용)
	var date4 = $("#date4").val();
		// [3] 세번째 탭 값
	var optionSelected = $("#optionSelected").val();	// 상품-리워드 갯수 선택했을때 "OK" / 기부or상품-리워드 갯수 선택안했을 때 "NO"
	var option_total = $("#option_total").val();
		
		// 확인용
//	alert("title = " + title + " mainImage = " + mainImage + " fundtype = "+ fundtype + " summary = " + summary + " summernote = " + summernote +
//			" tag = " + tag + " goalfund = " + goalfund + " bankname = " + bankname + " accountNumber = " + accountNumber +
//			" date1 = " + date1 + " date2 = " + date2 + " date3 = " + date3 + " date4 = " + date4 +
//			" optionSelected = " + optionSelected + " option_total = " + option_total);
		
	// 1. 공통입력사항 공란 판정
	if(title == null || title == ""){
		alert("제목을 입력해주세요");
		$("#home-tab").click();
		$("#titleTap").click();
		return;
	} else if(title.length > 40){
		alert("제목이 너무 깁니다. 줄여주세요.");
		$("#home-tab").click();
		$("#titleTap").click();
	} else if(mainImage == null || mainImage == ""){
		alert("이미지를 등록주세요");
		$("#home-tab").click();
		$("#col_image").click();
		return;
	} else if(summary == null || summary == ""){
		alert("프로젝트 요약을 등록해주세요");
		$("#home-tab").click();
		$("#summarryTap").click();
		return;
	} else if(summary.length > 100){
		alert("프로젝트 요약이 너무 깁니다. 줄여주세요");
		$("#home-tab").click();
		$("#summarryTap").click();
		return;
	} else if(summernote == null || summernote == ""){
		alert("프로젝트 스토리를 등록해주세요");
		$("#menu-tab1").click();
		$("#summernoteTap").click();
		return;
	} else if(tag == null || tag == ""){
		alert("검색용 태그를 등록해주세요");
		$("#menu-tab1").click();
		$("#tagTap").click();
		return;
	} else if(tag.length > 400){
		alert("태그가 너무 깁니다. 줄여주세요");
		$("#menu-tab1").click();
		$("#tagTap").click();
		return;
	} else if(goalfund == null || goalfund == ""){
		alert("프로젝트 달성 목표 금액을 등록해주세요");
		$("#menu-tab1").click();
		$("#goalfundTap").click();
		return;
	} else if(goalfund.length > 10){
		alert("프로젝트 목표금액이 너무 큽니다. 줄여주세요.");
		$("#menu-tab1").click();
		$("#goalfundTap").click();
		return;
	} else if(bankname == null || bankname == "" || bankname == "은행을 선택하세요" || accountNumber == null || accountNumber == ""){
		alert("은행을 선택해주세요");
		$("#menu-tab1").click();
		$("#bankTap").click();
		return;
	} else if(accountNumber.length > 15){
		alert("계좌번호가 너무 깁니다. 줄여주세요.");
		$("#menu-tab1").click();
		$("#bankTap").click();
	} else if(date1 == null || date1 == "" || date2 == null || date2 == "" || date3 == null || date3 == ""){
		alert("프로젝트 진행 스케줄을 모두 등록해주세요");
		$("#menu-tab1").click();
		$("#dateTap").click();
		return;
	} else{	// 공통 입력사항을 모두 기입했을 때
		
		// 2. 카테고리에 따른 공란판정
		if(fundtype == "donation") {	// 기부 선택했을 경우(==> 리워드 등록 불필요)
			console.log("기부를 선택하셨습니다");
			formSubmit();	// form에 submit 실행~
			return;
		} else if(fundtype == "reward" && optionSelected == "NO"){	// 상품선택하고, 리워드 갯수 선택안함
				//alert("상품 선택하고 리워드 갯수는 선택안한 경우");
				alert("리워드 갯수를 선택하고 상세정보를 등록해주세요.");
				$("#menu-tab2").click();
				$("#optiontotalTap").click();
				return;
		} else if(fundtype == "reward" && optionSelected == "OK"){	// 상품선택하고, 리워드 갯수 선택함(==> 리워드 내용입력 필수)
		
			// 적정 목표액 판정용
			var totalPrice = 0;
			var unLimited = false;
			for(var i=1; i<=option_total; i++){
				var op_title = $("#op_title" + i).val();
				var op_content = $("#op_content" + i).val();
				var _op_price = $("#op_price" + i).val();
				var op_price = _op_price.replace(/,/gi, "");
				var _op_stock = $("#op_stock" + i).val();
				var op_stock = _op_stock.replace(/,/gi, "");
			//	alert("op_title = " + op_title + " op_content = " + op_content + " op_price = " + op_price + " op_stock = " + op_stock
			//			+ " 가격 자리수 = " + op_price.length + " 수량 자리수 = " + op_stock.length);
				
				if(op_title == null || op_title == "" || op_content == null || op_content == "" || op_price == null || op_price == ""){
					alert("미완성 리워드가 남아있습니다. 모든 칸을 기입해주세요.");
					$("#menu-tab2").click();
					$("#option"+i).click();
					return;
				}
				
				// 모든 리워드의 재고와 수량을 곱한 총액을 누적.
				if(op_stock != null && op_stock != ""){
					totalPrice += (Number(op_price)*Number(op_stock));
				}else{
					unLimited = true;
				}
			}
			console.log("총액 = " +  totalPrice);
			console.log("unLimited = " +  unLimited);
			
			if(unLimited == true || totalPrice >= goalfund){
				// 재고가 무제한으로 설정됐거나, 리워드 재고*수량이 목표금액을 넘었을 때(금액 달성에 적합한 리워드 조건을 입력함)
				formSubmit();	// form에 submit 실행~
			}else{
				alert("등록하신 리워드 재고와 수량은 목표금액보다 미달됩니다. 더 많은 재고를 등록하거나, 제품 가격을 높여주세요.");
				$("#optiontotalTap").click();
				return;
			}
				
				
		}
			
	}
			 
		  
});

function replaceTag(option_total) {
	$("#title").val($(this).val().replace(/</g,""));
	$("#summary").val($(this).val().replace(/</g,""));
	$("#tag").val($(this).val().replace(/</g,""));
	$(".op_title").val($(this).val().replace(/</g,""));
	$(".op_content").val($(this).val().replace(/</g,""));
}
	
// 등록버튼 눌렀을 때
function formSubmit() {
	// 모달창에서 확인/취소 누르는것으로 바꿈
	$("#messageModal").modal('show');
	//$("#createProjectFrom").submit();
}

//최종 서브밋은 여기서
function checkAndResubmitProject(){
	// 선택한 은행+계좌번호 가져와
	var bankname = $("#bankname").val();
	var accountNumber = $("#accountNumber").val();
	// hidden에 bank값 세팅(컨트롤러에서 projectDto중 bank로 받아줄 값)
	$("#bank").val(bankname + "/" + accountNumber);
	
	// 리워드 내용에 들어간 개행문자를 '/'으로 치환하기 & 
	// 리워드금액, 리워드 수량에 들어간콤마 전부 없애기 & 
	// 제목,요약,태그,옵션제목과내용에 사용자가 임의로 작성한 태그 '<'문자 없애기
	var fundtype = $("input[name='fundtype']:checked").val();	// reward / donation 라디오버튼 선택 값 가져오기
	var option_total = $("#option_total").val();
	$("#title").val($("#title").val().replace(/</g,""));
	$("#summary").val($("#summary").val().replace(/</g,""));
	$("#tag").val($("#tag").val().replace(/</g,""));
	if(fundtype == "reward"){
		for(var i=1; i<=option_total; i++){
			var content = $("#op_content" + i).val();
			var price = $("#op_price" + i).val();
			var stock = $("#op_stock" + i).val();
			var title = $("#op_title" + i).val();
			$("#op_content" + i).val(content.replace(/\n/gi, "/").replace(/</g,""));
			$("#op_price" + i).val(price.replace(/,/gi, ""));
			$("#op_stock" + i).val(stock.replace(/,/gi, ""));
			$("#op_title"+ i).val(title.replace(/</g,""));
		}
	}
	
	// 목표금액에 들어간 콤마 전부 없애기
	var _goalfund = $("#goalfund").val();
	$("#goalfund").val(_goalfund.replace(/,/gi, ""));
	
	// form 실행! 컨트롤러로~
	$("#createProjectFrom").submit();
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
// 목표금액, 리워드 금액, 리워드 수량 전부 --> 숫자만 입력가능 + 콤마생성
$("#goalfund, #op_price1, #op_price2, #op_price3, #op_price4, #op_price5, #op_price6, #op_price7, #op_price8, #op_price9, #op_price10,	#op_stock1, #op_stock2, #op_stock3, #op_stock4, #op_stock5, #op_stock6, #op_stock7, #op_stock8, #op_stock9, #op_stock10").on("keyup", function() {
	$(this).val(addCommas($(this).val().replace(/[^0-9]/g,"")));
});
//계좌번호 숫자만 입력가능
$("#accountNumber").on("keyup", function() {
    $(this).val($(this).val().replace(/[^0-9]/g,""));
})
//3자리 단위마다 콤마 생성하는 함수
function addCommas(x) {
    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}

// 선택한 프로젝트 스케줄 날짜를 다시 리셋함.
$("#btn_resetDates").click(function () {
	$("#date1").val("");
	$("#date2").val("");
	$("#date3").val("");
	$("#date4").val("");
})
// 기부 버튼을 클릭했을 때
$("#fundtype2").click(function () {
	// 리워드 탭 사라지게.(기부는 선물을 주지 않으니까...)
	$("#menu-tab2").hide();
	// 배송일 사라지게.(기부는 선물을 배달하지 않으니까...)
	$("#date4").hide();
})
// 상품 버튼을 클릭했을 때
$("#fundtype1").click(function () {
	// 리워드 탭 보이게.
	$("#menu-tab2").show();
	// 배송일 보이게
	$("#date4").show();
})

// fundtype(기부/리워드) 라디오버튼 클릭 시 category에 select option값도 각각맞게 세팅
$(":radio").click(function (e) {
	$("#category option").remove();
	if($(this).attr("id")== "fundtype1"){	// Food, Animal, IT
		$("#category").append("<option value='food'>음식</option>").append("<option value='animal'>동물</option>").append("<option value='it'>IT / 생활</option>");
	}
	if($(this).attr("id")== "fundtype2"){	// Human, Animal
		$("#category").append("<option value='human'>인권</option>").append("<option value='animal'>동물</option>");
	}
});


// 대표이미지 미리보기
$("#mainImage").on("change", function (e) {
	var files = e.target.files;
	var filesArr = Array.prototype.slice.call(files);
	filesArr.forEach(function (f) {
		if(!f.type.match("image.*")){
			alert("확장자는 이미지 확장자만 가능합니다.");
			return;
		}
		sel_file = f;
		
		var reader = new FileReader();
		reader.onload = function (e) {
			$("#imgPreview").attr("src", e.target.result);
			$("#imageChecked").css("opacity","1");
			imgOk=true;
			checkIntro();
		}
		reader.readAsDataURL(f);
	})
})


var titleOk = false;
var summaryOk = false;
var imgOk = false;

// 프로젝트 개요 체크
function checkIntro(){
	if(titleOk && summaryOk && imgOk){
		$("#introChecked").css("display","block");		
	}else{
		$("#introChecked").css("display","none");
	}
}

function checkTitle(){	
	var title = $("#title").val();
	if(title != "" && title.length <= 40){		
		$("#titleChecked").css("opacity","1");
		titleOk = true;
	}else{
		$("#titleChecked").css("opacity","0");
		titleOk = false;
	}
	checkIntro();	
};


function checkSummary(){	
	var summary = $("#summary").val();
	if( summary != "" && summary.length <= 100){
		$("#summaryChecked").css("opacity","1");
		summaryOk=true;
	}else{
		$("#summaryChecked").css("opacity","0");
		summaryOk=false;
	}
	checkIntro();
} 


var storyOk = false;
var tagOk = false;
var goalfundOk = false;
var accountOk = false;
var scheduleOk = false;

// 스토리텔링 체크
function checkStorytelling(){
	if(storyOk && tagOk && goalfundOk && accountOk && scheduleOk){
		$("#storytellingChecked").css("display","block");		
	}else{
		$("#storytellingChecked").css("display","none");
	}
}

function summernoteCheck(){	
	var summernote = $("#summernote").val();
	if(summernote.length>0){
		$("#summernoteChecked").css("opacity","1");
		storyOk = true;
	}else{
		$("#summernoteChecked").css("opacity","0");
		storyOk = false;
	}
	checkStorytelling();
}

function tagCheck(){	
	var tag = $("#tag").val();
	if(tag != "" && tag.length <= 400){
		$("#tagChecked").css("opacity","1");	
		tagOk = true;
	}else{
		$("#tagChecked").css("opacity","0");
		tagOk = false;
	}
	checkStorytelling();
}

function goalfundCheck(){	
	var _goalfund = $("#goalfund").val();
	var goalfund = _goalfund.replace(/,/gi, "");
	if(goalfund != "" && goalfund.length <= 10){
		$("#goalfundChecked").css("opacity","1");	
		goalfundOk = true;
	}else{
		$("#goalfundChecked").css("opacity","0");
		goalfundOk = false;
	}
	optionCheck();
	checkStorytelling();
}

function accountCheck(){	
	var bankname = $("#bankname").val();
	var accountNumber = $("#accountNumber").val();
	if(bankname != "" && bankname != "은행을 선택하세요" && accountNumber != "" && accountNumber.length <= 15){
		$("#accountChecked").css("opacity","1");
		accountOk = true;
	}else{
		$("#accountChecked").css("opacity","0");
		accountOk = false;
	}
	checkStorytelling();
}

function scheduleCheck(){
	var date1 = $("#date1").val();
	var date2 = $("#date2").val();
	var date3 = $("#date3").val();
	var date4 = $("#date4").val();
	if(date1 != "" && date2 != "" && date3 != ""){
		var fundtype = $("input[name='fundtype']:checked").val();
		if((fundtype == 'reward' && date4 != "") || fundtype == 'donation'){
			$("#scheduleChecked").css("opacity","1");	
			scheduleOk = true;
		}else {
			$("#scheduleChecked").css("opacity","0");
			scheduleOk = false;
		}		
	}else{
		$("#scheduleChecked").css("opacity","0");
		scheduleOk = false;
	}
	checkStorytelling();
}

function optionCheck(){	
	var optionSelected = $("#optionSelected").val();	// 상품-리워드 갯수 선택했을때 "OK" / 기부or상품-리워드 갯수 선택안했을 때 "NO"
	var option_total = $("#option_total").val();
	var goalfund = parseInt($("#goalfund").val().replace(/,/gi, ""));
	
	if(optionSelected == "OK"){	// 상품선택하고, 리워드 갯수 선택안함
		var totalPrice = 0;
	    var unlimited = false;
	    var optionCheckedCount = 0;

		for(var i=1; i<=option_total; i++){
			var op_title = $("#op_title" + i).val();
			var op_content = $("#op_content" + i).val();
			var op_price = $("#op_price" + i).val().replace(/,/gi, "");
			var op_stock = $("#op_stock" + i).val().replace(/,/gi, "");
					
			// 모든 리워드의 재고와 수량을 곱한 총액을 누적.
			if(op_stock != ""){
				totalPrice = totalPrice + (op_price*op_stock);
			}else{
				unlimited = true;
			}
			
			if(op_title != "" && op_content != "" && op_price != ""){
				$("#optionChecked"+i).css("opacity","1");	
				optionCheckedCount++;
			}else{
				$("#optionChecked"+i).css("opacity","0");	
			}
		}
		
		if((unlimited || parseInt(totalPrice) >= parseInt(goalfund)) && optionCheckedCount==option_total) {
			$("#optionAllChecked").css("opacity","1");
			$("#rewardChecked").css("display","block");
		}else{
			$("#optionAllChecked").css("opacity","0");
			$("#rewardChecked").css("display","none");
		}
	}		
}
</script>