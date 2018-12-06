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
		changeTotalPrice();
	}
	
});
</script>



<!-- 콘텐츠를 전부 중간맞춤하기 위한 가장 외부의 div -->
<div style="width: 80%; margin: 0 auto;">
	
	<input type="hidden" name="id" value="${login.id }">
	<!-- 장바구니 리스트 뿌리기 -->
	<c:choose>
		<c:when test="${empty myBasket}">
			<div class="card">
				 <div class="card-header">
				   장바구니에 담긴 물건이 없습니다
				 </div>
				 <div class="card-body">
				   <h5 class="card-title"><strong>ㅠㅠ조금 더 분발해주세요!ㅠㅠ</strong></h5>
				   <a href="main.do" class="btn btn-primary">상품 보러가기</a>
				</div>
			</div><br>
		</c:when>
		<c:otherwise>
		<form action="updateBasket.do" method="post" id="updateForm">
			<c:forEach items="${myBasket }" var="basket" varStatus="status">
				<input type="hidden" name="seq" value="${basket.seq }">
				<input type="hidden" id="originPrice${status.count }" value="${basket.price }">
			<div class="card">
			  <div class="card-header">
				  	<div class="custom-control custom-checkbox">
					  	<input type="checkbox" class="custom-control-input" id="customCheck${status.count }" checked="checked">
					  	<label class="custom-control-label" for="customCheck${status.count }">${basket.ptitle }</label>
			  			<img alt="삭제버튼이미지" src="./image/icons/deleteBtn.jpg" width="3%" align="right" onclick="deleteBasket(${basket.seq})">
			  		</div>
			  </div>
			  <div class="card-body">
			  	<table>
			  		<colgroup>
			  			<col width="600"><col width="400">
			  		</colgroup>
			  		<tr>
			  			<td width="60%" rowspan="2">
			  				<img onerror="this.onerror=null;this.src='./image/thumbnail/1.jpg'" alt="등록된 이미지가 없습니다" src="upload/${basket.seq}">
			  			</td>
			  			<td>
			  				<h6 class="card-title">선택 리워드 : ${basket.otitle }</h6>
			  			</td>
			  		</tr>
			  		<tr>
			  			<td>
			  				<span class="card-text">
			  					<!-- 토큰 /으로 잘라서 출력 -->
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
			  				<input type="text" id="price${status.count }" value="${basket.price * basket.count } 원" style="background-color:transparent; border: none; text-align: right;">
			  				</h3>
			  			</td>
			  		</tr>
			    </table><hr>
			    <select class="custom-select" name="count" id="amountSelect${status.count }" onchange="changeAmount(${status.count })" style="width: 40%">
			    	<!-- 수량 일단 10개까지 선택할 수 있게함 -->	<!-- JSTL을 사용해 특정(내가 담아놓은) select option값을 기본선택되게 함. -->
			    	<c:forEach var="x" begin="1" end="10" step="1">
					    <option value="${x }" <c:if test="${basket.count eq x}">selected</c:if>>${x }</option>
				    </c:forEach>
				 </select>
			 	<div align="right" style="float: right; ">
		    		<a href="#" class="btn btn-primary">즉시구매</a>
		    	</div>
			  </div>
			</div><br>
			</c:forEach>
			</form>
		</c:otherwise>
	</c:choose>
	
	<hr style="border: solid 3px purple;">
	
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
							<input class="display-4" id="totalPrice" type="text" value="0 원" style="background-color:transparent; border: none;">
						</h1>
					</td>
					<td >
						<div align="right"> 
			    			<button class="btn btn-primary" style="background-color: black;" id="updateBtn">수정하기</button>
			    			<a href="#" class="btn btn-primary" style="background-color: black;">주문하기</a>
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
	var selectedOption = $("#amountSelect"+index).val();
	var originPrice = $("#originPrice"+index).val();
	var changedPrice = selectedOption*originPrice;
	console.log("changedPrice = " + changedPrice);
	$("#price"+index).val(changedPrice + " 원");
	
}
function changeTotalPrice() {
	
	var totalPrice = 0;
	
	<c:forEach var="ba" items="${myBasket}" varStatus="status">
	   totalPrice += ${ba.count * ba.price};
	</c:forEach>
	console.log("총액 = " + totalPrice);
	$("#totalPrice").val(totalPrice + " 원");
}

$("#updateBtn").click(function () {
	console.log("업데이트!");
	$("#updateForm").attr("action", "updateBasket.do?id=${login.id}").submit();
});

function deleteBasket(seq) {
	location.href="deleteBasket.do?seq="+seq+"&id=${login.id}";
}
</script>


