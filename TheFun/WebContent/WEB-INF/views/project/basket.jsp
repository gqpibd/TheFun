<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:requestEncoding value="utf-8"/>


<body>

<!-- 콘텐츠를 전부 중간맞춤하기 위한 가장 외부의 div -->
<div style="width: 60%; margin: 0 auto;">
	
	<c:forEach items="${myBasket }" var="basket" varStatus="statuss">
	<div class="card">
	  <div class="card-header">
	    ${basket.ptitle }
	  </div>
	  <div class="card-body">
	    <h5 class="card-title">${basket.otitle }</h5>
	    <p class="card-text">${basket.ocontent }</p>
	    <a href="#" class="btn btn-primary">즉시구매</a>
	  </div>
	</div><br>
	</c:forEach>
	
	<div class="card">
	  <div class="card-header">
	    Featured
	  </div>
	  <div class="card-body">
	    <h5 class="card-title">Special title treatment</h5>
	    <p class="card-text">With supporting text below as a natural lead-in to additional content.</p>
	    <a href="#" class="btn btn-primary">Go somewhere</a>
	  </div>
	</div><br>

</div>

</body>
</html>