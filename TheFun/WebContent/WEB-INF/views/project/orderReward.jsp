<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:requestEncoding value="utf-8"/> 
<title>The Fun_orderReward</title>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script> <!-- 주소검색 -->
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script> <!-- 결제api -->
<style type="text/css">
.numberCheck{
	padding:5px;
}
.underline { /* 포인트 */
	border-color:#999999; background-color:#FFFFFF; border-style:solid;
    border-top-width:0px; border-bottom-width:1px; border-left-width:0px; border-right-width:0px;
    color:#0000FF;
    text-align: right;
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
	 width: 20%
 }
 
.profile{
  	text-align:left;
  	font-size:large;
	 color: #818181;
	 padding-bottom: 10px;
 }
 
 .disabledInput{	/* input이지만 input이 아닌것 */
 	background: white;
    border: none; 
	outline: none;
	cursor: default;
 }
 
.disabledInput:focus{
	outline: none;
}
 
/* .td1{
	text-align:left;
	padding: 10px;
	width: 50%;
} */
/* .td2{
	text-align:right;
	width: 26%;
} */
/* .td3{
	text-align:right;
	width: 24%;
} */
.Fee{
	background-color:transparent;
	border:none;
	text-align:right;
}

.inputBtn {
  outline: 0;
  background: #8152f0;
  border: 0;
  cursor: pointer;
  padding: 7px;
  font-size: 16px;
  border-radius: 10px;
  box-sizing: border-box;
  color: white; 
}


.main {
  position: relative;
  border-radius: 0;
  /* max-width: 900px; */   
  width: 100%;   
  margin: auto;
  display: inline-block;
  border-top: 1px solid #bcbac1;
  border-bottom: 1px solid #bcbac1;
}
.left {
  width: 100%;
  margin: auto;
  border:none;
 /*  padding-bottom: 0.7rem; */
}
.right {
  /* display: flex; */
  width: 100%;
  margin: auto;
  padding-left: 0;
}
.priceBottom{
	position: relative;
    margin-top: 10px;
    border-top: 2px solid #bcbac1;
    padding-top: 5px;
}


@media screen and (min-width: 55em) {
  .main {
    max-width: 85%;   
    overflow: visible;
  }
  .left {
    width: 65%;
    float: left;
 	border-right: 1px dashed #8152f0;
 	padding-top: 20px;
 	padding-bottom: 20px;
  }
  .right {
    width: 35%;
    float: right;
    padding-left: 20px;
    padding-top: 20px;
 	padding-bottom: 20px;
  }  
  .priceBottom{
	position: absolute;
    bottom: 0;
    right: 0;
    border:none;
   }
}
</style>

<div class="container">
  <div class="my-4" align="center">
    <div align="center" >
    <form action="addOrder.do" id="orderfrm"  method="post" >
    
<!-- 기부일 경우 -->
<c:if test="${projectdtoList[0].isDonation()}">    
    <!-- 메인 -->
      <p class="strongGray">${projectdtoList[0].title } </p>
      <br>
		<p class="strongGray">"기부자님의 소중한 마음으로 놀라운 변화가 일어납니다!"</p>
      	<p class="liteGray" style="size: 3px;">투명한 기부 후기로 그 변화를 소개하고 보답하겠습니다!</p>
      	<!-- <hr width="70%" color="#424242"> -->
      	<table style="width: 85%; margin-bottom: 20px;">
	      	<tr height="50px;">
	      		<td rowspan="2" align="center" width="70%"  style="border-width: 1px 1px 1px 0; border-style: solid; border-color: #8152f0;">
	      			 기부금액  <input class="pupple" type="text" id="amount" style="text-align: right;width: 120px; margin:5px; " placeholder="0">원
	      			 <input type="hidden" name="price"> <!-- 적용 버튼을 누른 뒤의 금액만 전송하도록 하자 -->
	      		</td>
	      		<td class='liteGray' align="center" width="40%" style="border-top: 1px solid #8152f0; background: #8152f02b; color: mediumblue;">
	      			<span style="font-weight: bold;"id="usablePoint">${login.point }</span>&nbsp;포인트 사용 가능
	      		</td>	
	    	</tr>
	    	<tr>
	    		<td class='liteGray' align="center" style="padding-top: 20px;padding-bottom: 20px;border-bottom: 1px solid #8152f0;">포인트 사용
					<input type="text" class="underline liteGray" style="text-align: center;"size="8" id="usepoint" placeholder="0">&nbsp;
					<input type="hidden" name="usepoint" > <!-- 적용 버튼을 누른 뒤의 포인트만 전송하도록 하자 -->
					point
				</td>
	    	</tr>
	    	<tr>
	    		<td colspan="2"><strong style="color: #5c5c5c; size: 5px;" >결제수수료 없이 100% 기부</strong> <br> 
	      		<font class="liteGray" size="2px;">결제하신 금액은 기부시 별도 수수료 없이 <strong style="color: #8152f0">단체로 100% 기부</strong>됩니다.</font></td>
	    	</tr>
			<tr>
				<td colspan="2" style="border-bottom: 1pt dashed #424242;"></td>
			</tr>
			<tr><td colspan="2" align="right" style="padding-top: 10px;"><button type="button" class="fun_btn" id="pointBtn">적용</button></td></tr>
			<tr>
				<td class="pupple" align="left" style="padding-top: 20px;">총 금액</td>
				<td class="pupple" align="right" style="padding-top: 20px;">
					<span id='totalPrice' class='Fee pupple' style='text-align: right;'>0</span>원
				</td>
			</tr>
			<tr>
				<td class="pupple" align="left" style="padding-top: 20px;">포인트 사용</td>
				<td class="pupple" align="right" style="padding-top: 20px;"> 
					<span id='appliedPoint' class='Fee pupple' style='text-align: right;'>0</span>원
				</td>
			</tr>
			<tr>
				<td class="pupple" align="left" style="padding-top: 20px;">결제 금액</td>
				<td class="pupple" align="right" style="padding-top: 20px;">
					<span id='finalPrice' class='Fee pupple' style='text-align: right;'>0</span>원
				</td>
			</tr>
		</table>
	<script type="text/javascript">
	$("#pointBtn").click(function(){
		var usepoint = Number($("#usepoint").val());
		var donAmount = Number($("#amount").val());
		
		if(donAmount < usepoint){
			alert("기부금액보다 많은 포인트를 사용할 수 없습니다.");
			return;
		}else{
			$("#totalPrice").text(addCommas(donAmount));
			$("#appliedPoint").text(addCommas(usepoint));
			$("#finalPrice").text(addCommas(donAmount-usepoint));
			$("span[name='totalPrice']").text(addCommas(donAmount-usepoint));
			
			$("input:hidden[name='price']").val(donAmount);
			$("input:hidden[name='usepoint']").val(usepoint);
		}
		if(donAmount > 0 && donAmount == usepoint){
			$("div[dGroup='divPayInfo']").hide();
			$("#noPaymentMessage").show();
		}else{
			$("div[dGroup='divPayInfo']").show();
			$("#noPaymentMessage").hide();
		}
		
	})
	</script>
	<div id="noPaymentMessage" style="display: none; width: 85%; background: #eae2fc; border-top: 1px solid #4500e8; border-bottom: 1px solid #4500e8; padding: 10px; margin-bottom: 10px;">
		<span>포인트만으로 기부하는 경우 결제정보를 수집하지 않습니다.</span>
	</div>
	<div dGroup="divPayInfo" style="padding-top: 20px;  border-top: 1px solid #bcbac1; width: 85%;">
	<table style="width: 100%; padding: 20px;" class="td1">
     	<tr>
     		<td style="padding-bottom: 30px;"><img src="image/detail/info.jpg" width="120px;"></td>
     	</tr>
     	<tr>
     		<td class="profiletitle">이름</td>     	
     		<td class="profile">
     			<input type="text" name="name" class="liteGray disabledInput" readonly value="${login.nickname}" id="deliName" >
     			<input type="hidden" name="opSeq" value="0">
				<input type="hidden" name="opCount" value="1">
				<input type="hidden"  id="projectseq" name="projectseq" value="${projectdtoList[0].seq }">
     		</td>
     	</tr>
     	<tr>
     		<td class="profiletitle">이메일</td>     	
     		<td class="profile"><input class="liteGray disabledInput" readonly  value="${login.email}" ></td>
     	</tr>
     	<tr>
     		<td class="profiletitle">휴대폰 번호</td>     	
     		<td class="profile">
     			<input name="phone" id="deliPhone" class="liteGray" value="${login.phone}" maxlength="13" style="padding: 5px;" onkeyup="autoHyphen(this)" placeholder="등록된 번호가 없습니다." >
     		</td>
    	</tr>
		
     </table>
     </div>
</c:if> <!-- 기부 끝 -->

<!-- 리워드일 경우 -->
<c:if test="${projectdtoList[0].isReward()}">
	<!-- 옵션, 프로젝트 테이블 -->
   	<table style="width: 85%" >
    <c:forEach items="${projectdtoList}" var="projectdto" varStatus="vs"> <!-- 프로젝트foreach시작 -->
    <tr oGroup="tr_${selectOptions[vs.index].seq}"> 
    	<td class="strongGray" colspan="4">
    		<!-- oGroup밖으로 나가면 삭제할 때 안 지워져서 문제 발생 -->
		    <input type="hidden" name="projectseq" id="projectseq${vs.count }" value="${projectdto.seq}"> <!-- 프로젝트시퀀스 hidden -->
		    <input type="hidden" name="opSeq" id="opSeq${vs.count }" value="${selectOptions[vs.index].seq}"> <!-- 옵션 시퀀스 hidden -->
		    <input type="hidden" id="stock_${selectOptions[vs.index].seq}" value="${selectOptions[vs.index].stock-selectOptions[vs.index].buycount }"><!-- 재고(남은수량) -->
	    	<p>
	    		<input type="checkbox" value="${selectOptions[vs.index].seq}" name="checkboxs" id="checkboxs${vs.count }" checked>
				<label for="checkboxs${vs.count}">${projectdto.title}</label>
				<img class="pnt" src="image/icons/deleteBtn.jpg" width="5%" style="float: right; margin-top: 2px;" onclick="deleteReward(${selectOptions[vs.index].seq})" name="deleteBoxs">
			</p>	<!-- 프로젝트제목 -->
    	</td>
    </tr>
	<tr oGroup="tr_${selectOptions[vs.index].seq}"> <!-- 옵션이름, 재고 -->
		<td rowspan="4" align="center" style="width: 10%;border-bottom:1px solid #D8D8D8"><img src="upload/${projectdto.seq}" style="max-width: 200px; max-height: 200px; object-fit:cover;"></td>
		<td class="pupple"align="left" colspan="3">
			<p>${selectOptions[vs.index].title}
				<font size="2px;" color="#656565">
					<!-- -1이 아닐 경우만 재고 출력. -1은 재고 무제한 -->
					<c:if test="${selectOptions[vs.index].stock-selectOptions[vs.index].buycount gt -1}">${selectOptions[vs.index].stock-selectOptions[vs.index].buycount}개 남음)</c:if>
				</font>
			</p>
		</td>
	</tr>
	<tr oGroup="tr_${selectOptions[vs.index].seq}"> <!-- 옵션 내용 -->
		<td class="liteGray td1" style="padding-left: 0;" colspan="3">
			<ul>		 	 	
	 	 	<c:forEach items="${fn:split(selectOptions[vs.index].content,'/')}" var="item">
				<li class="liteGray">${item}</li>
			</c:forEach>
	 	 	</ul>
		</td>
	</tr>		
	<tr  oGroup="tr_${selectOptions[vs.index].seq}" id="tr2_${selectOptions[vs.index].seq}" style='border-bottom:1px solid #D8D8D8; border-top:1px solid #D8D8D8; border-bottom: 1px solid #D8D8D8; background: #a78af236; color: #5e2bd8; font-weight: 600;'>
		<td class="liteGray" align="center">
			개당 가격
		</td>
		<td class="liteGray" align="center" style="width:25%">
			수량
		</td>
		<td class="liteGray" style="text-align: right; padding-right: 10px; width:25%" >
			합계 금액
		</td>
	</tr>
	<tr  oGroup="tr_${selectOptions[vs.index].seq}" id="tr2_${selectOptions[vs.index].seq}" style='border-bottom:1px solid #D8D8D8; border-top:1px solid #D8D8D8; height: 45px;'>
		<td class="liteGray" align="center">
			<fmt:formatNumber value="${selectOptions[vs.index].price}" type="number" />원
		</td>
		<td align="center">
			<img src="image/detail/plusBtn.jpg" style="cursor:pointer;" onclick="plusVal(${selectOptions[vs.index].seq})"> 	<!-- +  버튼 -->
			<input type="text" id="${selectOptions[vs.index].seq}" name="opCount" value="${optionCount[vs.index]}" size="3" readonly="readonly" style="text-align: center;">
			<img src="image/detail/minusBtn.jpg" style="cursor:pointer;" onclick="minusVal(${selectOptions[vs.index].seq})"><!-- -  버튼 -->
		</td>
		<td class="liteGray" style="text-align: right;">
			<span class="Fee liteGray" name='priceName' id="price_${selectOptions[vs.index].seq}">
				<fmt:formatNumber value="${selectOptions[vs.index].price*optionCount[vs.index]}" type="number" />
			</span> 원<br>
			<input type="hidden" name="opPrice" id="realPrice_${selectOptions[vs.index].seq}" value="${selectOptions[vs.index].price}">
		</td>
	</tr>
		

	</c:forEach>
	<tr>
		<td class="pupple"align="left" style="padding-top: 20px;">
			총 결제 금액
		</td>
		<td class="pupple"align="right" colspan="3" style="padding-top: 20px;">
			<span id='finalPrice' class='Fee pupple' style='text-align: right;'></span>원			 
		</td>
	</tr>
	<tr>
		<td colspan="4"> <hr color="#424242"> </td>
	</tr>
	</table>
	<br>
	<br><br>

<div class="main">
<div class="right" > 
	<!-- 사용자정보 -->
	<table style="padding: 20px; width: 100%" class="td1" >
	<tr>
		<td style="padding-bottom: 30px;"><img src="image/detail/info.jpg" width="120px" ></td>
	</tr>
	<tr>
		<td class="profiletitle"><b>이름</b></td>
	<!-- </tr>
	<tr> -->
		<td class="profile"><input class="liteGray disabledInput" value="${login.nickname}" readonly="readonly"style="padding: 5px;"></td>
	</tr>
	<tr>
		<td class="profiletitle"><b>이메일</b></td>
	<!-- </tr>
	<tr> -->
		<td class="profile"><input  class="liteGray disabledInput" value="${login.email}" readonly="readonly"style="padding: 5px;"></td>
	</tr>
	<tr>
		<td class="profiletitle"><b>휴대폰 번호</b></td>
	<!-- </tr>
	<tr> -->
		<td class="profile">
			<input class="liteGray disabledInput" value="${login.phone}" readonly="readonly"style="padding: 5px;" placeholder="등록된 번호가 없습니다.">
		</td>
	</tr>
	</table>
	<br><br>		
	</div>
	<div class="left">	
		<!-- 배송지정보 -->
     	<table style="padding: 20px; width:100%" class="td1">
     	<tr>
     		<td style="padding-bottom: 30px;"><img src="image/detail/deli.jpg" width="120px;"></td>
     	<!-- </tr>
     	<tr> -->
	     	<td style="text-align: center; padding-bottom: 30px;">
	     	<label for="infoDeli" class="pnt"><input type="radio" name="delivery" id="infoDeli" value="infoDeli" checked="checked">기본정보 배송지</label>&nbsp;
	     	<label for="newDeli" class="pnt"><input  type="radio" name="delivery" id="newDeli" value="newDeli">새로운 배송지</label> 
	     	</td>
     	</tr>
     	<tr>
     		<td class="profiletitle">이름</td>
     	<!-- </tr>
     	<tr> -->
     		<td class="profile"><input class="liteGray" value="${login.nickname}"style="padding: 5px;" id="deliName"></td>
     	</tr>
     	<tr>
     		<td class="profiletitle">휴대폰 번호</td>
     	<!-- </tr>
     	<tr> -->
     		<td class="profile">
     	    	<input name="phone" id="deliPhone" class="liteGray" maxlength="13" placeholder="등록된 번호가 없습니다." value="${login.phone}" style="padding: 5px;"onkeyup="autoHyphen(this)">
     		</td>
     	</tr>
     	<tr>
     		<td class="profiletitle">주소</td>
     	<!-- </tr>
     	<tr> -->
     		<td class="profile">
     		<input class="liteGray" type="text" style="width:100px; padding:5px" id="postcode" name="postcode" placeholder="우편번호" readonly="readonly" value="${login.postcode }"> 
     		<input type="button" onclick="sample4_execDaumPostcode()" class="inputBtn" value="우편번호 찾기">
     		</td>
     	</tr>
     	<tr>
     		<td></td>
     		<td class="profile">
			<input class="liteGray" type="text" style="width:95%; padding:5px" id="roadAddress" name="roadaddress" placeholder="도로명주소" readonly="readonly" value="${login.roadaddress }">
			
     		</td>
     	</tr>
     	<tr>
     		<td></td>
     		<td class="profile">
     			<input class="liteGray" type="text" style="width:95%; padding:5px" id="detailAddress" name="detailaddress" maxlength="30" onkeyup="detailAddressCheck()" placeholder="상세주소" value="${login.detailaddress}">
     		</td>
     	</tr>
     	</table>
</div>
</div>
     	<br><br>
     	<div style="width: 85%" align="left">
     	<p class="strongGray" style="">THE FUN 리워드 펀딩은 결제예약 시스템을 이용합니다.</p>
     	<ul class="liteGray" >
			<li>프로젝트의 성공여부에 따라 결제가 실행되며 자동결제시 결제대기금100원을 지불받습니다.</li>
			<li>결제정보 입력 후 결제예약을 완료하시면, 결제대기중으로 예약상태로 등록됩니다.</li>
			<li>프로젝트 종료일(<fmt:parseDate value="${projectdtoList[0].edate }" pattern="yyyy-MM-dd HH:mm:ss" var="edate" />
			<fmt:formatDate value="${edate }" pattern="yyyy.MM.dd"/>) 의 다음 영업일에 펀딩 성공여부에 따라 결제실행/결제취소가 진행됩니다.</li>
			<li>포인트를 사용하여 총 결제금액이 0원인 경우에는 결제정보를 입력할 필요 없이 결제완료로 처리됩니다.</li>
		</ul>
		</div>
</c:if>

<div dGroup="divPayInfo">
<div class="main" style="margin-top:15px">
 	<div class="left" style="text-align:left">
 		<div>
	 	<span style="padding-top:20px; padding-bottom:20px;">
			<img src="image/detail/payinfo.jpg" width="120px;" style="text-align: left;">
		</span>
		<span style="margin-left:30px">
			<label for="handPay" class="pnt"><input type="radio" name="purchase" id="handPay" value="hand"checked="checked">일반결제</label> 
			<label for="autoPay" class="pnt"><input type="radio" name="purchase" id="autoPay" value="auto">간편결제</label>
  		</span>
  		</div>
  		<div id="autopayDiv" style="text-align: center; margin: 20px;"> <!-- 자동결제선택시 show --></div>
  
  		<div id="handpayDiv"><!-- 개인결제 선택시 show 결제정보 입력 테이블 -->
  
			<table style="width:95%"> 
			<tr >
				<td class="cardInfo" align="left" colspan="2">신용(체크)카드번호</td>
			</tr>
			<tr>
				<td colspan="2">
				<input class="numberCheck" style="width:24%" type="text" name="card1" id="card1"> 
				<input  class="numberCheck" style="width:24%" type="password" name="card2" id="card2">
				<input class="numberCheck"  style="width:24%" type="password" name="card3" id="card3"> 
				<input  class="numberCheck" style="width:24%" type="text" name="card4" id="card4"> 
				<input type="hidden" name="cardNumber" id="cardNumber">
				</td>
			</tr>
			<tr>
				<td align="left" width="50%" class="cardInfo" style="padding-top: 10px;">유효기간 </td>
				<td align="right" width="50%" class="cardInfo" style="padding-top: 10px; padding-right: 2%;">카드 비밀번호 </td>
			</tr>
			<tr>
				<td>
					<input type="text" class="liteGray numberCheck" id="validDate1" name="validDate1" placeholder="mm" size="3">월
					<input type="text" class="liteGray numberCheck" id="validDate2" name="validDate2" placeholder="yy" size="3">년
				</td>
				<td align="right"><input  type="password" style=" padding-right: 2%;" class="liteGray numberCheck" name="cardPwd" id="cardPwd"></td>
			</tr>
			<tr>
				<td class="cardInfo" align="left" style="padding-top: 10px;">카드사</td>
				<td class="cardInfo" align="right" style="padding-top: 10px; padding-right: 2%;">생년월일(주민번호 앞 6자리)</td>
			</tr>
			<tr>
				<td>
				<select name="bankName" id="bankName" style="padding:5px">
					<option selected="selected">카드사를 선택하여 주십시오</option>
					<option>롯데카드</option>
					<option>비씨카드</option>
					<option>삼성카드</option>
				    <option>신한카드</option>
					<option>씨티카드</option>
					<option>우리카드</option>
					<option>하나카드</option>
				    <option>현대카드</option>
				    <option>KB국민</option>
				    <option>NH농협</option>
				</select>
				</td>
				<td  align="right"><input class="numberCheck" style="padding-right: 2%;" type="text" id="birth"></td>
			</tr>
			</table>
		</div> <!-- /직접결제 -->
	
	</div>
	<div class="right priceBottom" style="text-align: left; ">
		결제 금액<br>
		<span name="totalPrice" style="font-size: 30px; font-weight: bold; color: #8105f0;"></span><span style="font-weight: bold; color: #8105f0;"> 원</span>
	</div>
	</div>
	<br><br>
	<!-- 리워드일경우 -->
	<c:if test="${projectdtoList[0].isReward()}">
		<div style="width: 85%" align="left">
			<p class="strongGray" align="left">결제 예약시 유의사항</p>
			<ul class="liteGray" >
				<li>결제실행일에 결제자 귀책사유(카드 재발급, 한도초과, 이용정지 등)으로 인하여 결제가 실패할 수 있으니 결제수단이 유효한지 다시 한번 확인하세요.</li>
				<li>1차 결제 실패시 실패일로부터 3 영업일동안 결제를 실행합니다.결제 실패 알림을 받으면 카드사와  카드결제 불가 사유 (한도초과 또는 카드 재발급 등)를 확인하여 주세요</li>
				<li>1차 결제 실패 이후 3영업일동안 재 결제를 시도합니다. 결제가 정상적으로 실행되지 않으면 펀딩 참여가 취소됩니다.</li>
			</ul>
		</div>
	</c:if>
	<br><br>
</div><!-- // dGroup="divPayInfo" -->
<input type="hidden" name="fundtype" value="${projectdtoList[0].fundtype }">
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



<!-- 결제하기 최종확인 모달창 -->
<div class="modal fade" id="messageModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel"><b>결제하기</b></h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>     
      <div class="modal-body">
          <div class="form-group">
            <label for="recipient-name" class="col-form-label">이대로 결제하시겠습니까?</label>
          </div>       
      </div>
      <div class="modal-footer">
        <button type="button" class="btn cancel_btn" data-dismiss="modal" id="exit">취소</button>
        <button type="button" class="btn fun_btn" onclick="checkAndResubmitProject()">확인</button>
      </div>
    </div>
  </div>
</div>



<script type="text/javascript">
/* function checkedReward() {
	for (var i = 1; i <= '${fn:length(projectdtoList)}'; i++) {
		if( $("#customCheck"+i).is(":checked") == false){	
			$("#projectSeq"+i).attr("disabled", true);
			$("#amountSelect"+i).attr("disabled", true);
		}
	}
} */
function checkPaymentMethod(){
	if(document.getElementById("card1").value.length<4){
		alert("첫번째 카드번호가 4자리수 이하입니다");
	}else if(document.getElementById("card2").value.length<4){
		alert("두번째 카드번호가 4자리수 이하입니다");
	}else if(document.getElementById("card3").value.length<4){
		alert("세번째 카드번호가 4자리수 이하입니다");
	}else if(document.getElementById("card4").value.length<4){
		alert("네번째 카드번호가 4자리수 이하입니다");
	}else if(document.getElementById("cardPwd").value.length<4){
		alert("카드 비밀번호 4자리를 입력해 주세요");
	}else if(document.getElementById("birth").value.length<6){
		alert("생년월일이 6자리 이하입니다");
	}else if(document.getElementById("validDate1").value>12 || document.getElementById("validDate1").value<1){
		alert("월의 유효기간이 맞지 않습니다");
	}else if(document.getElementById("validDate2").value<=18 || document.getElementById("validDate2").value>50){
		alert("년도 유효기간이 맞지 않습니다");
	}else if(document.getElementById("bankName").value=="은행을 선택하세요"){
		alert("카드사를 선택하여 주십시오");
	}else{
		return true;
	}
	return false;
}

function checkSupporterInfo(){
	if(document.getElementById("deliName").value==null ||document.getElementById("deliName").value==""){
		alert("이름을 입력하여주십시오");
	}else if(document.getElementById("deliPhone").value==null ||document.getElementById("deliPhone").value==""){
		alert("연락처를 입력하여 주십시오");
	}else{
		return true;
	}
	return false;
}
function checkDeliveryInfo(){
	if(document.getElementById("postcode").value==null || document.getElementById("postcode").value==""){
		alert("우편번호를 입력하여 주십시오");
	}else if(document.getElementById("roadAddress").value==""){
		alert("주소를 입력하여 주십시오");
	}else if(document.getElementById("detailAddress").value==""){
		alert("상세주소를 입력하여 주십시오");
	}else{
		return true;
	}
	return false;
}
function goAddOrder( is ) {	//최종결제 유효성검사
	var iswhat = is;
	
	//라디오버튼확인 
	if($('input:radio[id=handPay]').is(':checked')){	//수동결제
		//카드번호 설정
		var cardNum = document.getElementById("card1").value+document.getElementById("card2").value+document.getElementById("card3").value+document.getElementById("card4").value;
		document.getElementById("cardNumber").value=cardNum;
		
		//결제 유효성검사
		if(iswhat=="1" ){	//기부일때
			if(Number(removeCommas($("#totalPrice").text()))<100){ // 100원 이하 기부하려고 하는 경우
				alert("최소 기부금액은 100원 입니다.");
				return;
			}else if(Number(removeCommas($("#finalPrice").text()))==0){ // 포인트를 사용해서 실제 결제 금액이 0원인 경우 결제 체크 안 함
				// 모달창에서 확인/취소 누르는것으로 바꿈
				$("#messageModal").modal('show');
				//$("#orderfrm").attr("action","addOrder.do").submit();
			}else{ //  실 결제 금액이 있는 경우
				// 먼저 사용자의 기본 정보 확인
				if(checkSupporterInfo() == false){
					return;
				}
				if(checkPaymentMethod()){
					console.log("checked");
					// 모달창에서 확인/취소 누르는것으로 바꿈
					$("#messageModal").modal('show');
					//$("#orderfrm").attr("action","addOrder.do").submit();
				}
			}
		}else{ // 리워드일 때
			// 먼저 사용자의 기본 정보 확인
			if(checkSupporterInfo() == false){
				return;
			}
			if(checkDeliveryInfo() && checkPaymentMethod()){	
				// 모달창에서 확인/취소 누르는것으로 바꿈
				$("#messageModal").modal('show');
				//$("#orderfrm").attr("action","addOrder.do").submit();
			}
		}		
	}else if($('input:radio[id=autoPay]').is(':checked')){	//간편결제
		
		//bankName cardNumber 셋팅
		document.getElementById("bankName").value="간편결제";
		document.getElementById("cardNumber").value="****************";
		
		if(iswhat=="2"){	//리워드일때
			// 먼저 사용자의 기본 정보 확인
			if(checkSupporterInfo() == false){
				return;
			}
			if(checkDeliveryInfo()){						
				requestPay();
			}
		}else if(iswhat=="1"){	//기부일때
			requestPay();
		} //기부일때 끝
	}//간편결제 끝	
}

function checkAndResubmitProject(){
	// form 실행! 컨트롤러로~
	$("#orderfrm").attr("action","addOrder.do").submit();
}

function changePrice(count,seqNum,type){ // 번호, 더하기빼기삭제
	document.getElementById(seqNum).value =count;	
	var realPrice = Number(removeCommas(document.getElementById("realPrice_"+seqNum).value));	//단가
   	var priceField = Number(removeCommas($("#price_"+seqNum).text()));	//현재 찍혀있는 금액
   	var finalP = Number(removeCommas($("#finalPrice").text()));			//총금액 GET
   	
   	var totalPrice = 0;
   	
   	if(type == 'plus'){
   		totalPrice = priceField+realPrice;
   	    $("#finalPrice").text(addCommas(finalP+realPrice));	//총금액 SET
   	   	$("span[name='totalPrice']").text(addCommas(finalP+realPrice));	//총금액 SET
   	}else if(type == 'minus'){
   		totalPrice = priceField-realPrice;
   	   	$("#finalPrice").text(addCommas(finalP-realPrice));	//총금액 SET
   	   	$("span[name='totalPrice']").text(addCommas(finalP-realPrice));	//총금액 SET
   	}   	

   	document.getElementById("price_"+seqNum).innerHTML =addCommas(totalPrice); // 총금액
	//document.getElementById("finalPrice").text(finalP+realPrice);		//총금액 SET
}

	/* 수량선택 에 따른 총금액 밑 개별 금액 변화 ( + ) */
	function plusVal(seqNum) {
	   	var count = Number(document.getElementById(seqNum).value);
	   	var stockCount = document.getElementById("stock_"+seqNum).value;
	   	
	   	if(stockCount<0){	//재고가 무제한이라면
	   		count+=1;
	   		changePrice(count,seqNum,'plus');	   		
	   	}else{		//재고가 무제한이 아니라면 
			if(count==stockCount){
				alert("구매가능한 수량보다 많습니다.");
			}else{
				count+=1;
		   		changePrice(count,seqNum,'plus');
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
	   		changePrice(count,seqNum,'minus');
		}
	}
	
	// 각 리워드의 삭제버튼 클릭시
	function deleteReward(opSeqNum) {
		
		// 옵션의 전체갯수
		var allOptionlen = $("[name=deleteBoxs]").length;
		
		if(allOptionlen<2){	// 옵션이 2개 미만 즉, 하나만 남았다면 
			alert("전체삭제는 불가능합니다.");
		}else{	// 주문가능 수량이 2개 이상 남아있음. 즉, 하나 삭제해도 무방
			/* 총가격 변환 */
			var priceId = "price_"+opSeqNum;	//각 옵션 가격 input의 id화
			var opPrice = parseInt(removeCommas($("#"+priceId).text()));  				//현재적힌가격
			var fiPrice = parseInt(removeCommas($("#finalPrice").text()));		//현재 총액

			$("#finalPrice").text(addCommas(fiPrice-opPrice));			//총액재설정
			$("span[name='totalPrice']").text(addCommas(fiPrice-opPrice));			//총액재설정
			$("tr[oGroup='tr_"+opSeqNum+"']").remove();	// 해당 row 삭제
		}
	}

	$(document).ready(function (){
		$("#autopayDiv").hide();
		var tPrice=0;

		//  총금액 첫 출력 설정
		$("span[name='priceName']").each(function (i) {
           tPrice += Number(removeCommas($(this).text()));
       	});
		$("#finalPrice").text(addCommas(tPrice) );	
		$("span[name='totalPrice']").text(addCommas(tPrice) );	
		
		
		
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
		//구매 라디오버튼
		$("input:radio[name=purchase]").click(function(){
			var purchase =$(':radio[name="purchase"]:checked').val();
			if(purchase=="auto"){	//자동결제
				$("#autopayDiv ").text("결제예약 버튼을 누르시면 결제가 진행됩니다.");
				$("#autopayDiv ").show();
				$("#handpayDiv").hide();
			}else if (purchase=="hand"){	//수동결제
				$("#handpayDiv").show();
				$("#autopayDiv ").hide();
			}
		});
		//유효성검사 및 포커스이동
		$("#card1").on("keyup",function(){
			$(this).val($(this).val().replace(/[^0-9]/g,""));
			if($(this).val().length>4){
				$(this).val($(this).val().substring(0,4));
			}else if($(this).val().length==4){
				$("#card2").focus();	
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
		$("#birth").on("keyup",function(){	//생년월일 유효성
			$(this).val($(this).val().replace(/[^0-9]/g,""));
			if($(this).val().length>6){
				$(this).val($(this).val().substring(0,6));
			}
		});
		$("#amount").on("keyup",function(){	//숫자만
			$(this).val($(this).val().replace(/[^0-9]/g,""));

		});
		$("#usepoint").on("keyup",function(){	//포인트입력 유효성
			$(this).val($(this).val().replace(/[^0-9]/g,""));
			var havePoint=Number($("#usablePoint").text());	//보유 포인트
			var usepoint = Number($("#usepoint").val());	//입력 포인트
			
			//보유포인트보다 크게 입력할수없음
			if(havePoint<=usepoint){
				$("#usepoint").val(havePoint);
			}
		});
		/* $("#pointBtn").on("click",function(){	//포인트사용버튼
			var usepoint = Number($("#usepoint").val());	//입력 포인트
			$("#finalPrice").val(tPrice-usepoint);
			
		}); */
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
	text = text.replace(/[<(+>]/g, '');
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



/* 결제 api */
 // 사용 가이드 : https://docs.iamport.kr/implementation/payment
 //아이엠포트 식별코드 등 확인하는곳 : https://admin.iamport.kr , ID : fnvlektmf@naver.com, PW : k3216261 
var IMP = window.IMP; // 생략가능
IMP.init('imp13592330'); // 'iamport' 대신 부여받은 "가맹점 식별코드"를 사용


function requestPay() {
	var goodstitle="${projectdtoList[0].title}";
	var usertel="${login.phone}";
	IMP.request_pay({
	    pg : 'html5_inicis', // version 1.1.0부터 지원. PG사명
	    pay_method : 'card',	//결제수단 card==신용카드
	    merchant_uid : 'merchant_' + new Date().getTime(),	//결제된적있는 merchant_uid로는 재결재불가설정
	    name : goodstitle,	//주문명, 복수주문시 projectList[0].title 외 n건 표시예정
	    amount : 100,	//가격
	    buyer_tel : usertel,	//누락시에러발생가능성있음
	    m_redirect_url : 'https://www.naver.com'	//모바일 결제완료시 갈 곳 임시로 네이버
	}, function(rsp) {
	    if ( rsp.success ) {
	        var msg = '결제가 완료되었습니다.';
	        msg += '고유ID : ' + rsp.imp_uid;
	        msg += '상점 거래ID : ' + rsp.merchant_uid;
	        msg += '결제 금액 : ' + rsp.paid_amount;
	        msg += '카드 승인번호 : ' + rsp.apply_num;
		
	        $("#orderfrm").attr("action","addOrder.do").submit();
	        
	    } else {
	        var msg = '결제에 실패하였습니다.';
	        msg += '에러내용 : ' + rsp.error_msg;
	    }
	    alert(msg);
	});


}

//3자리 단위마다 콤마 생성하는 함수
function addCommas(x) {
    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}
//계산을 위해 , 삭제
function removeCommas(x){
 	return x.replace(/,/gi, "");
}
</script>