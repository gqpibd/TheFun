<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:requestEncoding value="utf-8"/>  
    
<title>The Fun_${projectdto.title } 리워드 선택</title>

<!-- Custom styles for this template -->
	<link href="CSS/mainCss/portfolio-item.css" rel="stylesheet">
 <!-- mainCSS 설정 끝 -->
 
<style type="text/css">
 .strongGray{
 font-family: "Nanum Gothic", sans-serif;
  color: #5c5c5c;
  font-weight: bold;
  
 }
 .liteGray{
 font-family: "Nanum Gothic", sans-serif;
	 color: #818181;
 }
.checkOption{
 	border: 1px solid #818181;
}
table{
	width:70%;
	border: 1px solid #818181;
	padding: 20px;
}
td{
	padding: 20px;
}
</style>

 <!-- Page Content -->
    <div class="container">
      <div class="my-4" align="center">
        <div align="center" id="optionsDiv">
          <p class="strongGray" style="font-size: 25px">${projectdto.title }</p><br><br>
          <img src="image/detail/selectReword.jpg" width="120px"> <strong class="strongGray">펀딩해주시는 금액에 따라 감사의 의미로 리워드를 제공 해 드립니다.</strong>
          <br><br>
          
          <!-- 테이블 영역 -->
          <form action="goOrderReward.do" method="post" id="goOrderFrm">
          <c:forEach items="${optionList}" var="option"> 
          <table>
			<tr>
         	<td class="strongGray">        	 	
         	 	<c:if test="${option.stock == option.buycount}">
					<p class="pupple"> <input type="checkbox" disabled="disabled">
					<b style="font-size: 20px">${option.price } 원 펀딩합니다</b>
					<font style="background-color:#ebe2ff ">&nbsp;매진되었습니다&nbsp;&nbsp;</font></p>
				</c:if>
				<c:if test="${option.stock != option.buycount}">
				 <p> <input type="checkbox" value="${option.seq }" name="check" onclick="boxCheck(this)">&nbsp;
         	 	<b style="font-size: 20px">${option.price } 원 펀딩합니다</b>
         	 	<c:if test="${option.stock==0}">
				     	<b>(제한수량 없음)</b>
			    </c:if>
			    <c:if test="${option.stock>0}">
				    <b>(${option.stock-option.buycount }개 남음)</b>
			    </c:if>
         	 	</p>
				</c:if>
         	
		 	 <p class="liteGray">&nbsp; ${option.title }</p>
			 <c:forEach items="${option.content}" var="item">
			   <li class="liteGray">${item}</li>
			 </c:forEach> 	
         	</td>
         	</tr>
          </table>
          <br>
          </c:forEach>
          <!-- 테이블 영역 끝 -->
          
          
          <br><br><br>
          <input type="hidden" name="projectSeq" value="${projectdto.seq }">
           <img src="image/detail/next.jpg" width="120px" onclick="goOrder()" style="cursor: pointer">	<!-- order페이지로 이동하는 버튼 -->
          </form>
          
 <script type="text/javascript">
          
 function goOrder() {

  //체크박스 하나라도 체크안한게 있는지 확인 
     var isChecked = false;
     var checkArr = document.getElementsByName("check");
     for(var i=0;i<checkArr.length;i++){
         if(checkArr[i].checked == true) {
       	  isChecked = true;
             break;
         }
     }
     if(!isChecked){
         alert("최소 1개 이상의 리워드를 선택해주세요.");
         return false;
     }else{
    	 
   	  $("#goOrderFrm").attr("action","goOrderReward.do").submit();
     }
}
        
</script>
        </div>
      </div>
      <!-- /.row -->
    </div>
    <!-- /.container 메인컨테이너 끝-->