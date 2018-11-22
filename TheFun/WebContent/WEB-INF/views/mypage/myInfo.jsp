<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script> <!-- 주소검색 -->
<script src="CSS/mainVendor/jquery/jquery.min.js"></script>
<style type="text/css">
input {
  /* outline: 0; */
  background: #f2f2f2;
  width: 100%;
  border: 0;
  margin: 0 0 5px;
  padding: 15px;
  border-top-left-radius: 3px;
  border-top-right-radius: 3px;
  border-bottom-left-radius: 3px;
  border-bottom-right-radius: 3px;
  box-sizing: border-box;
  font-size: 14px;
}
.tb{
	min-width: 400px;
	max-width: 600px;
}

/* 미디어 쿼리 */

.main {
  position: relative;
  /* left: 0;
  right: 0; */
  border-radius: 0;
  max-width: 900px;   
  width: 100%;   
  margin: auto;
  /* overflow:hidden;   */
}
.left {
  width: 100%;
  margin: auto;
 /*  padding-bottom: 0.7rem; */
}
.right {
  /* display: flex; */
  width: 100%;
  margin: auto;
}
@media screen and (min-width: 55em) {
  /* .main {
    max-width: 1000px;   
    overflow: visible;
  } */
  .left {
    width: 50%;
    float: left;
  }
  .right {
    width: 50%;
    float: right;
  }
  
}

</style>
</head>
<body>	
<form action="updateInfo.do" method="post" style="display: list-item;">
<div class="main form">		
	<div class="left" align="center"> 
	<table class="tb">		
		<!-- 아이디 -->
		<tr>
			<td style="text-align: left; ">아이디</td>
			<td colspan="2"> 
				<input type="text" name="myid" id="id" placeholder="아이디" maxlength="12" onblur="idCheck()" value="${myi.id }" readonly="readonly" />
				<span id="idcheckMessage" style="color:red; font-size:11px;"></span> 
			</td>
		</tr>
		
		<!-- 비밀번호는 null 이면 안보여줌 -->	
		<tr>
			<td style="text-align: left;">현재 비밀번호</td>
			<td colspan="2">
				<input type="password" id="myPwd" name="pwd" maxlength="12" value="${myi.pwd }" placeholder="비밀번호" onkeyup="myPwdCheck()" />
				<span id="pwdCheckMessage" style="color:red; font-size:11px;"></span> 
			</td>
		</tr>
		
		<tr><!-- null 이면 readonly -->
			<td style="text-align: left;">새 비밀번호</td>
			<td colspan="2">
				<input type="password" id="newPwd" name="pwd" maxlength="12" value="${myi.pwd }" placeholder="비밀번호" onkeyup="newPwdCheck()" />
				<span id="pwdCheckMessage" style="color:red; font-size:11px;"></span> 
			</td>
		</tr>
		
		<tr class="hideWhenRead"><!-- null 이면 readonly -->
			<td style="text-align: left;">새 비밀번호 확인</td>
			<td colspan="2">
				<input type="password" id="newPwdCheck" maxlength="12" value="${myi.pwd }" placeholder="비밀번호" onkeyup="pwdCheck()" readonly="readonly"  />
			</td>
		</tr>
		
		<tr>
			<td style="text-align: left;">별명</td>
			<td colspan="2">
				<span id="nicknameCheckMessage" style="color:red; font-size:11px;"></span> 
				<input type="text" id="myNickname" name="nickname" placeholder="이름" onkeyup="nicknameCheck()" maxlength="15" value="${myi.nickname }" readonly="readonly"  />
			</td>
		</tr>
			
		<tr>
			<td style="text-align: left;">이메일</td>
			<td colspan="2">
				<span id="emailCheckMessage" style="color:red; font-size:11px;"></span> 
				<input type="text" id="myEmail" name="email" placeholder="이메일 주소" maxlength="15" onkeyup="emailCheck()" value="${myi.email }" readonly="readonly" />
			</td>
		</tr>
	</table>
	</div>
	
	<!-- 여기부터는 옵션 -->
	<div class="right" align="center"> 
	<table class="tb">	
		<!-- <colgroup>
			<col width="35%"><col width="55%"><col width="10%">
		</colgroup> -->
		
		<!-- 전화번호 -->
		<tr>
			<td style="text-align: left;">전화번호</td>
			<td colspan="2">
				<span id="phoneCheckMessage" style="color:red; font-size:11px;"></span> 
				<input type="text" id="myPhone" name="phone" placeholder="전화번호" maxlength="13" onkeyup="phoneCheck()" value="${myi.phone }"  readonly="readonly" >
			</td>
		</tr>
		
		<!-- 주소 -->
		<tr>
			<td style="text-align: left;">주소</td>
			<td >
				<input type="text" id="myPostcode" name="postcode" placeholder="우편번호" readonly="readonly" value="${myi.postcode}" readonly="readonly">		
			</td>
			<td>
				<input type="button" onclick="sample4_execDaumPostcode()" style="background: #8152f0; cursor: pointer; color: white" value="우편번호 찾기">
			</td>
		</tr>
		<tr>
			<td></td>
			<td colspan="2">
				<input type="text" id="myRoadAddress" name="roadaddress" placeholder="도로명주소" readonly="readonly" value="${myi.roadaddress}"  readonly="readonly">
			</td>
		</tr>
		<tr>
			<td></td>
			<td colspan="2">
				<input type="text" id="myDetailAddress" name="detailaddress" maxlength="30" onkeyup="detailAddressCheck()" placeholder="상세주소" value="${myi.detailaddress}"  readonly="readonly">
			</td>
		</tr>
		<tr>
			<td style="text-align: left;">소개</td>
			<td colspan="2">
				<span id="infoCheckMessage" style="color:red; font-size:11px;"></span>		
				<input type="text" id="myInfo" name="info" maxlength="30" onkeyup="infoCheck()" placeholder="소개글" value="${myi.info }"/>			
			</td>
		</tr>
		
		<tr>
			<td style="text-align: left;">포인트</td>
			<td colspan="2">			
				<input type="text" id="myPoint" name="point" value="${myi.point }"/>
			</td>
		</tr>	
	</table>
	</div>
		
	<div class="right" style="width: 100%;" align="center">
		<input type="button" id="submitBtn" onclick="infoUpdate()" style="background: #8152f0; cursor: pointer; color: white; width: 200px" value="수정하기" disabled="disabled"/>
	</div>	
	</div>
</form>

<script type="text/javascript">
/* 회원가입 유효성 검사 */
var pwdOk = false;
var newPwdOk = false;
var emailOk = false;
var nicknameOk = false;
var infoOk = true;
var phoneOk = true;

function checkSubmitActivation(){
	if(newPwdOk && pwdOk && emailOk && nicknameOk && infoOk && phoneOk){
		document.getElementById("submitBtn").disabled = false;
		document.getElementById("submitBtn").style.background = "#8152f0";
		document.getElementById("submitBtn").style.cursor =  "pointer";
	}else{
		document.getElementById("submitBtn").disabled = true;
		document.getElementById("submitBtn").style.background = "#E2E2E2";
		document.getElementById("submitBtn").style.cursor =  "default";
	}
}

function myPwdCheck() {
	$.ajax({
		type:"post",
		url:"pwdCheck.do",
		data:"id=${myi.id}$pwd=" + $('#myPwd').val(),		
		success:function(data){						
			if(data.trim() != "OK"){ //비밀번호 일치
				pwdOk = true;
			}else{
				pwdOk = false;
			}
		}
	});	
}

function pwdCheck() {		
	var re = /^[a-zA-Z0-9]{3,12}$/ // 아이디와 패스워드가 적합한지 검사할 정규식
	if(!re.test($('#newPwd').val())) {
		$("#pwdCheckMessage").text("3~12자의 영문 대소문자와 숫자로만 입력해 주세요");
		$("#newPwd").focus();
		pwdOk = false;
		checkSubmitActivation();
    }else if(($("#newPwdCheck").val() !=null ) && ($("#newPwd").val() != $("#newPwdCheck").val())){ // 비밀 번호 다르면
		$("#pwdCheckMessage").text("비밀번호가 일치하지 않습니다.");		
		pwdOk = false;
		checkSubmitActivation();
	}else{
		$("#pwdCheckMessage").text("");		
		pwdOk = true;
		checkSubmitActivation();
	}
}

function nicknameCheck() { // 15글자 이내
	//console.log("nicknameCheck");
	var regExp = /[\{\}\[\]\/?.,;:|\)*~`!^\-_+<>@\#$%&\\\=\(\'\"]/gi;
	if(regExp.test($("#myNickname").val()) || $("#myNickname").val().length < 2 ){	    
		$("#nicknameCheckMessage").text("한글 또는 영어로만 2~15자 이내로 적어주세요");
		$("#myNickname").focus();
		nicknameOk = false;
		checkSubmitActivation();
	}else{
		$("#nicknameCheckMessage").text("");
		nicknameOk = true;
		checkSubmitActivation();
	}
}

function infoCheck() { // 30글자 이내
	var regExp = /[\{\}\[\]\/?.,;:|\)*~`!^\-_+<>@\#$%&\\\=\(\'\"]/gi;
	if(regExp.test($("#myInfo").val()) && $("#myInfo").val().length != 0){	    
		$("#infoCheckMessage").text("한글 또는 영어로만 30자 이내로 적어주세요");
		$("#myInfo").focus();
		infoOk = false;
		checkSubmitActivation();
	}else{
		$("#infoCheckMessage").text("");
	    infoOk = true;
		checkSubmitActivation();
	}
}
/* 상세 주소 */
function detailAddressCheck() {	
	var text = $("#myDetailAddress").val();
	//var regExp = /[\{\}\[\]\/?.,;:|\)*~`!^\-_+<>@\#$%&\\\=\(\'\"]/gi;
	text = text.replace(/[<(+>]/g, '');
	$("#myDetailAddress").val(text);	
}
function phoneCheck(){
	var text = $("#myPhone").val();
	var regExp = /^\d{3}-\d{3,4}-\d{4}$/;
	//text = text.replace(/[^0-9]/g, '');
	//$("#newPhone").val(text);
	if (!text.match(regExp) && $("#myPhone").val().length != 0) {
		$("#phoneCheckMessage").text("전화번호 형식:XXX-XXXX-XXXX");
		phoneOk = false;
		checkSubmitActivation();
	}else{
		$("#phoneCheckMessage").text("");
		phoneOk = true;
		checkSubmitActivation();
	}
}

function emailCheck() {
	var emailVal = $("#myEmail").val();
	var regExp = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;	
				
	if(emailVal.match(regExp) == null) { // 형식이 올바르지 않은 경우
		$("#emailCheckMessage").text("올바른 이메일을 입력해 주세요");
	    $("#myEmail").focus();
	    emailOk = false;
		checkSubmitActivation();
	    return;
	}
}

/* 주소검색 */
function sample4_execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
            var extraRoadAddr = ''; // 도로명 조합형 주소 변수

            // 법정동명이 있을 경우 추가한다. (법정리는 제외)
            // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
            if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                extraRoadAddr += data.bname;
            }
            // 건물명이 있고, 공동주택일 경우 추가한다.
            if(data.buildingName !== '' && data.apartment === 'Y'){
               extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
            }
            // 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
            if(extraRoadAddr !== ''){
                extraRoadAddr = ' (' + extraRoadAddr + ')';
            }
            // 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
            if(fullRoadAddr !== ''){
                fullRoadAddr += extraRoadAddr;
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('postcode').value = data.zonecode; //5자리 새우편번호 사용
            document.getElementById('roadAddress').value = fullRoadAddr;
           
        }
    }).open();
}
</script>

<script type="text/javascript">
$("#button").click(function infoUpdate() {
	// [도현누나]랑 연결 :: 회원정보 수정
});
</script>

</body>
</html>