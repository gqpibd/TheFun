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
				   <a href="main.do" class="btn btn-outline-danger">상품 보러가기</a>
				</div>
			</div><br>
		</c:when>
		<c:otherwise>
		<form action="goOrderFromBasket.do" method="post" id="updateForm">
			<c:forEach items="${myBasket }" var="basket" varStatus="status">
			<c:if test="${basket.isOngoing() or basket.isPreparing()}">	<!-- 정상 진행중이거나 준비중인 프로젝트의 경우에만 출력해라 -->
				<input type="hidden" name="id" value="${login.id }">
				<input type="hidden" name="projectSeq" value="${basket.projectseq }">
				<input type="hidden" id="originPrice${status.count }" value="${basket.price }">	<!-- 상품 당 개당가를 저장해줄 변수 -->
			<div class="card">
			  <div class="card-header">
				  	<div class="custom-control custom-checkbox">
					  	<input type="checkbox" class="custom-control-input"  value="${basket.optionseq }" 
					  		id="customCheck${status.count }" checked="checked" name="optionSeq" onclick="changePrice()">	<!-- 상품별 체크박스 -->
					  	<label class="custom-control-label" for="customCheck${status.count }">${basket.ptitle }</label>	<!-- 리워드 제목 -->
			  			<img alt="삭제버튼이미지" src="./image/icons/deleteBtn.jpg" width="3%" align="right" 
			  				onclick="deleteBasket(${basket.seq})" onmouseover="this.style.cursor='pointer'">
			  		</div>
			  </div>
			  <div class="card-body">
			  	<table>
			  		<colgroup>
			  			<col width="600"><col width="400">
			  		</colgroup>
			  		<tr>
			  			<td width="60%" rowspan="2">
			  				<!-- 이미지 안나올때를 대비한 대체 이미지는 onerror에 넣어줘야 한다. 앞에 this.onerror=null; 이 없으면 무한로딩 오류가 난다고,,, -->
			  				<img onerror="this.onerror=null;this.src='./image/thumbnail/1.jpg'" alt="등록된 이미지가 없습니다" 
			  					src="upload/${basket.seq}" onclick="location.href='projectDetail.do?seq=${basket.seq}'" 
			  					onmouseover="this.style.cursor='pointer'" height="30%" width="80%">
			  			</td>
			  			<td>
			  				<h3 class="card-title">선택 리워드 : ${basket.otitle }</h3>	<!-- 리워드 제목 -->
			  			</td>
			  		</tr>
			  		<tr>
			  			<td>
			  				<span class="card-text">
			  					<!-- 토큰 /으로 잘라서 출력 -->	<!-- 리워드 내용/구성 -->
			  					<c:forTokens items="${basket.ocontent}" delims="/" var="content">
								    <li class="liteGray list-group-item" style="font-size: 12px">${content}</li>
								</c:forTokens>
			  				</span>
			  			</td>
			  		</tr>
			  		<tr>
			  			<td></td>
			  			<td style="text-align: right; vertical-align: bottom;">
			  				<h3>
			  					<!-- 개별 리워드 당 총액 출력. (개당가*선택한 갯수)한 값. -->
			  					<input type="text" id="price${status.count }" value="${basket.price * basket.count } 원" style="background-color:transparent; border: none; text-align: right;"  readonly>
			  				</h3>
			  			</td>
			  		</tr>
			    </table><hr>
			    <select class="custom-select" name="count" id="amountSelect${status.count }" onchange="changeAmount(${status.count })" style="width: 40%">
			    	<!-- 수량 일단 10개까지 선택할 수 있게함 -->	<!-- JSTL을 사용해 특정(내가 담아놓은) select option값(선택한 갯수)을 기본선택되게 함. -->
			    	<c:forEach var="x" begin="1" end="10" step="1">
					    <option value="${x }" <c:if test="${basket.count eq x}">selected</c:if>>${x }</option>
				    </c:forEach>
				 </select>
			 	<div align="right" style="float: right; ">
		    		<a href="#" class="btn btn-outline-danger">즉시구매</a>	<!-- 해당 상품만(전체x) 바로 구매하고 싶을때 -->
		    	</div>
			  </div>
			</div><br>
			</c:if>
			</c:forEach>
			</form>
		</c:otherwise>
	</c:choose>
	
	<hr style="border: solid 2px #FFBF00;">
	
	<!-- 최종결제칸 -->
	<div class="card">
		<div class="card-body">
			<table>
				<colgroup>
			  			<col width="600"><col width="400">
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
			    			<button class="btn btn-outline-warning" id="updateBtn">수정하기</button>
			    			<button class="btn btn-outline-warning" id="finalOrderBtn">주문하기</button>
			    		</div>
					</td>
				</tr>
	    	</table>
		</div>
	</div>
  
  
  
</div>

<script>
// 수량 선택하면 바로바로 가격 바뀌게
function changeAmount(index) {
	//console.log("index = " + index);
	//console.log("값 = " + $("#amountSelect"+index).val());
	//console.log("originPrice = " + $("#originPrice"+index).val());
	
	// 개당가격 바뀌게
	var selectedOption = $("#amountSelect"+index).val();
	var originPrice = $("#originPrice"+index).val();
	var changedPrice = selectedOption*originPrice;
	console.log("changedPrice = " + changedPrice);
	$("#price"+index).val(changedPrice + " 원");
	
	// 총액 바뀌게
	var totalPrice = 0;
	for (var i = 1; i <= '${fn:length(myBasket)}'; i++) {
		if( $("input:checkbox[name='optionSeq']").is(":checked")){	/* 체크된 상품만 총액바뀌게 */
			var eachPrice = $("#price"+i).val().replace(" 원", "");
			console.log(i + "번째 리워드 총액 = " + eachPrice);
			totalPrice += + eachPrice;
		}
	}
	$("#totalPrice").val(totalPrice + " 원");
	
}
// 수정하기 버튼 클릭했을때
$("#updateBtn").click(function () {
	console.log("업데이트!");
	$("#updateForm").attr("action", "updateBasket.do?id=${login.id}").submit();
});
// 주문하기 버튼(최종) 클릭했을때
$("#finalOrderBtn").click(function () {
	console.log("최종 주문!");
	
	var f = $("#updateForm");
	
	// 체크된 옵션의 projcetSeq와 optionSeq 배열 컨트롤러에 같이 보내주기
	if($("input:checkbox[name='optionSeq']:checked").length > 0){
		for (var i = 1; i <= $("input:checkbox[name='optionSeq']:checked").length; i++) {
			console.log("선택한 상품 개수 " + i + "개");
			if( $("#updateForm[name='optionSeq']:checked") ){
				$("#updateFrorm[name='projectSeq']").attr("disabled", true);
				$("#updateFrorm[name='count']").attr("disabled", true);
			}
			/* if(f.elements['optionSeq'][i].checked == false){
				f.elements['projectSeq'][i].disabled = true;
			} */
		}
	}else{
		alert("주문할 상품을 1개 이상 선택해주세요!");
		return false;
	}
	
	$("#updateForm").attr("action", "goOrderFromBasket.do").submit();
});
// 체크박스 클릭했을때
function changePrice() {
	console.log("체크박스 클릭");
	var totalPrice = 0;
	for (var i = 1; i <= '${fn:length(myBasket)}'; i++) {
		if( $("input:checkbox[name='optionSeq']").is(":checked")){	/* 체크된 상품만 총액바뀌게 */
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


