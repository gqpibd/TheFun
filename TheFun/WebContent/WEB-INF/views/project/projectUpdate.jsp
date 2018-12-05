<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:requestEncoding value="utf-8"/>

<!-- 패널 접었다 폈다 할 수 있는 기능(https://www.w3schools.com/bootstrap/bootstrap_collapse.asp 참고) -->
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- 썸머노트(반응형 스마트 에디터) -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js"></script>
<link href="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.9/summernote-bs4.css" rel="stylesheet">
<script src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.9/summernote-bs4.js"></script>
<script src="./js/summernote-ko-KR.js"></script>

<style type="text/css">
h1, h4, tr, #home-tab, #menu-tab1, #menu-tab2, .notChangedOption, .changedOption{
	font-family: 'Jua', sans-serif;
}
#home-tab, #menu-tab1, #menu-tab2, .notChangedOption, .changedOption{
	font-size: 1em;
	color: black;
}
tr, td, input{
	font-size: 17px;
}
</style>

<script>
	
$(document).ready(function() {
	
		console.log("옵션 토탈 = ${myProject.optiontotal }");
		// 등록된 리워드 갯수까지만 row 보이기
		for (var i = 1; i <= 10; i++) {
			$("#_option" + (i+10)).hide();
		}
		for (var i = 1; i <= '${myProject.optiontotal }'; i++) {
			$("#_option" + (i+10)).show();
		}
		
		console.log("카테고리 = ${myProject.category }");
		// 기존 fundtype(라디오 버튼) / categoty(셀렉트 옵션) 값 설정
		$('input:radio[name=fundtype]:input[value=${myProject.fundtype}]').attr('checked', true);
		$("#category option").each(function(){
		    if($(this).val()=="${myProject.category}"){
		      $(this).prop("selected","selected"); // attr적용안될경우 prop으로 
		    }
		});
		
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
		
		// 계좌 기존값으로 설정
		var myAccount = '${myProject.bank}'.split('/');	// 카카오뱅크/110422942251
		var bank = myAccount[0];	// 카카오뱅크
		var account = myAccount[1];	// 110422942251
		$("#bankname").val(bank).prop("selected", true);
		$("#accountNumber").val(account);
		
		
		
		/* 프로젝트 스케줄 datepicker 생성 */
		// 시작일
		$("#date1").datepicker({
			minDate : 0,
			dateFormat:"yy-mm-dd",
			dayNamesMin:["일", "월", "화", "수", "목", "금", "토"],	// 배열을 잡은것.
			monthNames:["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"],
			onSelect:function( d ){
				// 연,월,일 구하기
				// alert(d + "선택됐습니다");
				var arr = d.split("-");
				$("#date1").text(arr[0]);
				$("#date1").append(arr[1]);
				$("#date1").append(arr[2]);
				
				// 요일 구하기
				var date = new Date( $("#date1").datepicker({dateFormat:'yy-mm-dd'}).val() );
				// alert("date1 : "+date.getDay() );	// 0(일요일)~6(토요일)
						
				var week = new Array("일", "월", "화", "수", "목", "금", "토");
				$("#date1").append( week[ date.getDay() ] );
			},
			onClose : function (selectedDate) {
				if( selectedDate != "" ) {
					// 펀딩 시작일은 내일날짜부터 선택가능하게
					var curDate = $("#date1").datepicker("getDate");  // Date return
					curDate.setDate( curDate.getDate() + 1 );
					// 펀딩 종료일은 선택된 시작일 담날부터 가능하게
					$("#date2").datepicker("option", "minDate", curDate);
					// 종료일 태그 활성화
					$("#date2").attr("disabled", false);
				}
			}
		});
		// 기존에 입력한 스케줄로 날짜 세팅
		/* var _sdate = "${myProject.sdate}";
		var sdate = _sdate.trim().substring(0,10);
		console.log("sdate == " + sdate);
		$("#date1").datepicker( "setDate" , sdate); */
		// 종료일
		$("#date2").datepicker({
			dateFormat:"yy-mm-dd",
			dayNamesMin:["일", "월", "화", "수", "목", "금", "토"],	// 배열을 잡은것.
			monthNames:["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"],
			onSelect:function( d ){
				// 연,월,일 구하기
//				alert(d + "선택됐습니다");
				var arr = d.split("-");
				$("#date2").text(arr[0]);
				$("#date2").append(arr[1]);
				$("#date2").append(arr[2]);
				
				// 요일 구하기
				var date = new Date( $("#date2").datepicker({dateFormat:'yy-mm-dd'}).val() );
//				alert("this : "+date.getDay() );	// 0(일요일)~6(토요일)
				
				var week = new Array("일", "월", "화", "수", "목", "금", "토");
				$("#date2").append( week[ date.getDay() ] );
			},
			onClose : function( selectedDate ) {  // 날짜를 설정 후 달력이 닫힐 때 실행
	            if( selectedDate != "" ) {
	                // xxx의 maxDate를 yyy의 날짜로 설정
	                $("#date1").datepicker("option", "maxDate", selectedDate);
	                
	             	// 정산일(결제일)은 종료일 담날부터 가능
					var curDate = $("#date2").datepicker("getDate");  // Date return
					curDate.setDate( curDate.getDate() + 1 );
					$("#date3").datepicker("option", "minDate", curDate);
					// 정산일 태그 활성화
					$("#date3").attr("disabled", false);
	            }
	        }
		});
		// 정산일
		$("#date3").datepicker({
			dateFormat:"yy-mm-dd",
			dayNamesMin:["일", "월", "화", "수", "목", "금", "토"],	// 배열을 잡은것.
			monthNames:["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"],
			onSelect:function( d ){
				// 연,월,일 구하기
//				alert(d + "선택됐습니다");
				var arr = d.split("-");
				$("#date3").text(arr[0]);
				$("#date3").append(arr[1]);
				$("#date3").append(arr[2]);
				
				// 요일 구하기
				var date = new Date( $("#date3").datepicker({dateFormat:'yy-mm-dd'}).val() );
//				alert("this : "+date.getDay() );	// 0(일요일)~6(토요일)
				
				var week = new Array("일", "월", "화", "수", "목", "금", "토");
				$("#date3").append( week[ date.getDay() ] );
			},
			onClose : function( selectedDate ) {  // 날짜를 설정 후 달력이 닫힐 때 실행
	            if( selectedDate != "" ) {
	                // xxx의 maxDate를 yyy의 날짜로 설정
	                $("#date2").datepicker("option", "maxDate", selectedDate);
	                
	             	// 정산일(결제일)은 펀딩 종료일 다음날부터 가능하게
					var curDate = $("#date3").datepicker("getDate");  // Date return
					curDate.setDate( curDate.getDate() + 1 );
					$("#date4").datepicker("option", "minDate", curDate);
					// 배송일 태그 활성화
					$("#date4").attr("disabled", false);
	            }
	        }
		});
		// 배송일
		$("#date4").datepicker({
			dateFormat:"yy-mm-dd",
			dayNamesMin:["일", "월", "화", "수", "목", "금", "토"],	// 배열을 잡은것.
			monthNames:["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"],
			onSelect:function( d ){
				// 연,월,일 구하기
//				alert(d + "선택됐습니다");
				var arr = d.split("-");
				$("#date4").text(arr[0]);
				$("#date4").append(arr[1]);
				$("#date4").append(arr[2]);
				
				// 요일 구하기
				var date = new Date( $("#date4").datepicker({dateFormat:'yy-mm-dd'}).val() );
//				alert("this : "+date.getDay() );	// 0(일요일)~6(토요일)
				
				var week = new Array("일", "월", "화", "수", "목", "금", "토");
				$("#date4").append( week[ date.getDay() ] );
			},
			onClose : function( selectedDate ) {  // 날짜를 설정 후 달력이 닫힐 때 실행
	            if( selectedDate != "" ) {
	                // xxx의 maxDate를 yyy의 날짜로 설정
	                $("#date3").datepicker("option", "maxDate", selectedDate);
	                
	            }
	        }
		});
		
		
		
});
</script>





<!-- 프로젝트 생성에 필요한 입력값을 컨트롤러에 전송하기 위한 큰 form -->
<form id="updateProjectFrom" method="post" action="projectUpdateAf.do" enctype="multipart/form-data">
	<input type="hidden" id="bank" name="bank">
	<input type="hidden" id="status" name="status" value="${myProject.status}">
	<input type="hidden" name="seq" value="${myProject.seq }">
	<input type="hidden" id="originImage" name="originImage" value="${myProject.seq }.jpg">	<!-- 기존이미지이름 별로 필요없을듯. 어차피 파일 덮어쓰기 할거라... seq.jpg로 -->

<!-- 콘텐츠를 전부 중간맞춤하기 위한 가장 외부의 div -->
<div style="width: 70%; margin: 0 auto;">

<!-- 상단 탭 모음 -->
<ul class="nav nav-tabs">  
  <%-- <li class="active"> --%>
  <li class="nav-item">
  	<a class= "nav-link active" href="#home" id="home-tab" data-toggle="tab" style="font-size: 2em" role="tab" aria-controls="home" aria-selected="true">프로젝트 개요</a>
  </li>  
  <li class="nav-item">
  	<a class= "nav-link" href="#menu1" id="menu-tab1"  data-toggle="tab" style="font-size: 2em" role="tab" aria-controls="menu1" aria-selected="false">스토리텔링</a>
  </li>
  <li class="nav-item">
  	<a class= "nav-link" href="#menu2" id="menu-tab2"  data-toggle="tab" style="font-size: 2em" role="tab" aria-controls="menu2" aria-selected="false">리워드 등록</a>
  </li>
</ul>

<!-- 탭 하단에 나오는 내용 div -->
<div class="tab-content">


<!-- (1) 첫번째 탭 눌렀을 때 -->
<div id="home" class="tab-pane fade show active" role="tabpanel" aria-labelledby="home-tab">
<br>

<!-- 큰 테두리 -->
<div class="container">
  <h1>프로젝트 개요</h1>
  <!-- card 샘플 시작 : 탭 하나 누르면 다른 탭은 자동으로 닫히는 기능 여기서 시작. accordion의 id값을 각 탭의 data-parent로 넣어주면 된다. -->
  <div class="accordion" id="accordionExample">
  	<!-- [1] 프로젝트 제목 -->
	<div class="card border-secondary mb-1"   style="border: 1px solid rgba(0,0,0,.125);"> <!-- 아래 항목 사이의 여백 없애려면 mb-3 삭제 -->
    <!-- 위 -->
      <div class="card-header" id="headionOne">
        <h4 class="mb-0">    				
	       <label style="cursor:pointer" data-toggle="collapse" data-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne" id="titleTap">프로젝트 제목</label>		
        </h4>
      </div>
    <!-- 아래 -->
      <div id="collapseOne" class="collapse show" aria-labelledby="headingOne" data-parent="#accordionExample">
        <div class="card-body">
        	<table class="card-text" style="width: 100%">
				<tr>
					<td>
						<input type="text" class="form-control" placeholder="제목을 입력해 주세요" value="${myProject.title }" id="title" name="title" size="100%" onkeyup="checkLength(this,'#titleLen',30)">
					</td>
				</tr>
				<tr>
					<td>
						<span style="color: #4B088A; margin-left: 2%;">
							<span id="titleLen">30자 남았습니다.</span>
						</span>
						
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
							<div style="color: #4B088A; margin-left: 2%;">
								<ul>
						          <li>사이즈: 가로1200px  세로675px </li>
						          <li>용량 : 3MB 미만</li>
						          <li>텍스트 및 로고 삽입 금지 </li>
						        </ul>
							</div>
							<input type="file" id="mainImage" name="fileload" style=" margin-left: 6%;"
									accept="image/jpg, image/gif, image/png, image/jpeg, image/bmp">
						</td>
						<td>
							<img alt="#none" src="D:\springWithJava\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\TheFun\upload\${myProject.seq }.jpg" id="imgPreview" class="card-img-top" width="20px">
							<!-- 또 로컬경로에 있는 이미지를 불러오지 못한다는 오류가 뜬다... Not allowed to load local resource -->
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
					<td>
						<div class="form-group">
						  <label for="comment">Comment:</label>
						  <textarea class="form-control" rows="5" id="summary" name="summary" onkeyup="checkLength(this,'#commentLength',100)">${myProject.summary }</textarea>
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
    <div class="card border-secondary mb-1">
    	<!-- 위 -->
		<div class="card-header" id="headingFour">        
		  <h4 class="mb-0">
		  	<label class="collapsed" style="cursor:pointer" data-toggle="collapse" data-target="#collapseFour" aria-expanded="false" aria-controls="collapseFour" id="categoryTap">프로젝트 카테고리</label>          
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
								(프로젝트 성격과 맞지 않는 카테고리를 선택하실 시 후원자가 해당 프로젝트를 찾기 어려워지기에 에디터에 의해 조정권고를 받을 수 있습니다.)
						</div>
					</td>
				</tr>
				<tr style="margin-top: 10%">
					<td>
						<label for="fundtype1" class="btn btn-primary btn-block" style="font-size: 1em">
						  <input type="radio" name="fundtype" id="fundtype1" autocomplete="off" value="reward" checked> Reward (상품)
						</label>
						<label for="fundtype2" class="btn btn-primary btn-block" style="font-size: 1em">
						  <input type="radio" name="fundtype" id="fundtype2" autocomplete="off" value="donation"> Donation (기부)
						</label>
					</td>
				</tr>
				<tr>
					<td>
						<div class="form-group">
						  <span for="sel1">Project Category(택 1):</span>
						  <select class="form-control" id="category" name="category" style="font-size: 1em; height: 10%">
						  <c:choose>
					    	<c:when test="${myProject.fundtype eq 'reward' }">
					    		<option value="Food">Food</option>
							    <option value="Animal">Animal</option>
							    <option value="IT">IT</option>
					    	</c:when>
					    	<c:when test="${myProject.fundtype eq 'donation' }">
							    <option value="Animal">Animal</option>
							    <option value="Human">Human</option>
					    	</c:when>
						  </c:choose>
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
<br>

<!-- 큰 테두리 -->
<div class="container">
  <h1>스토리텔링</h1>
  <!-- card 샘플 시작 -->
  <div class="accordion" id="accordion1">
  	<!-- [5] 프로젝트 스토리(content) -->
	<div class="card border-secondary mb-1"   style="border: 1px solid rgba(0,0,0,.125);">
    <!-- 위 -->
      <div class="card-header" id="headionFive">
        <h4 class="mb-0">    				
	       <label style="cursor:pointer" data-toggle="collapse" data-target="#collapseFive" aria-expanded="true" aria-controls="collapseFive" id="summernoteTap">프로젝트 스토리</label>		
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
						<textarea id="summernote" name="content">${myProject.content }</textarea>
					</td>
				</tr>
			</table>
        </div>
      </div>
    </div>    
    <!-- [6] 태그 -->
    <div class="card border-secondary mb-1">
    	<!-- 위 -->
		<div class="card-header" id="headingSix">        
		  <h4 class="mb-0">
		  	<label class="collapsed" style="cursor:pointer" data-toggle="collapse" data-target="#collapseSix" aria-expanded="false" aria-controls="collapseSix" id="tagTap">검색용 태그</label>          
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
					<input type="text" class="form-control" placeholder="태그는 #으로 구분해주세요. 띄어쓰기 시 자동으로 #이 입력됩니다." 
						value="<c:forEach items="${myProject.tags }" var="tags" varStatus="status">#${tags }</c:forEach>" 
						id="tag" name="tag" size="100%">
					</td>
				</tr>
			</table>
        </div>
      </div>
    </div>
    <!-- [7] 목표 금액 설정 -->
    <div class="card border-secondary mb-1">
    	<!-- 위 -->
		<div class="card-header" id="headingSeven">        
		  <h4 class="mb-0">
		  	<label class="collapsed" style="cursor:pointer" data-toggle="collapse" data-target="#collapseSeven" aria-expanded="false" aria-controls="collapseSeven" id="goalfundTap">목표 금액 설정</label>          
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
						<input type="text" class="form-control" placeholder="0" 
							value="${myProject.goalfund }" id="goalfund" name="goalfund" size="70%">
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
    <div class="card border-secondary mb-1">
    	<!-- 위 -->
		<div class="card-header" id="headingEight">        
		  <h4 class="mb-0">
		  	<label class="collapsed" style="cursor:pointer" data-toggle="collapse" data-target="#collapseEight" aria-expanded="false" aria-controls="collapseEight" id="bankTap">계좌 등록</label>          
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
    <!-- [9] 프로젝트 진행 스케줄 -->
    <div class="card border-secondary mb-1">
    	<!-- 위 -->
		<div class="card-header" id="headingNine">        
		  <h4 class="mb-0">
		  	<label class="collapsed" style="cursor:pointer" data-toggle="collapse" data-target="#collapseNine" aria-expanded="false" aria-controls="collapseNine" id="dateTap">프로젝트 진행 스케줄</label>          
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
						<fmt:parseDate value="${myProject.sdate }" pattern="yyyy-MM-dd HH:mm:ss" var="sdate" />
						<input type="text" class="date" id="date1" name="sdate" 
							value="<fmt:formatDate value="${sdate}" pattern="yyyy-MM-dd"/>" 
							placeholder="오늘부터 선택 가능합니다" size="30%" autocomplete="off">
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
						<fmt:parseDate value="${myProject.edate }" pattern="yyyy-MM-dd HH:mm:ss" var="edate" />
						<input type="text" class="date" id="date2" name="edate" placeholder="시작일의 다음날부터 선택 가능합니다" 
							value="<fmt:formatDate value="${edate}" pattern="yyyy-MM-dd"/>" 
							size="30%" autocomplete="off" disabled="disabled">
					</td>
				</tr>
				<tr>
					<td>
						<div class="form-group">
						  <label for="sel1">프로젝트 정산일·결제일</label>
						</div>
					</td>
					<td>
						<fmt:parseDate value="${myProject.pdate }" pattern="yyyy-MM-dd HH:mm:ss" var="pdate" />
						<input type="text" class="date" id="date3" name="pdate" placeholder="종료일의 다음날부터 선택 가능합니다"
							value="<fmt:formatDate value="${pdate}" pattern="yyyy-MM-dd"/>" 
							size="30%" autocomplete="off" disabled="disabled">
					</td>
				</tr>
				<tr>
					<td>
						<div class="form-group">
						  <label for="sel1">프로젝트 배송일</label>
						</div>
					</td>
					<td>
						<fmt:parseDate value="${myProject.shipdate }" pattern="yyyy-MM-dd HH:mm:ss" var="shipdate" />
						<input type="text" class="date" id="date4" name="shipdate" placeholder="정산일의 다음날부터 선택 가능합니다"
							value="<fmt:formatDate value="${shipdate}" pattern="yyyy-MM-dd"/>" 
							size="30%" autocomplete="off" disabled="disabled">
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
<br>

<!-- 큰 테두리 -->
<div class="container">
  <h1>리워드 등록</h1>
  <!-- card 샘플 시작 -->
  <div class="accordion" id="accordion2">
  	<!-- [10] 옵션 개수 선택 -->
	<div class="card border-secondary mb-1" style="border: 1px solid rgba(0,0,0,.125);">
    <!-- 위 -->
      <div class="card-header" id="headionTen">
        <h4 class="mb-0">    				
	       <label style="cursor:pointer" data-toggle="collapse" data-target="#collapseTen" aria-expanded="true" aria-controls="collapseTen" id="optiontotalTap">
	       	<a data-toggle="collapse" data-parent="#accordion2" href="#collapseTen">옵션 개수 선택</a>
	       </label>		
        </h4>
      </div>
    <!-- 아래 -->
      <div id="collapseTen" class="collapse show" aria-labelledby="headingTen" data-parent="#accordion2">
        <div class="card-body">
        	<table style="width: 100%">
					<tr>
						<td>
							<div class="desc projectimg">
								후원자 분들에게 어떤 선물을 드릴까요?
							</div>
						</td>
						<td>
							<div class="form-group">
							  <label for="sel1">옵션 총 개수</label>
							  <select class="form-control" id="option_total" name="option_total" onchange="optionChange(this)" style="font-size: 1em; height: 10%">
							  	<!-- 순서대로 for문, if문, else문 -->
							    <c:forEach var="x" begin="1" end="10" step="1">
								    <option value="${x }" ${x == myProject.optiontotal? 'selected="selected"':""}>${x}</option>
								</c:forEach>
							  </select>
							</div>
						</td>
					</tr>
				</table>
        </div>
      </div>
    </div>    
    <!-- [11] 리워드 등록 -->
   	<c:forEach items="${optionList }" var="myOption" varStatus="i">
   		<div id="_option${i.count+10 }">
   
		    <div class="card border-secondary mb-1" style="border: 1px solid rgba(0,0,0,.125);">
				    <div class="panel panel-default">
					    <div class="card-header" id="headion${i.count }">
					        <h5 class="mb-0">
					          	<a data-toggle="collapse" data-parent="#accordion" href="#collapse${i.count+10 }" 
					          		id="option${i.count }" class="changedOption">${i.count }번째 선물</a>
					      	</h5>
					    </div>
				    <div id="collapse${i.count+10 }" class="panel-collapse collapse" aria-labelledby="heading${i.count }" data-parent="#accordion2">
		       			<div class="card-body">
				        	<table style="width: 100%">
								<tr>
									<td colspan="2">
										<div class="desc projectimg">
											후원자 분들에게 드릴 선물 내용을 입력해주세요
										</div>
									</td>
								</tr>
								<tr>
									<td colspan="2">
										<div class="form-group">
										  <label for="sel1">옵션 제목</label>
										  <input type="text" class="form-control" id="op_title${i.count }" 
										  	name="op_title" value="${myOption.title }" 
										  	placeholder="[얼리버드] 등 대표 제목을 작성해주세요" 
										  	style="font-size: 15px" size="100%">
										</div>
									</td>
								</tr>
								<tr>
									<td colspan="2">
										<div class="form-group">
										  <label for="sel1">아이템</label>
										  <textarea class="form-control" rows="5" id="op_content${i.count }" 
										  	name="op_content" style="font-size: 15px" 
										  	placeholder="아이템은 선물에 포함되는 구성 품목을 말합니다. 각 품목은 줄바꿈으로 구분해주세요.">${myOption.content }</textarea>
										</div>
									</td>
								</tr>
								<tr>
									<td>
										<div class="form-group">
										  <label for="sel1">후원 금액</label>
										  <input type="text" class="form-control" id="op_price${i.count }" 
										  	name="op_price" value="${myOption.price }"
										  	placeholder="해당 옵션의 적정가를 책정해주세요" 
										  	style="font-size: 15px" size="50%" maxlength="8">
										</div>
									</td>
									<td>
										<div class="form-group">
										  <label for="sel1">보유 수량</label>
										  <c:choose>
										  	<c:when test="${myOption.stock ne 0}">
											  <input type="text" class="form-control" id="op_stock${i.count }" 
											  	name="op_stock" value="${myOption.stock}" 
											  	placeholder="재고 제한이 없는 경우 공란으로 비워두세요" 
											  	style="font-size: 15px" size="50%" maxlength="8">
										  	</c:when>
										  	<c:otherwise>
										  		<input type="text" class="form-control" id="op_stock${i.count }" 
											  	name="op_stock"
											  	placeholder="재고 제한이 없는 경우 공란으로 비워두세요" 
											  	style="font-size: 15px" size="50%" maxlength="8">
										  	</c:otherwise>
										  </c:choose>
										</div>
									</td>
								</tr>
							</table>
				        </div>
				      </div>
			    </div>
		    </div>		    
		</div>
	</c:forEach>
	<c:forEach var="x" begin="${fn:length(optionList)+1 }" end="10" step="1">
   		<div id="_option${x+10 }">
   
		    <div class="card border-secondary mb-1" style="border: 1px solid rgba(0,0,0,.125);">
				    <div class="panel panel-default">
					    <div class="card-header" id="headion${x }">
					        <h5 class="mb-0">
					          	<a data-toggle="collapse" data-parent="#accordion" href="#collapse${x+10 }" 
					          		id="option${x }" class="changedOption">${x }번째 선물</a>
					      	</h5>
					    </div>
				    <div id="collapse${x+10 }" class="panel-collapse collapse" aria-labelledby="heading${x }" data-parent="#accordion2">
		       			<div class="card-body">
				        	<table style="width: 100%">
								<tr>
									<td colspan="2">
										<div class="desc projectimg">
											후원자 분들에게 드릴 선물 내용을 입력해주세요
										</div>
									</td>
								</tr>
								<tr>
									<td colspan="2">
										<div class="form-group">
										  <label for="sel1">옵션 제목</label>
										  <input type="text" class="form-control" id="op_title${x }" 
										  	name="op_title" placeholder="[얼리버드] 등 대표 제목을 작성해주세요" 
										  	style="font-size: 15px" size="100%">
										</div>
									</td>
								</tr>
								<tr>
									<td colspan="2">
										<div class="form-group">
										  <label for="sel1">아이템</label>
										  <textarea class="form-control" rows="5" id="op_content${x }" 
										  	name="op_content" style="font-size: 15px" 
										  	placeholder="아이템은 선물에 포함되는 구성 품목을 말합니다. 각 품목은 줄바꿈으로 구분해주세요."></textarea>
										</div>
									</td>
								</tr>
								<tr>
									<td>
										<div class="form-group">
										  <label for="sel1">후원 금액</label>
										  <input type="text" class="form-control" id="op_price${x }" 
										  	name="op_price" placeholder="해당 옵션의 적정가를 책정해주세요" 
										  	style="font-size: 15px" size="50%" maxlength="8">
										</div>
									</td>
									<td>
										<div class="form-group">
										  <label for="sel1">보유 수량</label>
										  		<input type="text" class="form-control" id="op_stock${x }" 
											  	name="op_stock"
											  	placeholder="재고 제한이 없는 경우 공란으로 비워두세요" 
											  	style="font-size: 15px" size="50%" maxlength="8">
										</div>
									</td>
								</tr>
							</table>
				        </div>
				      </div>
			    </div>
		    </div>
		    
		    
		    </div>
	</c:forEach>
	
</div>

</div>
<!-- 3번째 탭 내용 끝 -->


</div>
<!-- 전송버튼 -->
	<input type="button" class="btn btn-lg btn-primary" id="btn_submit"
		style="font-family: 'Noto Sans KR', sans-serif; margin-left: 1.5%;" value="수정하기">	

</div>
</div>



</form>
<!-- 전체 폼 끝 -->

<script>
// 옵션갯수 다시 선택하면  
function optionChange( me ) {
	var num = me.options[me.selectedIndex].value;
	alert(num + "개");
	
	for(i=1; i <= 10; i++){		// 초기화(일단 다 숨기고)
		$("#_option" + (i+10)).val("");
		$("#_option" + (i+10)).hide();
	}
	for(i=1; i <= num; i++){	// 갯수만큼만 다시 보여짐
		$("#_option" + (i+10)).show();
		$("#col_content").click();
	}		
	//console.log("옵션개수 = " + $("#option_total").val());
}
// 취소 버튼 눌렀을 때
$("#btn_calcel").click(function () {
	location.href="mySchedule.do?id=${login.id}";
});
//수정하기 버튼 눌렀을 때
$("#btn_submit").click(function () {
	alert("업뎃!");
	
	/* 공란 거르기 */
	
	// [1] 첫번째 탭 값
	var title = $("#title").val();
	var mainImage = $("#mainImage").val();
	var summary = $("#summary").val();
	var fundtype = $("input[name='fundtype']:checked").val();
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
	// *기부는 아래 값들 불필요(공란허용)
	var date4 = $("#date4").val();
	var optotal = $("#option_total").val();
	
	alert("title = " + title + " mainImage = " + mainImage + " fundtype = "+ fundtype + " summary = " + summary + " summernote = " + summernote +
			" tag = " + tag + " goalfund = " + goalfund + " bankname = " + bankname + " accountNumber = " + accountNumber +
			" date1 = " + date1 + " date2 = " + date2 + " date3 = " + date3 + " date4 = " + date4 + " option_total = " + optotal);
	
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
		
		// 2. 카테고리에 따른 공란판정
		if(fundtype == "donation") {	// 기부 선택했을 경우(==> 리워드 등록 불필요)
			console.log("기부를 선택하셨습니다");
			formSubmit(bankname, accountNumber);	// form에 submit 실행~
			return;
		} else if(fundtype == "reward"){
			// 적정 목표액 판정용
			var totalPrice = 0;
			
			for(var i=1; i<=optotal; i++){
				var op_title = $("#op_title" + i).val();
				var op_content = $("#op_content" + i).val();
				var _op_price = $("#op_price" + i).val();
				var op_price = _op_price.replace(/,/gi, "");
				var _op_stock = $("#op_stock" + i).val();
				var op_stock = _op_stock.replace(/,/gi, "");
				console.log(i + "번째 [리워드]~ 제목 = " + op_title + " 내용 = " + op_content + " 가격 = " + op_price + " 재고 = " + op_stock
						+ " 가격 자리수 = " + op_price.length + " 재고 자리수 = " + op_stock.length);
				
				// 모든 리워드의 재고와 수량을 곱한 총액을 누적.
				if(op_stock != null || op_stock != ""){
					totalPrice = totalPrice + (op_price*op_stock);
				}
				
				if(op_title == null || op_title == "" || op_content == null || op_content == "" || op_price == null || op_price == ""){
					alert("미완성 리워드가 남아있습니다. 모든 칸을 기입해주세요.");
					$("#menu-tab2").click();
					$("#option"+i).click();
					return;
				}
			}
			console.log("총액 = " +  totalPrice);
			
			if(op_stock == null || op_stock == "" || totalPrice >= goalfund){
				// 재고가 무제한으로 설정됐거나, 리워드 재고*수량이 목표금액을 넘었을 때(금액 달성에 적합한 리워드 조건을 입력함)
				formSubmit(bankname, accountNumber);	// form에 submit 실행~
			} else{
				alert("등록하신 리워드 재고와 수량은 목표금액보다 미달됩니다. 더 많은 재고를 등록하거나, 제품 가격을 높여주세요.");
				$("#optiontotalTap").click();
				return;
			}
		}
		  
	}
	
});
// form에 submit 최종실행 함수!
function formSubmit(bankname, accountNumber) {
	// 선택한 은행+계좌번호 가져와
	alert(bankname + accountNumber);
	// hidden에 bank값 세팅
	$("#bank").val(bankname + "/" + accountNumber);
	
	// 리워드 내용에 들어간 개행문자를 '/'으로 치환하기 & 리워드금액, 리워드 수량에 들어간콤마 전부 없애기
	var fundtype = $("input[name='fundtype']:checked").val();	// reward / donation 라디오버튼 선택 값 가져오기
	if(fundtype == "reward"){
		var optotal = $("#option_total").val();
		for(var i=1; i<=optotal; i++){
			var content = $("#op_content" + i).val();
			var price = $("#op_price" + i).val();
			var stock = $("#op_stock" + i).val();
			$("#op_content" + i).val(content.replace(/\n/gi, "/"));
			$("#op_price" + i).val(price.replace(/,/gi, ""));
			$("#op_stock" + i).val(stock.replace(/,/gi, ""));
		}
	}
	
	// 목표금액에 들어간 콤마 전부 없애기
	var _goalfund = $("#goalfund").val();
	$("#goalfund").val(_goalfund.replace(/,/gi, ""));
	
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
//목표금액, 리워드 금액, 리워드 수량 전부 --> 숫자만 입력가능 + 콤마생성
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
var options = $("#category option");
$(":radio").click(function (e) {
	$("#category option").remove();
	if($(this).attr("id")== "fundtype1"){	// Food, Animal, IT
		$("#category").append(options[0]).append(options[1]).append(options[2]);
	}
	if($(this).attr("id")== "fundtype2"){	// Human, Animal
		$("#category").append(options[1]).append(options[3]);
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
		}
		reader.readAsDataURL(f);
	})
})
</script>
 