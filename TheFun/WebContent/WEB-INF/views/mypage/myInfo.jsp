<%@page import="donzo.thefun.model.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:requestEncoding value="utf-8"/> 

<link rel="stylesheet" href="CSS/mainCss/myInfo.css">
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script> <!-- 주소검색 -->
 
<style type="text/css">
.input {
  outline: 0;
  background: #f2f2f2;
  width: 100%;
  border: 0;
  margin: 6px 0 0;
  padding: 15px;
  border-top-left-radius: 3px;
  border-top-right-radius: 3px;
  border-bottom-left-radius: 3px;
  border-bottom-right-radius: 3px;
  box-sizing: border-box;
  font-size: 14px;
}
.tb{
   max-width: 600px;
   width: 90%;
   margin: 10px;
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
/* 프로필 사진 */
.imgbox{
	display: table-cell; /* 이미시를 세로 가운데 정렬할때 필요 */
	vertical-align: middle; /* 이미시를 세로 가운데 정렬할때 필요 */
	position: relative;
	width: 150px;
	height: 150px;
}
.holder{
	height: 150px;
	width: 150px;	
	position: relative;
	z-index: -1;	
	border-radius: 150px;
    object-fit: cover;
    vertical-align: middle;	
}
.upload {
	align-self: center;
	width: 150px;
	height: 150px;
	opacity: 0;
	/* background-color:red; */
	cursor: pointer; 
	position: absolute;
	top: 0;
	left: 0;
	z-index: 1;
} 

.profile_img{   
    float: none;
    width: 200px;
    height: 200px;
    border-radius: 100%;
    margin: 5px;
    vertical-align: middle;
    object-fit: cover;
}

/* 프로필 이미지 변경 */
.gb_mb {
    background: rgba(0,0,0,.54);
    bottom: 0;
    color: #fff;
    font-size: 12px;
    font-weight: bold;
    left: 0;
    line-height: 9px;
    position: absolute;
    padding: 8px 0;
    text-align: center;
    width: 150px;
}

</style> 

<header class="line_header">
  <div class="container text-center">
    <h1 class="head_title">MY INFOMAION</h1>
    <p>나의 정보</p>
  </div>
</header>

<br><br>

<form action="updateInfo.do" method="post" style="display: flow-root;" enctype="multipart/form-data">
<input type="hidden" name="id" value="${login.id}"/>
<input type="hidden" id="imgPath" name="imgPath" value="${login.profile}">
<input type="hidden" name="profile" value="${login.profile}">
<input type="hidden" name="account" value="${login.account}">
<c:if test="${login.pwd ne null}"> <!-- 일반 로그인 -->
<div class="group" style="width: 100%;" align="center">	
	<table style="border: 0">
	<tr>
		<td>
			<div class="imgbox" align="center">
			<img id="editable-Img" src='${login.profile}' class='holder' align='middle'>
			<span class="gb_mb">변경</span>
			<input type="file" name="fileload" accept="image/gif, image/jpeg, image/png" class="upload" id="upload-Image" onchange="loadImageFile();" title="클릭하여 프로필 사진 변경">
			</div>
		</td>
	</tr>
	<tr>	
		<td style="padding-top: 5px;">
			<div align="center">
			<a href="javascript:profile_default()" id="profile_default">
			기본사진으로 변경
		    </a>
			</div>
		</td>
	</tr>
	</table>
</div>

<br>

</c:if>
<div class="main form">
<div class="left" align="center"> 
<c:choose>
	<c:when test="${login.pwd ne null}">		
		<table class="tb">		
			<!-- 아이디 -->
			<tr>
				<td style="text-align: left; ">아이디</td>
				<td colspan="2"> 
					<input class="input" type="text" value="${login.id}" readonly="readonly" />
					<span id="idcheckMessage" style="color:red; font-size:11px;"></span> 
				</td>
			</tr>
			
			<!-- 비밀번호는 안보여줌 -->	
			<tr> <!-- 개인정보 수정하려면 현재 비밀번호를 입력해야됨  -->
				<td style="text-align: left;">현재 비밀번호</td>
				<td colspan="2">
					<input class="input" type="password" id="myPwd" name="myPwd" maxlength="12" placeholder="현재 비밀번호" onblur="myPwdCheck()" />				
				</td>
			</tr>
			<tr><td></td><td colspan="2" id="myPwdCheckMessage" style="color:red; font-size:11px;" ></td></tr> 
			<tr>
				<td style="text-align: left;">새 비밀번호</td>
				<td colspan="2">
					<input class="input" type="password" id="newPwd" name="pwd" maxlength="12" placeholder="비밀번호" onkeyup="myNewPwdCheck()" />
				</td>
			</tr>
			<tr><td></td><td colspan="2" id="pwdCheckMessage" style="color:red; font-size:11px; margin: 0;" ></td></tr>
			
			<tr class="hideWhenRead"><!-- null 이면 readonly -->
				<td style="text-align: left;">새 비밀번호 확인</td>
				<td colspan="2">
					<input class="input" type="password" id="newPwdCheck" maxlength="12" placeholder="비밀번호 확인" onkeyup="myNewPwdCheck()" />
				</td>
			</tr>
			
			<%-- <tr>
				<td style="text-align: left;">별명</td>
				<td colspan="2">
					<input class="input" type="text" id="myNickname" name="nickname" placeholder="이름" onkeyup="nicknameCheck()" maxlength="15" value="${login.nickname }" />
				</td>
			</tr>
			<tr><td></td><td colspan="2" id="nicknameCheckMessage" style="color:red; font-size:11px;" ></td></tr>  --%>
				
			<tr>
				<td style="text-align: left;">이메일</td>
				<td colspan="2">
					<input class="input" type="text" id="myEmail" name="email" placeholder="이메일 주소" maxlength="15" onkeyup="emailCheck()" value="${login.email }" />
				</td>
			</tr>
			<tr><td></td><td colspan="2" id="emailCheckMessage" style="color:red; font-size:11px;" ></td></tr>
			<tr>
				<td style="text-align: left;">전화번호</td>
				<td colspan="2">
					<input class="input" type="text" id="myPhone" name="phone" placeholder="전화번호" maxlength="13" onkeyup="autoHyphen(this)" value="${login.phone }" />
				</td>
			</tr>
			<tr><td></td><td colspan="2" id="phoneCheckMessage" style="color:red; font-size:11px;" ></td></tr> 		
		</table>
	</c:when>
		
	<c:otherwise> <!-- 연동 로그인 -->	
		<input type="hidden" name="account" value="${login.account}"/>
		<table class="tb" style="text-align: center">		
			<tr valign="middle">
				<td colspan="2">
					<div style="border: 2px solid #8152f0; font-weight: bold; padding-top:8px; padding-bottom:8px; border-radius: 50px; font-size: 20px; color: #8152f0;">
					${login.accountKr()} 아이디로 로그인중
					</div>
				</td>
			</tr>
			<tr>
				<td  colspan="2" align="center">
					<div class="imgbox" align="center" style="padding-top: 10px;">
					<img id="editable-Img" src='${login.profile}' class='holder' align='middle'>
					<span class="gb_mb">변경</span>
					<input type="file" name="fileload" accept="image/gif, image/jpeg, image/png" class="upload" id="upload-Image" onchange="loadImageFile();" title="클릭하여 프로필 사진 변경">
					</div>
				</td>
			</tr>
			<tr>	
				<td  colspan="2" style="padding-top: 5px;">
					<div align="center">
					<a href="javascript:profile_default()" id="profile_default">
					기본사진으로 변경
				    </a>
					</div>
				</td>
			</tr>
			<tr>
				<td style="text-align: left;">이메일</td>
				<td colspan="2">
					<input class="input" type="text" id="myEmail" name="email" placeholder="이메일 주소" maxlength="30" onkeyup="emailCheck()" value="${login.email }" />
				</td>
			</tr>
			<tr><td></td><td colspan="2" id="emailCheckMessage" style="color:red; font-size:11px;" ></td></tr> 	
			<tr>
				<td style="text-align: left;">전화번호</td>
				<td colspan="2">
					<input class="input" type="text" id="myPhone" name="phone" placeholder="전화번호" maxlength="13" onkeyup="autoHyphen(this)" value="${login.phone }" />
				</td>
			</tr>
			<tr><td></td><td colspan="2" id="phoneCheckMessage" style="color:red; font-size:11px;" ></td></tr> 		
		</table>
	</c:otherwise>
</c:choose>	
</div>
	<div class="right" align="center"> 
	<table class="tb">
		<tr>
			<td style="text-align: left;">별명</td>
			<td colspan="2">
				<input class="input" type="text" id="myNickname" name="nickname" placeholder="이름" onkeyup="nicknameCheck()" maxlength="15" value="${login.nickname }" />
			</td>
		</tr>
		<tr><td></td><td colspan="2" id="nicknameCheckMessage" style="color:red; font-size:11px;" ></td></tr> 	
		<!-- 주소 -->
		<tr>
			<td style="text-align: left;">주소</td>
			<td >
				<input class="input" type="text" id="postcode" name="postcode" placeholder="우편번호" readonly="readonly" value="${login.postcode}" readonly="readonly">		
			</td>
			<td>
				<input class="input" type="button" onclick="sample4_execDaumPostcode()" style="background: #8152f0; cursor: pointer; color: white" value="우편번호 찾기">
			</td>
		</tr>
		<tr>
			<td></td>
			<td colspan="2">
				<input class="input" type="text" id="roadAddress" name="roadaddress" placeholder="도로명주소" readonly="readonly" value="${login.roadaddress}"  readonly="readonly">
			</td>
		</tr>
		<tr>
			<td></td>
			<td colspan="2">
				<input class="input" type="text" id="myDetailAddress" name="detailaddress" maxlength="30" onkeyup="detailAddressCheck()" placeholder="상세주소" value="${login.detailaddress}">
			</td>
		</tr>
		<tr>
			<td style="text-align: left;">소개</td>
			<td colspan="2">
				<textarea class="input" id="myInfo" name="info" maxlength="200" onkeyup="infoCheck()" placeholder="소개글" style="height:115px"/>${login.info}</textarea>			
			</td>
		</tr>
		<tr><td></td><td colspan="2" id="infoCheckMessage" style="color:red; font-size:11px;" ></td></tr> 
		
		<%-- <tr>
			<td style="text-align: left;">포인트</td>
			<td colspan="2">			
				<input class="input" type="text" id="myPoint" name="point" value="${login.point}" readonly="readonly"/>
			</td>
		</tr>	 --%>
	</table>
	</div>
		
	<div class="right" style="width: 100%;" align="center">
		<br>
		<input class="input" type="submit" id="submitBtn" style="background: #E2E2E2; cursor: default; color: white; width: 200px" value="수정하기" disabled="disabled"/>
	</div>	
	</div>
</form>
<!-- 유효성 검사 -->
<script type="text/javascript">
var pwdOk = false;
var newPwdOk = true;
var emailOk = true;
var nicknameOk = true;
var infoOk = true;
var phoneOk = true;

$(document).ready(function(){
	checkSubmitActivation();
});
function checkSubmitActivation(){
	//console.log(newPwdOk + " " + pwdOk + " " + emailOk + " " + nicknameOk + " " + infoOk + " " + phoneOk)
	if('${login.account}' != '' && '${login.account}' != 'normal'){                                                     
		pwdOk=true;
		newPwdOk = true;
	}
	if(newPwdOk && pwdOk && emailOk && nicknameOk && infoOk && phoneOk){
		//console.log(pwdOk);
		//console.log("수정 돼!");
		document.getElementById("submitBtn").disabled = false;
		document.getElementById("submitBtn").style.background = "#8152f0";
		document.getElementById("submitBtn").style.cursor =  "pointer";
	}else{
		//console.log("수정 안 돼!");
		document.getElementById("submitBtn").disabled = true;
		document.getElementById("submitBtn").style.background = "#E2E2E2";
		document.getElementById("submitBtn").style.cursor =  "default";
	}
}

function myPwdCheck() {		
	if($('#myPwd').val() == ""){
		pwdOk = false;
		return;
	}
	$.ajax({
		type:"post",
		url:"pwdCheck.do",
		data:"id=${login.id}&pwd="+$('#myPwd').val(),
		
		success:function(data){		
			if(data == "OK" ){ //비밀번호 일치
				$("#myPwdCheckMessage").text("");	
				pwdOk = true;
				checkSubmitActivation();		
			}else{
				$("#myPwdCheckMessage").text("비밀번호가 일치하지 않습니다.");	
				pwdOk = false;
				checkSubmitActivation();
			}
		}
	});		
}

function myNewPwdCheck() {		
	var re = /^[a-zA-Z0-9]{3,12}$/ // 아이디와 패스워드가 적합한지 검사할 정규식
	if($('#newPwd').val() != "" && !re.test($('#newPwd').val())) {
		$("#pwdCheckMessage").text("3~12자의 영문과 숫자로만 입력해 주세요");
		$("#newPwd").focus();
		newPwdOk = false;
		checkSubmitActivation();
    }else if(($('#newPwd').val() != "" && $("#newPwdCheck").val() !="" ) && ($("#newPwd").val() != $("#newPwdCheck").val())){ // 비밀 번호 다르면
		$("#pwdCheckMessage").text("비밀번호가 일치하지 않습니다.");		
		newPwdOk = false;
		checkSubmitActivation();
	}else{
		$("#pwdCheckMessage").text("");		
		newPwdOk = true;
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
	var regExp = /[\{\}\[\]\/.,;:|\)*~`\-_+<>@\#$%&\\\=\(\'\"]/gi;
	if(regExp.test($("#myInfo").val()) && $("#myInfo").val().length != 0){	    
		$("#infoCheckMessage").text("한글 또는 영어로만 200자 이내로 적어주세요");
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

function emailCheck() {
	var emailVal = $("#myEmail").val();
	var regExp = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;	
				
	if(emailVal.match(regExp) == null || emailVal == "") { // 형식이 올바르지 않은 경우
		$("#emailCheckMessage").text("올바른 이메일을 입력해 주세요");
	    $("#myEmail").focus();
	    emailOk = false;
		checkSubmitActivation();
	}else{
		$("#emailCheckMessage").text("");
	    emailOk = true;
		checkSubmitActivation();
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
<!-- 프로필 이미지 미리보기, 기본이미지로 변경 -->
<script type="text/javascript">
var fileReader = new FileReader();
var filterType = /^(?:image\/bmp|image\/cis\-cod|image\/gif|image\/ief|image\/jpeg|image\/jpeg|image\/jpeg|image\/pipeg|image\/png|image\/svg\+xml|image\/tiff|image\/x\-cmu\-raster|image\/x\-cmx|image\/x\-icon|image\/x\-portable\-anymap|image\/x\-portable\-bitmap|image\/x\-portable\-graymap|image\/x\-portable\-pixmap|image\/x\-rgb|image\/x\-xbitmap|image\/x\-xpixmap|image\/x\-xwindowdump)$/i;
fileReader.onload = function (event) { // 파일이 로드 되었을 때
   var image = new Image(); // 새로운 이미지를 생성한다.
   image.onload = function() {      
      document.getElementById("editable-Img").src = image.src;
   }
   image.src = event.target.result;
};
var loadImageFile = function () {
	  var uploadImage = document.getElementById("upload-Image"); //파일 요소 가져와서
	  
	  //check and retuns the length of uploded file.
	  if (uploadImage.files.length == 0) {  // 업로드 된게 있는지 확인하고
	    return; 
	  }	 
	  
	  //Is Used for validate a valid file.
	  var uploadFile = document.getElementById("upload-Image").files[0]; // 업로드된 파일중 첫 번째를 가져온다.
	  
	  if (!filterType.test(uploadFile.type)) {
	    alert("Please select a valid image."); 
	    return;
	  }	  
	  fileReader.readAsDataURL(uploadFile); // 파일 리더를 이용해 파일을 읽는다
};

/* 기본 이미지로 변경 */
function profile_default() {
	$("#editable-Img").attr("src", "<%=MemberDto.DEFAULTIMGPATH%>");
	$("#imgPath").val("<%=MemberDto.DEFAULTIMGPATH%>");
	//console.log("profile_default() profile_keep_or_default : false");
	//$("#profile_keep_or_default").val('false');
} 

$('#editable-Img').on('load', function () {
	$("#imgPath").val($(this).attr('src'));
	//console.log($("#imgPath").val());	
});	

//휴대폰 번호 자동 하이픈(-)
function autoHypenPhone(str){ 
	  str = str.replace(/[^0-9]/g, '');
	  var tmp = '';
	  if( str.length < 4){
	    return str;
	  }else if(str.length < 7){
	    tmp += str.substr(0, 3);
	    tmp += '-';
	    tmp += str.substr(3);
	    return tmp;
	  }else if(str.length < 11){
	    tmp += str.substr(0, 3);
	    tmp += '-';
	    tmp += str.substr(3, 3);
	    tmp += '-';
	    tmp += str.substr(6);
	    return tmp;
	  }else{        
	    tmp += str.substr(0, 3);
	    tmp += '-';
	    tmp += str.substr(3, 4);
	    tmp += '-';
	    tmp += str.substr(7);
	    return tmp;
	  }
	  return str;
	}
	

function autoHyphen(phoneField){
	var _val = $(phoneField).val().trim();
	$(phoneField).val(autoHypenPhone(_val)) ;
}
 
</script>

<!-- 본문출력 묶는 태그 -->
	<jsp:include page="../common/footer.jsp"/>
	</main>
	</div> 
<!-- //본문출력 묶는 태그 -->