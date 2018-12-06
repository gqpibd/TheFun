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
			<c:forEach items="${myBasket }" var="basket" varStatus="status">
			<div class="card">
			  <div class="card-header">
				  	<div class="custom-control custom-checkbox">
					  	<input type="checkbox" class="custom-control-input" id="customCheck${status.count }" checked="checked">
					  	<label class="custom-control-label" for="customCheck${status.count }">${basket.ptitle }</label>
			  			<img alt="#삭제버튼이미지" src="./image/icons/deleteBtn.jpg" width="3%" align="right" onclick="deleteBasket.do?seq=${basket.seq}">	<!-- 각 리워드의 삭제버튼을 누르면 바로 삭제. -->
			  		</div>
			  </div>
			  <div class="card-body">
			  	<table>
			  		<colgroup>
			  			<col width="600"><col width="400">
			  		</colgroup>
			  		<tr>
			  			<td width="60%" rowspan="2">
			  				<img alt="#플젝대표이미지" src="./image/thumbnail/1.jpg">
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
			  				<h5><strong id="price${status.count }">${basket.price }</strong><strong> 원</strong></h5>
			  			</td>
			  		</tr>
			    </table><hr>
			    <select class="custom-select" id="amountSelect${status.count }" style="width: 40%">
			    	<!-- 수량 일단 10개까지 선택할 수 있게함 -->	<!-- JSTL을 사용해 특정(내가 담아놓은) select option값을 기본선택되게 함. -->
			    	<c:forEach var="x" begin="1" end="10" step="1">
					    <option value="${x }" <c:if test="${basket.count eq x}">selected</c:if> 
					    	onclick="changeEachPrice(${x }, ${status.count }, ${basket.price })">${x }</option>
				    </c:forEach>
				 </select>
			 	<div align="right" style="float: right; ">
		    		<a href="#" class="btn btn-primary">즉시구매</a>
		    	</div>
			  </div>
			</div><br>
			</c:forEach>
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
						<h1 class="display-4" id="finalPrice">0</h1><h1> 원</h1>
					</td>
					<td rowspan="2">
						<div align="right" >
			    			<a href="#" class="btn btn-primary" style="background-color: black;" id="updateBasket.do">수정하기</a>
			    		</div>
						<div align="right" >
			    			<a href="#" class="btn btn-primary" style="background-color: black;">주문하기</a>
			    		</div>
					</td>
				</tr>
	    	</table>
		</div>
	</div>
  
  
  
</div>

<script>
function changedFinalPrice() {
	var originFinalPrice = $("#finalPrice").val();
	for (var i = 1; i <= '${fn:length(myBasket)'; i++) {
		var eachPrice = $("#price"+i).val();
		originFinalPrice += eachPrice;
	}
	$("#finalPrice").val(originFinalPrice);
};

function changeEachPrice( selectAmount, priceIndex, originPrice ) {
	var changedPrice = selectAmount * originPrice;
	$("#price"+priceIndex).val(changedPrice);
	changedFinalPrice();
	
};
/* function deleteBasket( seq ) {
	// AJAX로 선택한 장바구니 목록 삭제? ==> 그럼 리스트도 다시 업뎃이 안되나..? 안된다 ㅠㅠ 그냥 컨트롤러로 바로 갔다가 새로고침하게 만들어주자.
	$.ajax({
		data : "seq="+seq,
		type : "POST",
		url : "deleteBasket.do",
		success : function (data) {
			console.log("받은 데이터 = " + data);
			if(data == 1){
				console.log("삭제 성공!");
			}else{
				console.log("삭제 실패!");
			}
		}
	});
} */
</script>

