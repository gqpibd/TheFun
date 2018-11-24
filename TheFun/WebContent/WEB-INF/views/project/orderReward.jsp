<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:requestEncoding value="utf-8"/> 

<title>The Fun_orderReward</title>
 
<style type="text/css">
 .pupple{
 	color:#8152f0;
 	font-weight: bold;
 	font-size:large;
 	font-family: "Nanum Gothic", sans-serif;
 }
 .strongGray{
 font-family: "Nanum Gothic", sans-serif;
  color: #5c5c5c;
  font-weight: bold;
  font-size: x-large;
  
 }
  .cardInfo{
 font-family: "Nanum Gothic", sans-serif;
  color: #5c5c5c;
  font-weight: bold;
  
 }
 .liteGray{
 	font-family: "Nanum Gothic", sans-serif;
	 color: #818181;
 }
  .profiletitle{
  text-align:left;
  font-size:large;
 font-family: "Nanum Gothic", sans-serif;
	 color: #5c5c5c;
 }
 
.profile{
  text-align:left;
  font-size:large;
  font-family: "Nanum Gothic", sans-serif;
	 color: #818181;
 }
 
.td1{
	text-align:left;
	padding: 10px;
	width: 55%;
}
.td2{
	text-align:right;
	width: 25%;
}
.td3{
	text-align:right;
	width: 20%;
}
.Fee{
	background-color:transparent;
	border:none;
	text-align:right;
}
</style>

<div class="container">
  <div class="my-4" align="center">
    <div align="center" >
    <form action="order.do">
    <!-- 메인 -->
      <p class="strongGray">${projectdto.title } </p>
      <br>
      <!-- 옵션테이블 -->
      <c:forEach items="${selectOptions }" var="options">
      <input type="hidden" name="opSeq" value="${options.seq }">
		<table style="width: 70%">
		<tr>
			<td class="pupple"align="left">${options.title}</td>
		</tr>
		<tr>
			<td class="liteGray td1">
			 <c:forEach items="${options.content}" var="item">
		  		<li class="liteGray">${item}</li>
		 	 </c:forEach>
		</td>
		<td class="td2 liteGray">
			수량 : <input type="text" id="${options.seq}" name="opCount" value="1" size="3">개
			<button type="button"onclick="plusVal(${options.seq})" >+</button>
			<button type="button"onclick="minusVal(${options.seq})" >- </button>
		</td>
		<td class="liteGray td3">
			<input type="text" readonly="readonly" value="${options.price}" class="Fee liteGray" size="10" id="${options.seq}_p">원
			</td>
		</tr>
		</table> <br>
	</c:forEach>    
     <!-- 사용자정보 -->
     	<table style="width: 70%">
     	<tr>
     		<td class="profiletitle">이름</td>
     	</tr>
     	<tr>
     		<td class="profile">${login.nickname}</td>
     	</tr>
     	<tr>
     		<td class="profiletitle">이메일</td>
     	</tr>
     	<tr>
     		<td class="profile">${login.email}</td>
     	</tr>
     	<tr>
     		<td class="profiletitle">휴대폰 번호</td>
     	</tr>
     	<tr>
     		<td class="profile">${login.phone}</td>
     	</tr>
     	<tr>
     		<td class="profiletitle">배송지</td>
     	</tr>
     	<tr>
     		<td class="profile">${login.postcode} ${login.roadaddress} ${login.detailaddress}</td>
     	</tr>
     	</table>
     	<br><br>
     	<div style="width: 70%" align="left">
     	<p class="strongGray" style="">더펀 리워드 펀딩은 결제예약 시스템을 이용합니다.</p>
     	<ul class="liteGray" >
<li>쇼핑하기처럼 바로 결제되지 않습니다. 프로젝트의 성공여부에 따라 결제가 실행됩니다.</li>
<li>결제정보 입력 후 결제예약을 완료하시면, 결제대기중으로 예약상태로 등록됩니다.</li>
<li>프로젝트 종료일(${projectdto.edate }) 의 다음 영업일에 펀딩 성공여부에 따라 결제실행/결제취소가 진행됩니다.</li>
	<li>포인트를 사용하여 총 결제금액이 0원인 경우에는 결제정보를 입력할 필요 없이 결제완료로 처리됩니다.</li>
</ul>
</div>
      	<br><br>
      	<!-- 결제정보입력 테이블 -->
<table style="width: 70%">
<tr>
	<td class="cardInfo" align="left" colspan="2">신용(체크)카드번호</td>
</tr>
<tr>
	<td colspan="2">
	<input type="text" name="card1"> 
	<input type="text" name="card2">
	<input type="text" name="card3"> 
	<input type="text" name="card4"> 
	</td>
</tr>
<tr>
	<td align="left" width="50%" class="cardInfo">유효기간 </td>
	<td align="left" width="50%" class="cardInfo">카드 비밀번호 </td>
</tr>
<tr>
	<td><input type="text" name="validDate"></td>
	<td><input type="text" name="cardPwd"></td>
</tr>
<tr>
	<td class="cardInfo" align="left" colspan="2">생년월일(주민번호 앞 6자리)</td>
</tr>
<tr>
	<td colspan="2"><input type="text" name="birth"></td>
</tr>
</table>
<br><br>
<div style="width: 70%" align="left">
	<p class="strongGray" align="left">결제 예약시 유의사항</p>
	<ul class="liteGray" >
	<li>결제실행일에 결제자 귀책사유(카드 재발급, 한도초과, 이용정지 등)으로 인하여 결제가 실패할 수 있으니 결제수단이 유효한지 다시 한번 확인하세요.</li>
	<li>1차 결제 실패시 실패일로부터 3 영업일동안 결제를 실행합니다.결제 실패 알림을 받으면 카드사와  카드결제 불가 사유 (한도초과 또는 카드 재발급 등)를 확인하여 주세요</li>
	<li>결제  예약 이후 결제할 카드를 변경하려면 마이페이지>나의 후원내역에서 카드정보를 변경해주세요</li>
	<li>1차 결제 실패 이후 3영업일동안 재 결제를 시도합니다. 결제가 정상적으로 실행되지 않으면 펀딩 참여가 취소됩니다.</li>
	</ul>
</div>
<br><br>
 <a href="order.do"><img src="image/detail/orderBtn.jpg" width="120px"></a>

<input type="hidden" name="projectSeq" value="${projectdto.seq }">
</form>
     </div>
   </div>
   <!-- /.row -->

</div>  

<script type="text/javascript">
function plusVal(seqNum) {
   	var opCount = Number(document.getElementById(seqNum).value);
	if(opCount==99){
		alert("구매가능한 수량보다 많습니다.");
	}else{
		opCount+=1;
     	document.getElementById(seqNum).value =opCount;
     	//글씨변환
	}
}
     	
function minusVal(seqNum) {
	var opCount = Number(document.getElementById(seqNum).value);
	if(opCount==1){
		alert("0개이하는 선택하실수  없습니다. ");
		document.getElementById(seqNum).value ="1";
	}else{
		opCount-=1;
       		document.getElementById(seqNum).value =opCount;
	}
}	
</script>