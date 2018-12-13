<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%-- <%@taglib  prefix="form" uri="http://www.springframework.org/tags/form" %> --%>
<fmt:requestEncoding value="UTF-8"/>



<script type="text/javascript">
$(document).ready(function () {
	
	// 장바구니 리스트 길이가 0보다 크면(즉, 장바구니 추가된 상품이 하나라도 있을 때)
	if("${fn:length(myBasket)}" > 0){
		console.log("리스트 길이 = ${fn:length(myBasket)}");
		// 총액 계산 및 세팅
		var totalPrice = 0;
		<c:forEach var="ba" items="${myBasket}" varStatus="status">
		   totalPrice += ${ba.count * ba.price};
		</c:forEach>
		console.log("총액 = " + totalPrice);
		$("#totalPrice").val(totalPrice + " 원");
	}
	
});
</script>



<!-- 콘텐츠를 전부 중간맞춤하기 위한 가장 외부의 div -->
<div style="width: 80%; margin: 0 auto;">
	
	<!-- 장바구니 리스트 뿌리기 -->
	<c:choose>
		<c:when test="${empty myBasket}">
			<div class="card">
				 <div class="card-header">
				   장바구니에 담긴 물건이 없습니다
				 </div>
				 <div class="card-body">
				   <h5 class="card-title"><strong>ㅠㅠ조금 더 분발해주세요!ㅠㅠ</strong></h5>
				   	<div align="right">
				   <a href="main.do" class="btn btn-outline-danger">상품 보러가기</a>
				   </div>
				</div>
			</div><br>
		</c:when>
		<c:otherwise>
		<form action="goOrderReward.do" method="post" id="updateForm">
			<c:forEach items="${myBasket }" var="basket" varStatus="status">
			<c:if test="${basket.isOngoing() or basket.isPreparing()}">	<!-- 정상 진행중이거나 준비중인 프로젝트의 경우에만 출력해라 -->
				<input type="hidden" id="seq${status.count }" value="${basket.seq }">
				<input type="hidden" name="projectSeq" id="projectSeq${status.count }" value="${basket.projectseq }">
				<input type="hidden" id="originPrice${status.count }" value="${basket.price }">	<!-- 상품 당 개당가를 저장해줄 변수 -->
			<div class="card" >
				<!-- 상단바 -->
			  <div class="card-header" style="max-height: 45px">
				  	<div class="custom-control custom-checkbox">
					  	<input type="checkbox"  value="${basket.optionseq }" 
					  		id="customCheck${status.count }" checked="checked" name="selectOpSeq" onclick="changePrice()">	<!-- 상품별 체크박스 -->
					  	<label for="customCheck${status.count }">${basket.ptitle }</label>	<!-- 리워드 제목 -->
			  			<img alt="삭제버튼이미지" src="./image/icons/deleteBtn.jpg" width="3%" align="right" style="max-height: 20px; max-width: 20px"
			  				onclick="deleteBasket(${basket.seq})" onmouseover="this.style.cursor='pointer'">
			  		</div>
			  </div>
			  	<!-- 하단 내용 -->
			  <!-- <div class="card-body"> -->
			  	<table class="table table-sm">
			  		<tr>
			  			<td width="40%" rowspan="3">
			  				<!-- 이미지 안나올때를 대비한 대체 이미지는 onerror에 넣어줘야 한다. 앞에 this.onerror=null; 이 없으면 무한로딩 오류가 난다고,,, -->
			  				<img onerror="this.onerror=null;this.src='./image/thumbnail/1.jpg'" alt="등록된 이미지가 없습니다" 
			  					src="upload/${basket.projectseq}" onclick="location.href='projectDetail.do?seq=${basket.seq}'" 
			  					onmouseover="this.style.cursor='pointer'" style="max-height: 120px; max-width: 300px">
			  			</td>
			  			<td width="60%" colspan="2">
			  				<h5 class="card-title">선택 리워드 : ${basket.otitle }</h5>	<!-- 리워드 제목 -->
			  			</td>
			  		</tr>
			  		<tr>
			  			<td colspan="2">
			  				<span class="card-text">
			  					<!-- 토큰 /으로 잘라서 출력 -->	<!-- 리워드 내용/구성 -->
			  					<c:forTokens items="${basket.ocontent}" delims="/" var="content">
								    <li  style="font-size: 12px">${content}</li>
								    <!-- class="liteGray list-group-item" -->
								</c:forTokens>
			  				</span>
			  			</td>
			  		</tr>
			  		<tr>
			  			<td width="40%">
							<!-- 구매수량 선택 -->
							<button type='button' size='2px;' onclick="changeAmountPlus(${status.count})">+</button>
								<input type='text' readOnly='readOnly' value='${basket.count }' size='2' style='text-align:center;' name='optionCount' id="amountSelect${status.count }">
								<input type="hidden" id="stock${status.count }" value="${basket.stock }">
							<button type='button'size='2px;'onclick='changeAmountMinus(${status.count})'>-</button>
						</td>
			  			<td style="text-align: right; vertical-align: bottom;">
			  				<h3>
			  					<!-- 개별 리워드 당 총액 출력. (개당가*선택한 갯수)한 값. -->
			  					<input type="text" id="price${status.count }" value="${basket.price * basket.count } 원" style="background-color:transparent; border: none; text-align: right;"  readonly>
			  				</h3>
			  			</td>
			  		</tr>
			    </table>
			    <%-- <select class="custom-select" name="count" id="amountSelect${status.count }" onchange="changeAmount(${status.count })" style="width: 40%">
			    	<!-- 수량 일단 10개까지 선택할 수 있게함 -->	<!-- JSTL을 사용해 특정(내가 담아놓은) select option값(선택한 갯수)을 기본선택되게 함. -->
			    	<c:forEach var="x" begin="1" end="10" step="1">
					    <option value="${x }" <c:if test="${basket.count eq x}">selected</c:if>>${x }</option>
				    </c:forEach>
				 </select>
			 	<div align="right" style="float: right; ">
		    		<button type="button" onclick="buyNow(${status.count})" class="btn btn-outline-secondary">즉시구매</button>	<!-- 해당 상품만(전체x) 바로 구매하고 싶을때 -->
		    	</div> --%>
			  <!-- </div> -->
			</div><br>
			</c:if>
			</c:forEach>
			</form>
		</c:otherwise>
	</c:choose>
	
	<hr style="border: solid 2px #3A01DF;">
	
	<!-- 최종결제칸 -->
	<div class="card">
		<div class="card-body">
			<table>
				<colgroup>
			  			<col width="700"><col width="700">
			  	</colgroup>
				<tr>
					<th>
						<p class="h3">결제 예정 금액</p>
					</th>
				</tr>
				<tr>
					<td>
						<h1>
							<!-- input 필드에 바깥 줄 없앰 -->
							<input class="display-4" id="totalPrice" type="text" value="0 원" style="background-color:transparent; border: none;"  readonly>
						</h1>
					</td>
					<td>
						<div align="right">
			    			<button type="button" class="btn btn-outline-secondary" id="finalOrderBtn">주문하기</button>
			    		</div>
					</td>
				</tr>
	    	</table>
		</div>
	</div>
  
  
  
</div>

<script>
// [1] 수량선택 + 증가버튼 눌렀을 때
function changeAmountPlus( index ) {
	console.log("변화 index = " + index);
	// 기존수량에 +1
	var selectedAmount = Number($("#amountSelect"+index).val())+Number(1);
	console.log("선택수량 = " + selectedAmount);
	var stock = Number($("#stock"+index).val());
	console.log("재고 = " + stock);
	if(stock < 0){	// 재고 무제한(리워드 옵션 재고 무제한일시 0으로 잘못 넣었었는데 -1로 바꿈.)
		setPlusAmount(index);
		return false;
	}else {	// 재고 제한이 있음
		
		if(stock >= selectedAmount){	// 재고 충분
			setPlusAmount(index);
		}else{	// 재고 모자름
			alert("재고가 모자랍니다");
			return false;
		}
	}
	
}
// [1]-1. 증가된 수량으로 세팅해주는 함수 + ajax로 새 수량값 DB에 저장
function setPlusAmount(index) {
	// 기존수량에 +1
	var selectedAmount = Number($("#amountSelect"+index).val())+Number(1);
	// 증가한 수량으로 세팅
	$("#amountSelect"+index).val(selectedAmount);
	
	// 해당 리워드 seq값
	var seq = $("#seq"+index).val();
	
	// DB값 바꿔주기
	$.ajax({
		type: "POST",
		url: 'updateBasket.do',
		data : 'seq='+seq+"&optionCount="+selectedAmount,
		success: function(data) {
			//console.log("받은 데이터 = " + data);
		},
		error: function () {
			console.log("수량변동 사항을 DB에 저장하는데 실패했습니다");
		}
	});
	
	// 개당가격 바뀌게
	var originPrice = $("#originPrice"+index).val();
	console.log("원가 = " + originPrice);
	var changedPrice = selectedAmount*originPrice;
	console.log("원가*수량 = " + changedPrice);
	$("#price"+index).val(changedPrice + " 원");
	
	// 총액 바뀌게
	changePrice();
}

// [2] 수량선택 - 감소버튼 눌렀을 때
function changeAmountMinus( index ) {
	console.log("변화 index = " + index);
	// 기존수량에 -1
	var selectedAmount = Number($("#amountSelect"+index).val())-Number(1);
	if(selectedAmount==0){
		alert("수량은 최소 1개 이상을 선택해야 합니다");
		return false;
	}
	// 감소한 수량으로 세팅
	$("#amountSelect"+index).val(selectedAmount);
	
	// 해당 리워드 seq값
	var seq = $("#seq"+index).val();
	
	// DB값 바꿔주기
	$.ajax({
		type: "POST",
		url: 'updateBasket.do',
		data : 'seq='+seq+"&count="+selectedAmount,
		success: function(data) {
			//console.log("받은 데이터 = " + data);
		},
		error: function () {
			console.log("수량변동 사항을 DB에 저장하는데 실패했습니다");
		}
	});
	
	// 개당가격 바뀌게
	var originPrice = $("#originPrice"+index).val();
	console.log("원가 = " + originPrice);
	var changedPrice = selectedAmount*originPrice;
	console.log("원가*수량 = " + changedPrice);
	$("#price"+index).val(changedPrice + " 원");
	
	// 총액 바뀌게
	changePrice();
}

// 주문하기 버튼 클릭했을때
$("#finalOrderBtn").click(function () {
	console.log("최종 주문!");
	
	var f = $("#updateForm");
	
	// 체크된 옵션의 projcetSeq와 optionSeq 배열 컨트롤러에 같이 보내주기
	if($("input:checkbox[name='selectOpSeq']:checked").length > 0){
		for (var i = 1; i <= '${fn:length(myBasket)}'; i++) {
			if( $("#customCheck"+i).is(":checked") == false){	/* 체크 해제된 리워드의 input값은 모두 disabled 설정 */
				$("#projectSeq"+i).attr("disabled", true);
				$("#amountSelect"+i).attr("disabled", true);
			}
		}
	}else{
		alert("주문할 상품을 1개 이상 선택해주세요!");
		return false;
	}
	
	$("#updateForm").attr("action", "goOrderReward.do").submit();
});
// 체크박스 클릭했을때
function changePrice() {
	console.log("체크박스 클릭");
	var totalPrice = 0;
	for (var i = 1; i <= '${fn:length(myBasket)}'; i++) {
		if( $("#customCheck"+i).is(":checked")){	/* 체크된 상품만 총액바뀌게 */
			var eachPrice = $("#price"+i).val().replace(" 원", "");
			console.log(i + "번째 리워드 총액 = " + eachPrice);
			totalPrice += + eachPrice;
		}
	}
	$("#totalPrice").val(totalPrice + " 원");
}
// 삭제(상단 우측 x 이미지) 클릭했을때
function deleteBasket(seq) {
	location.href="deleteBasket.do?seq="+seq+"&id=${login.id}";
}


</script>


