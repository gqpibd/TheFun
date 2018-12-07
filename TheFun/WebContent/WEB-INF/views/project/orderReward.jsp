<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:requestEncoding value="utf-8"/> 
<title>The Fun_orderReward</title>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script> <!-- 주소검색 -->
<style type="text/css">

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
    <form action="addOrder.do" id="orderfrm"  method="post" >
    
    
<!-- 기부일 경우 -->
<c:if test="${projectdtoList[0].isDonation()}">    
    <!-- 메인 -->
      <p class="strongGray">${projectdto.title } </p>
      <br>
		<p class="strongGray">"기부자님의 소중한 마음으로 놀라운 변화가 일어납니다!"</p>
      	<p class="liteGray" style="size: 3px;">투명한 기부 후기로 그 변화를 소개하고 보답하겠습니다!</p>
      	<hr width="70%" color="#818181">
      	<table style="width: 70%">
      	<tr height="50px;">
      		<td align="center" width="70%">
      			 기부금액  <input class="pupple" type="text" id="amount" name="opPrice" size="10" style="text-align: right;" placeholder="0">원 
      		</td>
      		<td width="30%"><strong style="color: #5c5c5c; size: 5px;" >결제수수료 없이 100% 기부</strong> <br> 
      		<font class="liteGray" size="2px;">결제하신 금액은 기부시 별도 수수료 없이 <strong style="color: #8152f0">단체로 100% 기부</strong>됩니다.</font></td>
      	</tr>
      	</table>

				
	<br><br>
	
	<table style="width: 70%; padding: 20px;" class="td1">
     	<tr>
     		<td style="padding-bottom: 30px;"><img src="image/detail/info.jpg" width="120px;"></td>
     	</tr>
     	<tr>
     		<td class="profiletitle">이름</td>
     	</tr>
     	<tr>
     		<td class="profile">
     			<input name="name" class="liteGray" size="50px;"value="${login.nickname}"style="padding: 5px;" id="deliName" onkeyup="nameCheck(this)">
     			<input type="hidden" name="opSeq" value="0">
				<input type="hidden" name="opCount" value="1">
     		</td>
     	</tr>
     	<tr>
     		<td class="profiletitle"><b>이메일</b></td>
     	</tr>
     	<tr>
     		<td class="profile"><input  class="liteGray" size="50px;"value="${login.email}" readonly="readonly"style="padding: 5px;"></td>
     	</tr>
     	<tr>
     		<td class="profiletitle">휴대폰 번호</td>
     	</tr>
     	<tr>
     		<td class="profile">
     		<c:if test="${empty login.phone}">
     			<input name="phone" id="deliPhone" size="50px;" class="liteGray" placeholder="등록된 고객정보가 없습니다. 입력해주세요." style="padding: 5px;" maxlength="13" onkeyup="autoHyphen(this)">
     		</c:if>
     		<c:if test="${not empty login.phone}">
     			<input name="phone" id="deliPhone" size="50px;" class="liteGray" value="${login.phone}" style="padding: 5px;"onkeyup="autoHyphen(this)">
     		</c:if>
     		</td>
     	</tr>
     	</table>
</c:if> <!-- 기부 끝 -->

<!-- 리워드일 경우 -->
<c:if test="${projectdtoList[0].isReward()}">
		
		<!-- 옵션테이블 -->
      <table style="width: 70%" >
      <c:forEach items="${projectdtoList}" var="projectdto" varStatus="vs"> <!-- 프로젝트foreach시작 -->
      <tr>
      	<td class="strongGray" colspan="3"><p>${projectdto.title }</p></td>
      </tr>
      <c:forEach items="${selectOptions }" var="options" varStatus="status"> <!-- 프로젝트seq에따른 옵션 loop -->
       <c:if test="${options.projectseq eq projectdto.seq }">
	  <tr id="tr_${options.seq}">
			<td class="pupple"align="left" colspan="3">
				<input type="hidden" name="opSeq" value="${options.seq}">
				<p><input type="checkbox" value="${options.seq}" name="checkboxs"> 
				${options.title} <font size="2px;" color="#656565">(${options.stock-options.buycount }개 남음)</font>
				</p><input type="hidden" id="stock_${options.seq}" value="${options.stock-options.buycount }">
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
				<img src="image/detail/plusBtn.jpg" onclick="plusVal(${options.seq})"> 	<!-- +  버튼 -->
				<input type="text" id="${options.seq}" name="opCount" value="${optionCount[status.index]}" size="3" readonly="readonly" style="text-align: center;">
				<img src="image/detail/minusBtn.jpg" onclick="minusVal(${options.seq})"><!-- -  버튼 -->
			</td>
			<td class="liteGray td3">
				<input type="text" readonly="readonly" value="${options.price*optionCount[status.index]}" name="priceName" class="Fee liteGray" size="10" id="price_${options.seq}">원<br>
				<input type="hidden" name="opPrice" id="realPrice_${options.seq}" value="${options.price}">
			</td>
		</tr>
		</c:if>
		</c:forEach>
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
     			<input size="50px;"  class="liteGray" value="등록된 고객정보가 없습니다.마이페이지에서 수정해주세요." readonly="readonly"style="padding: 5px;">
     		</c:if>
     		<c:if test="${not empty login.phone}">
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
	     	<td>
	     	<label for="infoDeli" class="pnt"><input type="radio" id="infoDeli" name="delivery" value="infoDeli" checked="checked">기본정보 배송지</label>  
	     	<label for="newDeli" class="pnt"><input name="delivery" id="newDeli" type="radio" value="newDeli">새로운 배송지</label> 
	     	</td>
     	</tr>
     	<tr>
     		<td class="profiletitle">이름</td>
     	</tr>
     	<tr>
     		<td class="profile"><input name="name" class="liteGray" size="50px;"value="${login.nickname}"style="padding: 5px;" id="deliName" onkeyup="nameCheck(this)"></td>
     	</tr>
     	<tr>
     		<td class="profiletitle">휴대폰 번호</td>
     	</tr>
     	<tr>
     		<td class="profile">
     		<c:if test="${empty login.phone}">
     			<input name="phone" id="deliPhone" size="50px;" class="liteGray" placeholder="등록된 고객정보가 없습니다. 입력해주세요." style="padding: 5px;" maxlength="13" onkeyup="autoHyphen(this)">
     		</c:if>
     		<c:if test="${not empty login.phone}">
     			<input name="phone" id="deliPhone" size="50px;" class="liteGray" value="${login.phone}" style="padding: 5px;"onkeyup="autoHyphen(this)">
     		</c:if>
     		</td>
     	</tr>
     	<tr>
     		<td class="profiletitle">주소</td>
     	</tr>
     	<tr>
     		<td class="profile">
     		<input type="button" onclick="sample4_execDaumPostcode()" style="background: #8152f0; cursor: pointer; color: white" value="우편번호 찾기">
     		</td>
     	</tr>
     	<tr>
     		<td>
     		<input type="text" id="postcode" name="postcode" placeholder="우편번호" readonly="readonly" value="${login.postcode }">
			<input type="text" id="roadAddress" name="roadaddress" placeholder="도로명주소" readonly="readonly" value="${login.roadaddress }">
			<input type="text" id="detailAddress" name="detailaddress" maxlength="30" onkeyup="detailAddressCheck()" placeholder="상세주소" value="${login.detailaddress}">
     		</td>
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
</c:if>
	<br><br>
	<!-- 결제정보입력 테이블 -->
	<table style="width: 70%">
	<tr>
	<td style="padding-bottom: 30px;"><img src="image/detail/payinfo.jpg" width="120px;"></td>
	</tr>
	<tr>
		<td class="cardInfo" align="left" colspan="2">신용(체크)카드번호</td>
	</tr>
	<tr>
		<td colspan="2">
		<input class="numberCheck" type="text" name="card1" id="card1"> 
		<input  class="numberCheck" type="password" name="card2" id="card2">
		<input class="numberCheck"  type="password" name="card3" id="card3"> 
		<input  class="numberCheck" type="text" name="card4" id="card4"> 
		<input type="hidden" name="cardNumber" id="cardNumber">
		</td>
	</tr>
	<tr>
		<td align="left" width="50%" class="cardInfo">유효기간 </td>
		<td align="left" width="50%" class="cardInfo">카드 비밀번호 </td>
	</tr>
	<tr>
		<td>
			<input type="text" class="liteGray numberCheck" id="validDate1" name="validDate1" placeholder="mm" size="3">월
			<input type="text" class="liteGray numberCheck" id="validDate2" name="validDate2" placeholder="yy" size="3">년
		</td>
		<td><input type="password" class="liteGray numberCheck" name="cardPwd" id="cardPwd"></td>
	</tr>
	<tr>
		<td class="cardInfo" align="left">사용은행</td>
		<td class="cardInfo" align="left">생년월일(주민번호 앞 6자리)</td>
	</tr>
	<tr>
		<td><input class="liteGray numberCheck" type="text" name="bankName" id="bankName" readonly="readonly"></td>
		<td colspan="2"><input class="numberCheck" type="text" id="birth"></td>
	</tr>
	</table>
	<br><br>
	<!-- 리워드일경우 -->
<c:if test="${projectdtoList[0].isReward()}">
	<div style="width: 70%" align="left">
		<p class="strongGray" align="left">결제 예약시 유의사항</p>
		<ul class="liteGray" >
			<li>결제실행일에 결제자 귀책사유(카드 재발급, 한도초과, 이용정지 등)으로 인하여 결제가 실패할 수 있으니 결제수단이 유효한지 다시 한번 확인하세요.</li>
			<li>1차 결제 실패시 실패일로부터 3 영업일동안 결제를 실행합니다.결제 실패 알림을 받으면 카드사와  카드결제 불가 사유 (한도초과 또는 카드 재발급 등)를 확인하여 주세요</li>
			<li>결제  예약 이후 결제할 카드를 변경하려면 마이페이지>나의 후원내역에서 카드정보를 변경해주세요</li>
			<li>1차 결제 실패 이후 3영업일동안 재 결제를 시도합니다. 결제가 정상적으로 실행되지 않으면 펀딩 참여가 취소됩니다.</li>
		</ul>
	</div>
</c:if>
	<br><br>
<input type="hidden" name="fundtype" value="${projectdto.fundtype }">
<input type="hidden" name="projectseq" value="${projectdto.seq }">
<input type="hidden" name="id" value="${login.id }">

</form>

<!-- 리워드일 경우 -->
<c:if test="${projectdtoList[0].isReward()}">
	<input type="image" class="pnt" src="image/detail/orderBtn.jpg" onclick="goAddOrder(2)" width="120px;">  <!-- 결제 예약하기 버튼 -->
</c:if>

<!-- 기부일 경우 -->
<c:if test="${projectdtoList[0].isDonation()}">
	<input type="image" class="pnt" src="image/detail/donationBtn.jpg" onclick="goAddOrder(1)" width="120px;">  <!-- 기부하기 버튼 -->
</c:if>

     </div>
   </div>
   <!-- /.row -->

</div>  

<script type="text/javascript">


function goAddOrder( is ) {
	var iswhat = is;
	
	if(document.getElementById("card1").value.length<4){
		alert("첫번째 카드번호가 4자리수 이하입니다");
	}else if(document.getElementById("card2").value.length<4){
		alert("두번째 카드번호가 4자리수 이하입니다");
	}else if(document.getElementById("card3").value.length<4){
		alert("세번째 카드번호가 4자리수 이하입니다");
	}else if(document.getElementById("card4").value.length<4){
		alert("네번째 카드번호가 4자리수 이하입니다");
	}else if(document.getElementById("cardPwd").value.length<4){
		alert("카드번호가 4자리 이하입니다");
	}else if(document.getElementById("birth").value.length<6){
		alert("생년월일이 6자리 이하입니다");
	}else if(document.getElementById("validDate1").value>12 || document.getElementById("validDate1").value<1){
		alert("월의 유효기간이 맞지 않습니다");
	}else if(document.getElementById("validDate2").value<=18 || document.getElementById("validDate2").value>50){
		alert("년도 유효기간이 맞지 않습니다");
	}else if(document.getElementById("deliName").value==null ||document.getElementById("deliName").value==""){
		alert("이름을 입력하여주십시오");
	}else if(document.getElementById("deliPhone").value==null ||document.getElementById("deliPhone").value==""){
		alert("연락처를 입력하여 주십시오");
	}else if(iswhat=="2"){
		if(document.getElementById("postcode").value=""){
			alert("우편번호를 입력하여 주십시오");
		}else if(document.getElementById("roadAddress").value==""){
			alert("주소를 입력하여 주십시오");
		}else if(document.getElementById("detailAddress").value==""){
			alert("상세주소를 입력하여 주십시오");
		}else{
			var cardNum = document.getElementById("card1").value+document.getElementById("card2").value+
			  document.getElementById("card3").value+document.getElementById("card4").value;
			document.getElementById("cardNumber").value=cardNum;
			
			$("#orderfrm").attr("action","addOrder.do").submit();
		}
	}else{
		
		var cardNum = document.getElementById("card1").value+document.getElementById("card2").value+
		  document.getElementById("card3").value+document.getElementById("card4").value;
		document.getElementById("cardNumber").value=cardNum;
		
		$("#orderfrm").attr("action","addOrder.do").submit();
	} 
	
}

	/* 수량선택 에 따른 총금액 밑 개별 금액 변화 ( + ) */
	function plusVal(seqNum) {
	   	var count = Number(document.getElementById(seqNum).value);
	   	var stockCount = document.getElementById("stock_"+seqNum).value;
	   	
	   	if(stockCount<0){	//재고가 무제한이라면
	   		
	   		count+=1;
	     	document.getElementById(seqNum).value =count;
	       	//가격변환
	       	var realPrice = Number(document.getElementById("realPrice_"+seqNum).value);
	       	var priceField =Number(document.getElementById("price_"+seqNum).value);
	       	var totalPrice = priceField+realPrice;
	       	document.getElementById("price_"+seqNum).value =totalPrice;
	       	
	       	var finalP = document.getElementById("finalPrice").value;			//총금액 GET
	    	document.getElementById("finalPrice").value =finalP+realPrice;		//총금액 SET
	   		
	   	}else{		//재고가 무제한이 아니라면
	 
			if(count==stockCount){
				alert("구매가능한 수량보다 많습니다.");
			}else{
				count+=1;
		     	document.getElementById(seqNum).value =count;
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
	
	/* 수량선택 에 따른 총금액 밑 개별 금액 변화 ( - ) */
	function minusVal(seqNum) {
		var count = Number(document.getElementById(seqNum).value);
		
		if(count==1){
			document.getElementById(seqNum).value ="1";
		}else{
			count-=1;
	       	document.getElementById(seqNum).value =count;
	       	
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
		
		//  총금액 첫 출력 설정
		$("input[name='priceName']").each(function (i) {
            priceArr[i]=Number($("input[name='priceName']").eq(i).attr("value"));
            tPrice = tPrice+priceArr[i];
       	});
		$("#finalPrice").val(tPrice);
		
		// 삭제버튼 클릭시 테이블 변화 
		$(document).on("click","#deleteBtn",function (){

			//체크된 갯수
			var arrlen =$("input[name=checkboxs]:checked").length;
			
			//옵션의 전체갯수
			var allOptionlen = $("input[name=checkboxs]").length;
			
			if(arrlen==0){
				alert("삭제할 리워드를 선택해주세요");
			}else if(arrlen==allOptionlen){
				alert("전체삭제는 불가능합니다. 다시선택해 주십시오");
			}else{
				//선택한 체크박스 id를 담을 배열
				var ids = new Array(arrlen);
				var i=0;
				
				$("input[name=checkboxs]:checked").each(function() {
					var opSeqNum = $(this).val();	//옵션시퀀스
					
					/* 총가격 변환 */
					var priceId = "price_"+opSeqNum;	//각 옵션 가격 input의 id화
					var opPrice = $("#"+priceId).val();  				//현재적힌가격
					var fiPrice = parseInt($("#finalPrice").val());		//현재 총액

					$("#finalPrice").val(fiPrice-opPrice );			//총액재설정
					
					/* 테이블 remove */
					ids[i]="tr_"+opSeqNum;	//옵션타이틀 
					$("#"+ids[i]).remove();		
					ids[i+1]="tr2_"+opSeqNum;//옵션 컨텐츠
					$("#"+ids[i+1]).remove();
					i+=2;
				}); 
			}
	
		});	//onclick 끝
		
		$("input:radio[name=delivery]").click(function(){
			var deliId =$(':radio[name="delivery"]:checked').val();
			
			if(deliId=="newDeli"){	//새로운 배송지
				$("#deliName").val("");
				$("#deliPhone").val("");
				$("#postcode").val("");
				$("#roadAddress").val("");
				$("#detailAddress").val("");
				
			}else{	//기존배송지
				$("#deliName").val("${login.nickname}");
				$("#deliPhone").val("${login.phone}");
				$("#postcode").val("${login.postcode}");
				$("#roadAddress").val("${login.roadaddress}");
				$("#detailAddress").val("${login.detailaddress}");
			}
		});
		
		//유효성검사
		$("#card1").on("keyup",function(){
			$(this).val($(this).val().replace(/[^0-9]/g,""));
			if($(this).val().length>4){
				$(this).val($(this).val().substring(0,4));
			}else if($(this).val().length==4){
				$("#card2").focus();	
			}
			if($("#card1").val()=="4119"){
		    	$("#bankName").val("하나은행");
		    } else if($("#card1").val()=="4579"){
		    	$("#bankName").val("국민은행");
		    }else if($("#card1").val()=="4364"||$("#card1").val()=="3562"||$("#card1").val()=="4499"){
		    	$("#bankName").val("신한은행");
		    }else if($("#card1").val()=="4214"||$("#card1").val()=="4061"||$("#card1").val()=="5389"||$("#card1").val()=="5387"){
		    	$("#bankName").val("우리은행");
		    }else if($("#card1").val()=="4404" ){
		    	$("#bankName").val("씨티은행");
		    } 
		});
		$("#card2").on("keyup",function(){
			$("#card2").val($("#card2").val().replace(/[^0-9]/g,""));
			if($(this).val().length>4){
				$(this).val($(this).val().substring(0,4));
			}else if($(this).val().length==4){
				$("#card3").focus();
			}
		});
		$("#card3").on("keyup",function(){
			$(this).val($(this).val().replace(/[^0-9]/g,""));
			if($(this).val().length>4){
				$(this).val($(this).val().substring(0,4));
			}else if($(this).val().length==4){
				$("#card4").focus();
			}
		});
		$("#card4").on("keyup",function(){
			$(this).val($(this).val().replace(/[^0-9]/g,""));
			if($(this).val().length>4){
				$(this).val($(this).val().substring(0,4));
			}else if($(this).val().length==4){
				$("#validDate1").focus();
			}
		});
		$("#validDate1").on("keyup",function(){
			$(this).val($(this).val().replace(/[^0-9]/g,""));
			if($(this).val().length>2){
				$(this).val($(this).val().substring(0,2));
			}else if($(this).val().length==2){
				$("#validDate2").focus();
			}
		});
		$("#validDate2").on("keyup",function(){
			$(this).val($(this).val().replace(/[^0-9]/g,""));
			if($(this).val().length>2){
				$(this).val($(this).val().substring(0,2));
			}else if($(this).val().length==2){
				$("#cardPwd").focus();
			}
		});
		$("#cardPwd").on("keyup",function(){
			$(this).val($(this).val().replace(/[^0-9]/g,""));
			if($(this).val().length>4){
				$(this).val($(this).val().substring(0,4));
			}else if($(this).val().length==4){
				$("#birth").focus();
			}
		});
		$("#birth").on("keyup",function(){
			$(this).val($(this).val().replace(/[^0-9]/g,""));
			if($(this).val().length>6){
				$(this).val($(this).val().substring(0,6));
			}
		});
		$("#amount").on("keyup",function(){
			$(this).val($(this).val().replace(/[^0-9]/g,""));

		});
		
		
		
	});
	
</script>


<script type="text/javascript">

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
	
	/* 상세 주소 */
	function detailAddressCheck() {
		console.log("detailAddressCheck");
		var text = $("#detailAddress").val();
		//var regExp = /[\{\}\[\]\/?.,;:|\)*~`!^\-_+<>@\#$%&\\\=\(\'\"]/gi;
		text = text.replace(/[<(+>]/g, '');
		//console.log(text);
		$("#detailAddress").val(text);	
	}
	

function autoHypenPhone(str){ // 휴대폰 번호 자동 하이픈(-)
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

//기부 숫자에 자동으로 콤마
function getNumber(obj){
	
  var num01;
  var num02;
  num01 = obj.value;
  num02 = num01.replace(rgx1,"");
  num01 = setComma(num02);
  obj.value =  num01;

}

function setComma(inNum){
  
  var outNum;
  outNum = inNum; 
  while (rgx2.test(outNum)) {
       outNum = outNum.replace(rgx2, '$1' + ',' + '$2');
   }
  return outNum;

}
</script>