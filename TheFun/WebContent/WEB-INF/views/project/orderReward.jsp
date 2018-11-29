<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:requestEncoding value="utf-8"/> 
<title>The Fun_orderReward</title>
<style type="text/css">
body{
	font-family: "Nanum Gothic", sans-serif;
}
.pnt { 
	cursor: pointer; 
}
 .pupple{
 	color:#8152f0;
 	font-weight: bold;
 	font-size:large;
 }
 .strongGray{
  color: #5c5c5c;
  font-weight: bold;
  font-size: x-large;
  
 }
  .cardInfo{
  color: #5c5c5c;
  font-weight: bold;
  
 }
 .liteGray{
	 color: #818181;
 }
  .profiletitle{
  text-align:left;
  font-size:large;
	 color: #5c5c5c;
	 padding-bottom: 10px;
 }
 
.profile{
  	text-align:left;
  	font-size:large;
	 color: #818181;
	 padding-bottom: 10px;
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
    <form action="addOrder.do" name="frm">
    <!-- 메인 -->
      <p class="strongGray">${projectdto.title } </p>
      <br>
      <!-- 옵션테이블 -->
      <table style="width: 70%" >
      <c:forEach items="${selectOptions }" var="options" varStatus="status">
		
		<tr id="tr_${options.seq}">
			<td class="pupple"align="left" colspan="3">
				<p><input type="checkbox" value="${options.seq}" name="opSeq" id="checkbox_${status.count }"> 
					${options.title} <font size="2px;" color="#656565">(${options.stock-options.buycount }개 남음)</font></p>
					<input type="hidden" id="stock_${options.seq}" value="${options.stock-options.buycount }">
			</td>
		</tr>
		<tr id="tr2_${options.seq}">
			<td class="liteGray td1">
			<ul>
			 <c:forEach items="${options.content}" var="item">
		  		<li class="liteGray">${item}</li>
		 	 </c:forEach>
		 	 </ul>
		</td>
		<td class="td2 liteGray">
			수량 : <input type="text" id="${options.seq}" name="opCount" value="1" size="3" readonly="readonly">개 &nbsp;
			<img src="image/detail/plusBtn.jpg" onclick="plusVal(${options.seq})"> 	<!-- +  버튼 -->
			<img src="image/detail/minusBtn.jpg" onclick="minusVal(${options.seq})"><!-- -  버튼 -->
		</td>
		<td class="liteGray td3">
			<input type="text" readonly="readonly" value="${options.price}" name="priceName" class="Fee liteGray" size="10" id="price_${options.seq}">원<br>
			<input type="hidden" id="realPrice_${options.seq}" value="${options.price}">
		</td>
		</tr>
	</c:forEach>
	<tr>
		<td align="right" style="padding-top: 20px;" colspan="3">
			<img class="pnt" src="image/detail/deleteBtn1.jpg" id="deleteBtn" width="120px;">
		</td>
	</tr>
	<tr>
	<td colspan="3">
		<hr>
	</td>
	</tr>
	<tr>
		<td class="pupple"align="left" >
			총 결제 금액
		</td>
		<td></td>
		<td class="pupple"align="right" >
			<input type="text" readonly="readonly" value="" class="Fee pupple" size="10" id="finalPrice">원 
		</td>
	</tr>
	</table>
	<br>
	<hr width="70%">
	<br><br>
	
	
     <!-- 사용자정보 -->
     	<table style="width: 70%; padding: 20px;" class="td1">
     	<tr>
     		<td style="padding-bottom: 30px;"><img src="image/detail/info.jpg" width="120px;"></td>
     	</tr>
     	<tr>
     		<td class="profiletitle"><b>이름</b></td>
     	</tr>
     	<tr>
     		<td class="profile"><input class="liteGray" size="50px;"value="${login.nickname}" readonly="readonly"style="padding: 5px;"></td>
     	</tr>
     	<tr>
     		<td class="profiletitle"><b>이메일</b></td>
     	</tr>
     	<tr>
     		<td class="profile"><input  class="liteGray" size="50px;"value="${login.email}" readonly="readonly"style="padding: 5px;"></td>
     	</tr>
     	<tr>
     		<td class="profiletitle"><b>휴대폰 번호</b></td>
     	</tr>
     	<tr>
     		<td class="profile">
     		<c:if test="${empty login.phone}">
     			<input size="50px;"  class="liteGray" value="등록된 고객정보가 없습니다." readonly="readonly"style="padding: 5px;">
     		</c:if>
     		<c:if test="${login.phone}">
     			<input size="50px;" class="liteGray" value="${login.phone}" readonly="readonly"style="padding: 5px;">
     		</c:if>
     		</td>
     	</tr>
     	</table>
     	
     	
		<br><br>
		<!-- 배송지정보 -->
     	<table style="width: 70%; padding: 20px;" class="td1">
     	<tr>
     		<td style="padding-bottom: 30px;"><img src="image/detail/deli.jpg" width="120px;"></td>
     	</tr>
     	<tr>
     		<td class="profiletitle">이름</td>
     	</tr>
     	<tr>
     		<td class="profile"><input  class="liteGray" size="50px;"value="" readonly="readonly"style="padding: 5px;"></td>
     	</tr>
     	<tr>
     		<td class="profiletitle">휴대폰 번호</td>
     	</tr>
     	<tr>
     		<td class="profile"><input  class="liteGray" size="50px;"value="" readonly="readonly"style="padding: 5px;"></td>
     	</tr>
     	<tr>
     		<td class="profiletitle">주소</td>
     	</tr>
     	<tr>
     		<td class="profile"><input  class="liteGray" size="50px;"value="" readonly="readonly"style="padding: 5px;"></td>
     	</tr>
     	</table>
     	
     	<br><br>
     	<div style="width: 70%" align="left">
     	<p class="strongGray" style="">더펀 리워드 펀딩은 결제예약 시스템을 이용합니다.</p>
     	<ul class="liteGray" >
			<li>쇼핑하기처럼 바로 결제되지 않습니다. 프로젝트의 성공여부에 따라 결제가 실행됩니다.</li>
			<li>결제정보 입력 후 결제예약을 완료하시면, 결제대기중으로 예약상태로 등록됩니다.</li>
			<li>프로젝트 종료일(<fmt:parseDate value="${projectdto.edate }" pattern="yyyy-MM-dd HH:mm:ss" var="edate" />
			<fmt:formatDate value="${edate }" pattern="yyyy.MM.dd"/>) 의 다음 영업일에 펀딩 성공여부에 따라 결제실행/결제취소가 진행됩니다.</li>
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
<input type="hidden" name="projectSeq" value="${projectdto.seq }">
<input type="hidden" name="loginId" value="${login.id }">
<input type="image" src="image/detail/orderBtn.jpg" name="Submit" value="Submit" width="120px;">  <!-- 결제 예약하기 버튼 -->

</form>
     </div>
   </div>
   <!-- /.row -->

</div>  

<script type="text/javascript">

	//수량선택 +
	function plusVal(seqNum) {
	   	var opCount = Number(document.getElementById(seqNum).value);
	   	var stockCount = document.getElementById("stock_"+seqNum).value;
	   	
	   	if(stockCount<0){	//재고가 무제한이라면
	   		
	   		opCount+=1;
	     	document.getElementById(seqNum).value =opCount;
	       	//가격변환
	       	var realPrice = Number(document.getElementById("realPrice_"+seqNum).value);
	       	var priceField =Number(document.getElementById("price_"+seqNum).value);
	       	var totalPrice = priceField+realPrice;
	       	document.getElementById("price_"+seqNum).value =totalPrice;
	       	
	       	var finalP = document.getElementById("finalPrice").value;			//총금액 GET
	    	document.getElementById("finalPrice").value =finalP+realPrice;		//총금액 SET
	   		
	   	}else{		//재고가 무제한이 아니라면
	 
			if(opCount==stockCount){
				alert("구매가능한 수량보다 많습니다.");
			}else{
				opCount+=1;
		     	document.getElementById(seqNum).value =opCount;
		       	//가격변환
		       	var realPrice = Number(document.getElementById("realPrice_"+seqNum).value);
		       	var priceField =Number(document.getElementById("price_"+seqNum).value);
		       	var totalPrice = priceField+realPrice;
		       	document.getElementById("price_"+seqNum).value =totalPrice;
		       	
		       	var finalP = Number(document.getElementById("finalPrice").value);			//총금액 GET
		    	document.getElementById("finalPrice").value =finalP+realPrice;		//총금액 SET
			}
	   	}
	}
	
	//수량선택 -
	function minusVal(seqNum) {
		var opCount = Number(document.getElementById(seqNum).value);
		
		if(opCount==1){
			document.getElementById(seqNum).value ="1";
		}else{
			opCount-=1;
	       	document.getElementById(seqNum).value =opCount;
	       	
	       	//가격변환 
	       	var realPrice = Number(document.getElementById("realPrice_"+seqNum).value);	//진짜가격
	       	var priceField = Number(document.getElementById("price_"+seqNum).value);	//현재가격
	       	var resultPrice = priceField-realPrice;								//셋팅할 가격
	       	document.getElementById("price_"+seqNum).value =resultPrice;		//출력
	       	
	       	var finalP = Number(document.getElementById("finalPrice").value);	//총금액 GET
	    	document.getElementById("finalPrice").value =finalP-realPrice;		//총금액 SET
		}
	}
	
	$(document).ready(function (){
		
		var size = $("input[name='priceName']").length;
		var priceArr = new Array(size);
		var tPrice=0;
		
		//같은 name 밸류 전부 저장 
		$("input[name='priceName']").each(function (i) {
            priceArr[i]=Number($("input[name='priceName']").eq(i).attr("value"));
            tPrice = tPrice+priceArr[i];
       });
		
		//모든 옵션 + .. 하지만 체크박스삭제하면 가격변동없음
		$("#finalPrice").val(tPrice);
		
		//선택한 체크박스 value 추출
		$(document).on("click","#deleteBtn",function (){

			//체크된 갯수
			var arrlen =$("input[name=chekboxs]:checked").length;

			//옵션의 전체갯수
			var allOptionlen = $("input[name=chekboxs]").length;

			if(arrlen==0){
				alert("삭제할 리워드를 선택해주세요");
				
			}else if(arrlen==allOptionlen){
				alert("전체삭제는 불가능합니다. 다시선택해 주십시오");
				
			}else{
				//선택한 체크박스 정보를 담을 배열
				var opSeqs = new Array(arrlen);
				var i=0;
				
			 	//배열에 옵션시퀀스 입력
				$("input[name=chekboxs]:checked").each(function() {
					var test = $(this).val();		
					opSeqs[i]="tr_"+test;
					$("#"+opSeqs[i]).remove();		
					opSeqs[i+1]="tr2_"+test;
					$("#"+opSeqs[i+1]).remove();				
					i+=2;
				}); 
			}
	
		});	//onclick 끝
		
	});
	
</script>