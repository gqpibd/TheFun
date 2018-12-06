<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%-- <%@taglib  prefix="form" uri="http://www.springframework.org/tags/form" %> --%>
<fmt:requestEncoding value="UTF-8"/>

<body>

<!-- 콘텐츠를 전부 중간맞춤하기 위한 가장 외부의 div -->
<div style="width: 60%; margin: 0 auto;">
	
	<c:choose>
		<c:when test="${empty myBasket}">
			<div class="card">
				 <div class="card-header">
				   장바구니에 담긴 물건이 없습니다
				 </div>
				 <div class="card-body">
				   <h5 class="card-title"><strong>ㅠㅠ조금 더 분발해주세요!ㅠㅠ</strong></h5>
				   <a href="#" class="btn btn-primary">상품 보러가기</a>
				</div>
			</div><br>
		</c:when>
		<c:otherwise>
			<c:forEach items="${myBasket }" var="basket" varStatus="status">
			<div class="card">
			  <div class="card-header">
			  	<input type="checkbox" class="custom-control-input" id="customCheck${status.count }">
			  	<label class="custom-control-label" for="customCheck${status.count }">${basket.ptitle }</label>
			  </div>
			  <div class="card-body">
			  	<table>
			  		<tr>
			  			<td width="50%">
			  				<img alt="#" src="./image/thumbnail/1.jpg">
			  			</td>
			  			<td>
			  				<h5 class="card-title">선택 : ${basket.otitle }</h5>
			  			</td>
			  		</tr>
			  		<tr>
			  			<td></td>
			  			<td>
			  				<p class="card-text">꾸러미 : ${basket.ocontent }</p>
			  			</td>
			  		</tr>
			  		<tr>
			  			<td></td>
			  			<td>
			  				<h5 class="card-title"><strong>${basket.price } 원</strong></h5>
			  			</td>
			  		</tr>
			    </table>
			    <select class="custom-select" id="inputGroupSelect01">
				    <option selected>Choose...</option>
				    <option value="1">One</option>
				    <option value="2">Two</option>
				    <option value="3">Three</option>
				  </select><br><br>
			    <a href="#" class="btn btn-primary">즉시구매</a>
			  </div>
			</div><br>
			</c:forEach>
		</c:otherwise>
	</c:choose>
	
	
	
	
	<!-- 
	<div class="card">
				 <div class="card-header">
				   장바구니에 담긴 물건이 없습니다!
				 </div>
				 <div class="card-body">
				   <h5 class="card-title"><strong>ㅠㅠ조금 더 분발해주세요!ㅠㅠ</strong></h5>
				   <p class="card-text">더 많은 펀드는 더 좋은 세상을 만듭니다. More funding, More Pleasure</p>
				</div>
	</div><br>
	 -->
	
</div>


</body>
</html>