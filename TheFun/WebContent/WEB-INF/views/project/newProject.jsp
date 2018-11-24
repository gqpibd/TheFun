<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%-- <%@taglib  prefix="form" uri="http://www.springframework.org/tags/form" %> --%>
<fmt:requestEncoding value="UTF-8"/>

<!-- 패널 접었다 폈다 할 수 있는 기능(https://www.w3schools.com/bootstrap/bootstrap_collapse.asp 참고) -->
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- 썸머노트(반응형 스마트 에디터) -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/css/bootstrap.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/js/bootstrap.min.js"></script>
<link href="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.9/summernote-bs4.css" rel="stylesheet">
<script src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.9/summernote-bs4.js"></script>

<style type="text/css">
/* h2{ 아래와 같은 폰트를 전부 사용할 수 있다.*/ 
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
		  
		  
		  /* 리워드 각 탭 아래 나오는거 일단 비활성화 */
		  $(".changedOption").hide();
		  
		  
		  /* datepicker 설정 */
		  // 일단 시작일 빼고 전부 비활성화
		  $("#date2").attr("disabled", true);
		  $("#date3").attr("disabled", true);
		  $("#date4").attr("disabled", true);
		  
			// 시작일
			$("#date1").datepicker({
				minDate : 0,
				dateFormat:"yy-mm-dd",
				dayNamesMin:["일", "월", "화", "수", "목", "금", "토"],	// 배열을 잡은것.
				monthNames:["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"],
				onSelect:function( d ){
					// 연,월,일 구하기
//					alert(d + "선택됐습니다");
					var arr = d.split("-");
					$("#date1").text(arr[0]);
					$("#date1").append(arr[1]);
					$("#date1").append(arr[2]);
							
					// 요일 구하기
					var date = new Date( $("#date1").datepicker({dateFormat:'yy-mm-dd'}).val() );
			//		alert("date1 : "+date.getDay() );	// 0(일요일)~6(토요일)
							
					var week = new Array("일", "월", "화", "수", "목", "금", "토");
					$("#date1").append( week[ date.getDay() ] );
				},
				onClose : function (selectedDate) {
					if( selectedDate != "" ) {
						// 체크아웃(퇴실일)을 체크인(입실일)의 다음날부터 가능하게
						var curDate = $("#date1").datepicker("getDate");  // Date return
						curDate.setDate( curDate.getDate() + 1 );
						$("#date2").datepicker("option", "minDate", curDate);
						// 체크아웃 태그 활성화
						$("#date2").attr("disabled", false);
					}
				}
			});
			// 종료일
			$("#date2").datepicker({
				dateFormat:"yy-mm-dd",
				dayNamesMin:["일", "월", "화", "수", "목", "금", "토"],	// 배열을 잡은것.
				monthNames:["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"],
				onSelect:function( d ){
					// 연,월,일 구하기
//					alert(d + "선택됐습니다");
					var arr = d.split("-");
					$("#date2").text(arr[0]);
					$("#date2").append(arr[1]);
					$("#date2").append(arr[2]);
					
					// 요일 구하기
					var date = new Date( $("#date2").datepicker({dateFormat:'yy-mm-dd'}).val() );
//					alert("this : "+date.getDay() );	// 0(일요일)~6(토요일)
					
					var week = new Array("일", "월", "화", "수", "목", "금", "토");
					$("#date2").append( week[ date.getDay() ] );
				},
				onClose : function( selectedDate ) {  // 날짜를 설정 후 달력이 닫힐 때 실행
		            if( selectedDate != "" ) {
		                // xxx의 maxDate를 yyy의 날짜로 설정
		                $("#date1").datepicker("option", "maxDate", selectedDate);
		                
		             	// 체크아웃(퇴실일)을 체크인(입실일)의 다음날부터 가능하게
						var curDate = $("#date2").datepicker("getDate");  // Date return
						curDate.setDate( curDate.getDate() + 1 );
						$("#date3").datepicker("option", "minDate", curDate);
						// 체크아웃 태그 활성화
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
//					alert(d + "선택됐습니다");
					var arr = d.split("-");
					$("#date3").text(arr[0]);
					$("#date3").append(arr[1]);
					$("#date3").append(arr[2]);
					
					// 요일 구하기
					var date = new Date( $("#date3").datepicker({dateFormat:'yy-mm-dd'}).val() );
//					alert("this : "+date.getDay() );	// 0(일요일)~6(토요일)
					
					var week = new Array("일", "월", "화", "수", "목", "금", "토");
					$("#date3").append( week[ date.getDay() ] );
				},
				onClose : function( selectedDate ) {  // 날짜를 설정 후 달력이 닫힐 때 실행
		            if( selectedDate != "" ) {
		                // xxx의 maxDate를 yyy의 날짜로 설정
		                $("#date2").datepicker("option", "maxDate", selectedDate);
		                
		             	// 체크아웃(퇴실일)을 체크인(입실일)의 다음날부터 가능하게
						var curDate = $("#date3").datepicker("getDate");  // Date return
						curDate.setDate( curDate.getDate() + 1 );
						$("#date4").datepicker("option", "minDate", curDate);
						// 체크아웃 태그 활성화
						$("#date4").attr("disabled", false);
		            }
		        }

			});
			// 정산일
			$("#date4").datepicker({
				dateFormat:"yy-mm-dd",
				dayNamesMin:["일", "월", "화", "수", "목", "금", "토"],	// 배열을 잡은것.
				monthNames:["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"],
				onSelect:function( d ){
					// 연,월,일 구하기
//					alert(d + "선택됐습니다");
					var arr = d.split("-");
					$("#date4").text(arr[0]);
					$("#date4").append(arr[1]);
					$("#date4").append(arr[2]);
					
					// 요일 구하기
					var date = new Date( $("#date4").datepicker({dateFormat:'yy-mm-dd'}).val() );
//					alert("this : "+date.getDay() );	// 0(일요일)~6(토요일)
					
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
	$('#summernote').summernote({
	  placeholder: 'Hello bootstrap 4',
	  tabsize: 2,
	  height: 600,                 // set editor height
	  minHeight: null,             // set minimum height of editor
	  maxHeight: null,             // set maximum height of editor
	  focus: true     
	});
	
	
	/* 리워드옵션의 갯수를 선택한만큼 갱신하는 함수 */ 
	function optionChange( me ) {
		
		$(".notChangedOption").hide();
		$(".changedOption").show();
		
		var num = me.options[me.selectedIndex].value;
		alert(num + "개");
		
		for(i=1; i <= 10; i++){		// 초기화(일단 다 숨기고)
			$("#_option" + (i+10)).val("");
			$("#_option" + (i+10)).hide();
		}
		for(i=1; i <= num; i++){	// 갯수만큼만 다시 보여짐
			$("#_option" + (i+10)).show();
		}		
	}
</script>

<!-- 프로젝트 생성에 필요한 입력값을 컨트롤러에 전송하기 위한 큰 form -->
<form id="createProjectFrom" method="post" action="newProjectAf.do" enctype="multipart/form-data">
	<input type="hidden" id="bank" name="bank">
	<input type="hidden" id="id" name="id" value="${login.id}">

<!-- 콘텐츠를 전부 중간맞춤하기 위한 가장 외부의 div -->
<div style="width: 70%; margin: 0 auto;">



<!-- 상단 탭 모음 -->
<ul class="nav nav-tabs">
  <li class="active"><a data-toggle="tab" href="#home" style="font-size: 2em">프로젝트 개요</a></li>
  <li><a data-toggle="tab" href="#menu1" style="font-size: 2em">스토리텔링</a></li>
  <li><a data-toggle="tab" href="#menu2" style="font-size: 2em">리워드 등록</a></li>
</ul>

<!-- 탭 하단에 나오는 내용 div -->
<div class="tab-content">

<!-- (1) 첫번째 탭 눌렀을 때 -->
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
						<input type="text" class="form-control" placeholder="제목을 입력해 주세요" id="title" name="title" size="100%" onkeyup="checkLength(this,'#titleLength',30)">
					</td>
				</tr>
				<tr>
					<td>
						<span style="color: #4B088A; margin-left: 2%;">
							<span id="titleLength">30자 남았습니다.</span>
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
	        	<table style="width: 100%">
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
						          <li>텍스트 및 로고 삽입 금지 </li>
						        </ul>
							</span>
						</td>
						<td align="right" style="text-align: left">
							<input type="file" name="fileload" style=" width : 400px;">
							<!-- 이미지는 type이 file! -->
							<!-- DB에는 프로젝트 테이블의 seq 값으로 파일이름 설정해줄것. -->
						</td>
					</tr>
				</table>
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
						  <textarea class="form-control" rows="5" id="summary" name="summary" onkeyup="checkLength(this,'#commentLength',100)"></textarea>
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
						<label class="btn btn-primary btn-block" style="font-size: 1em">
						  <input type="radio" name="fundtype" id="fundtype1" autocomplete="off" value="reward" checked> Reward (상품)
						</label>
						<label class="btn btn-primary btn-block" style="font-size: 1em">
						  <input type="radio" name="fundtype" id="fundtype2" autocomplete="off" value="donation"> Donation (기부)
						</label>
					</td>
				</tr>
				<tr>
					<td>
						<div class="form-group">
						  <label for="sel1">Project Category(택 1):</label>
						  <select class="form-control" id="category" name="category" style="font-size: 1em; height: 10%">
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
							<textarea id="summernote" name="content"></textarea>
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
						  <select class="form-control" id="bankname" style="font-size: 1em; height: 10%">
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
						  <input type="text" class="form-control" id="accountNumber" placeholder="중간바(-)는 빼고 숫자만 입력해주세요" style="font-size: 15px" size="100%">
						</div>
					</td>
				</tr>
			</table>
        </div>
      </div>
    </div>
    <!-- [9] 각종 날짜(시작일 / 종료일  / 결제일(정산일) / 배송일) -->
    <div class="panel panel-default">
      <div class="panel-heading">
        <h4 class="panel-title">
          <a data-toggle="collapse" data-parent="#accordion" href="#collapse9" id="col_date">프로젝트 진행 스케줄</a>
        </h4>
      </div>
      <div id="collapse9" class="panel-collapse collapse">
        <div class="panel-body">
        	<table style="width: 100%">
				<tr>
					<td>
						<div class="form-group">
						  <!-- <label for="sel1"> -->
						  <div class="desc projectimg">
						  	프로젝트의 시작일, 종료일 , 정산일, 배송일을 각각 선택해주세요.<br>
						  </div>
						  <!-- </label> -->
						</div>
					</td>
				</tr>
				<tr>
					<td>
						<div class="form-group">
						  <label for="sel1">프로젝트 시작일</label>
						  <input type="text" class="date" id="date1" name="sdate" placeholder="오늘부터 선택 가능합니다" size="30%">
						</div>
					</td>
				</tr>
				<tr>
					<td>
						<div class="form-group">
						  <label for="sel1">프로젝트 종료일</label>
						  <input type="text" class="date" id="date2" name="edate" placeholder="시작일의 다음날부터 선택 가능합니다" size="30%">
						</div>
					</td>
				</tr>
				<tr>
					<td>
						<div class="form-group">
						  <label for="sel1">프로젝트 정산일·결제일</label>
						  <input type="text" class="date" id="date3" name="pdate" placeholder="종료일의 다음날부터 선택 가능합니다" size="30%">
						</div>
					</td>
				</tr>
				<tr>
					<td>
						<div class="form-group">
						  <label for="sel1">프로젝트 배송일(기부 프로젝트일 경우, 이 칸을 비워두세요)</label>
						  <input type="text" class="date" id="date4" name="shipdate" placeholder="정산일의 다음날부터 선택 가능합니다" size="30%">
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


<input type="button" id="btn_submit" value="전송">

<!-- 프로젝트 입력값을 컨트롤러로 전송하기 위한 가장 큰 form 끝. -->







	

<!-- (3) 세번째 탭 -->
<div id="menu2" class="tab-pane fade">
  <br>
<!-- 큰 테두리 -->
<div class="container">
  <h1>리워드 등록</h1>
  	<div class="panel-group" id="accordion">
  		<!-- [10] 옵션 개수 선택 -->
	    <div class="panel panel-default">
	      <div class="panel-heading">
	        <h4 class="panel-title">
	          <a data-toggle="collapse" data-parent="#accordion" href="#collapse10" id="col_content">옵션 개수 선택</a>
	        </h4>
	      </div>
	      <div id="collapse10" class="panel-collapse collapse">
	        <div class="panel-body">
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
							  <select class="form-control" id="sel1" name="option_total" onchange="optionChange(this)" style="font-size: 1em; height: 10%">
							    <%
								for(int i=1; i <= 10; i++){
									%>
									<option <%=(10+"").equals(i+"")?"selected='selected'":"" %> value="<%=i%>"><%=i%></option>
									<%
								}
								%>
							  </select>
							</div>
						</td>
					</tr>
				</table>
	        </div>
	      </div>
	    </div>
	    <!-- [11] 리워드 등록 -->
	    <div id="newRewird">
	    <%
		for(int i=1; i <= 10; i++){
			%>
	    <div id="_option<%=(i+10 + "")%>">
	    
	    
	    <div class="panel panel-default">
	      <div class="panel-heading">
	        <h4 class="panel-title">
	        
					<a data-toggle="collapse" data-parent="#accordion" href="#collapse10" class="notChangedOption"><%=(i + "") %>번째 선물</a>

	          		<a data-toggle="collapse" data-parent="#accordion" href="#collapse<%=(i+10 + "")%>" class="changedOption"><%=(i + "") %>번째 선물</a>

	        </h4>
	      </div>
	      <div id="collapse<%=(i+10 + "")%>" class="panel-collapse collapse">
	        <div class="panel-body">
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
							  <input type="text" class="form-control" id="title<%=i %>" name="op_title" placeholder="[얼리버드] 등 대표 제목을 작성해주세요" style="font-size: 15px" size="100%">
							</div>
						</td>
					</tr>
					<tr>
						<td colspan="2">
							<div class="form-group">
							  <label for="sel1">아이템</label>
							  <textarea class="form-control" rows="5" id="op_content<%=i %>" name="op_content" style="font-size: 15px" placeholder="아이템은 선물에 포함되는 구성 품목을 말합니다. 각 품목은 줄바꿈으로 구분해주세요."></textarea>
							</div>
						</td>
					</tr>
					<tr>
						<td>
							<div class="form-group">
							  <label for="sel1">후원 금액</label>
							  <input type="text" class="form-control" id="op_price<%=i %>" name="op_price" placeholder="해당 옵션의 적정가를 책정해주세요" style="font-size: 15px" size="50%">
							</div>
						</td>
						<td>
							<div class="form-group">
							  <label for="sel1">보유 수량</label>
							  <input type="text" class="form-control" id="op_stock<%=i %>" name="op_stock" placeholder="재고 제한이 없는 경우 공란으로 비워두세요" style="font-size: 15px" size="50%">
							</div>
						</td>
					</tr>
				</table>
	        </div>
	      </div>
	    </div>
	    
	    
	    </div>
	    	<%
		}
		%>
	    </div>
  	</div>
</div>
</div>
<!-- 3번째 탭 내용 끝 -->
</div>
</div>
</form>

<script>
//전송버튼 눌렀을 때
$("#btn_submit").click(function () {
	alert("전송");
	
	// 선택한 은행+계좌번호 가져와
	var bankname = $("#bankname").val();
	var accountNumber = $("#accountNumber").val();
	
	alert(bankname + accountNumber);
	// hidden에 bank값 세팅
	$("#bank").val(bankname + "/" + accountNumber);
	
	
	// form 실행! 컨트롤러로~
	$("#createProjectFrom").submit();
});

/* 글자 길이 확인 */
function checkLength (selector,messageSelector,maxlength){
	var curr = $(selector).val().length;
	var left = maxlength-curr;
	if(left>0){
		$(messageSelector).text(maxlength-curr + "자 남았습니다.");
	}else{
		$(messageSelector).text(curr-maxlength + "자 초과했습니다.");
	}
}

</script>
 
