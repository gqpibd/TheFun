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
          <c:if test="${option.stock-option.buycount > 0}"> <!-- 1개 이상 남았을 때만 주문 가능 -->
          <table>
			<tr>
         	<td class="strongGray">
         	 <p> <input type="checkbox" value="${option.seq }" name="check" onclick="boxCheck(this)">&nbsp;
         	 	<b style="font-size: 20px">${option.price } 원 펀딩합니다</b>  (${option.stock-option.buycount }개 남음)</p>
		 	 <p class="liteGray">&nbsp; ${option.title }</p>
			 <c:forEach items="${option.content}" var="item">
			   <li class="liteGray">${item}</li>
			 </c:forEach> 	
         	</td>
         	</tr>
<!--     <tr>
         	<td class="liteGray">수량 : <input type="text" name="count" size="5px" value="0"> </td>
         </tr> -->
          </table>
          <br>
          </c:if>
          </c:forEach>
          <!-- 테이블 영역 끝 -->
          
          
          <br><br><br>
          <input type="hidden" name="projectSeq" value="${projectdto.seq }">
           <img src="image/detail/next.jpg" width="120px" onclick="goOrder()" style="cursor: pointer">
          </form>
          
 <script type="text/javascript">
 /*
 function boxCheck(e){
     if ( e.checked == true ){
     	alert("선택한 옵션의 seq : "+e.value);
     }else{
     	alert("선택 해제");
     }
 }
 
/*        // 동적으로 추가된 체크박스 체크여부 확인
          $("#optionsDiv").on("click", 'input:checkbox', function() {
        	  $('input:checkbox[name="check"]').each(function() {
                  if(this.checked){//체크 했을 때
                    alert("선택한 옵션의 seq :"+this.value); 
                  }else{//체크 해지 했을 때
                	  
                  }

             });
        	  
          });
       
 */
          
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
         alert("옵션을 한개 이상 선택해주세요.");
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