<%@ page import="donzo.thefun.model.pageparam.participantParam"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<fmt:requestEncoding value="UTF-8"/>

<style type="text/css">
#line_header {
  background: #fff;
  color: #00000090;
  /* padding: 20px; */
}

#line_header p {
  font-family: 'Allura';
  color: #00000090;
  font-size: 40px;
}


.parti_header {
  background-color: #8152f0;
  color: white;
  font-size: 1.5em;
  padding: 0.3rem;
  text-align: center;
} */

/* ////// */
.table_img {
  border-radius: 50%;
  height: 60px;
  width: 60px;
} 

.table-users {
  border: 1px solid #8152f0;
  border-radius: 10px;
  box-shadow: 3px 3px 0 rgba(0, 0, 0, 0.1);
  max-width: calc(100% - 2em);
  margin: 1em auto;
  overflow: hidden;
  width: 100%;
} 
.column1 {
  width: 50px;
  padding-left: 40px;
  text-align: center;
}

.column2 {
  width: 100px;
  text-align: center;
}

.column3 {
  width: 150px;
}

.column4 {
  width: 150px;
  text-align: center;
}

.column5 {
  width: 100px;
  text-align: center;
}

.column6 {
  width: 200px;
  text-align: center;  
}

</style>
<link rel="stylesheet" href="CSS/common/table.css">
<style type="text/css">
/* 테이블 화면 작아졌을 때 */
@media screen and (max-width: 900px) {
  .funTable tbody tr td:nth-child(1):before {
	content: "";
  }
  .funTable tbody tr td:nth-child(2):before {
    content: "후원자";
  }
  .funTable tbody tr td:nth-child(3):before {
    content: "후원일자";
  }
  .funTable tbody tr td:nth-child(4):before {
    content: "후원금액";
  }
  .funTable tbody tr td:nth-child(5):before {
    content: "상태";
  }
  .funTable tbody tr td:nth-child(6):before {
    content: "옵션";
  }
  .funTable td.c {
    text-align: left;
  }
}
</style>

	<header class="line_header">
	<div class="container text-center">
	<!-- <h1 class="head_title">SEARCH</h1> -->
	<p>참여 현황</p>
	<div align="right"  style="margin-top: 5%;margin-bottom: 3%;">
	<a href="#none" class="btn btn-primary" style="float: left;">선택한 항목 배송처리</a>
	<a href="projectDetail.do?seq=${projectseq}" class="btn btn-primary">프로젝트 보러가기</a>
	</div>
	</div>
	</header>
								
<div class="container">
	<div class="table-users">
		<div class="parti_header">
			<span style="float: left;margin-right: 2%;margin-left: 2%;"><input type="checkbox" id="check_All"> 전체 선택 |</span>프로젝트 참여내역 (${totalRecordCount }건)
		</div>
	
	<div align="center">
		<div class="container-table100">
		    
			<table class="funTable" style="border-radius: 0;width: 100%">
			<c:if test="${empty participant_List }">
		   		<thead>
					<tr class="table100-head"><th class="column2 c">아직 프로젝트에 참여한 회원이 없습니다</th></tr>
				</thead>
			</c:if>		
		    <c:if test="${!empty participant_List }">
			    <thead>
					<tr class="table100-head" style="font-weight:bold;background: #343a40">			
						<th class="column1 c"></th>		
						<th class="column2 c">후원자</th>
						<th class="column3 c">후원일자</th>
						<th class="column4 c">후원금액(원)</th>
						<th class="column5 c">상태</th>
						<c:if test="${fundtype.equals(ProjectDto.TYPE_REWARD)}"><!-- 리워드일 때 -->
							<th class="column6 c">옵션</th>
						</c:if>
					</tr>
				</thead>
				<tbody class="funTbody">
			 	<c:forEach items="${participant_List }" var="part_Dto" varStatus="i">
					<tr>
						<td class="column1 c"><input type="checkbox" name="check_row"></td>
						<td class="column2 c">${part_Dto.id}</td><!-- 후원자 -->
						<td class="column3 c">${part_Dto.getDateKr()}</td><!-- 후원일자 -->
						<td class="column4 c"><fmt:formatNumber value="${part_Dto.price * part_Dto.count}" type="number"/> 원 (<fmt:formatNumber value="${part_Dto.price}" type="number"/>원 * ${part_Dto.count } 건)</td>
						<c:choose>
						<c:when test="${fundtype.equals(ProjectDto.TYPE_REWARD)}"><!-- 리워드일 때 -->
							<td class="column5 c">
							<c:choose>
					   			<c:when test="${part_Dto.status eq BuyDto.FINISH}">배송 완료</c:when>
						   		<c:otherwise>배송 전</c:otherwise>
					 		</c:choose>
							</td>
							<td  class="column6 c" style="text-align: left;">${part_Dto.otitle} : <span><c:forTokens items="${part_Dto.ocontent}" delims="/" var="content"><li style="padding: 0;">${content} (${part_Dto.count} 건)</li></c:forTokens></span></td><!-- 상품 / 옵션 정보 -->
						</c:when>
						<c:otherwise>
							<td class="column5 c">
							<c:choose>
					   			<c:when test="${part_Dto.status eq BuyDto.FINISH}">결제 완료</c:when>
						   		<c:otherwise>결제 전</c:otherwise>
					 		</c:choose>
					 		</td>
				 		</c:otherwise>
				 		</c:choose>
					</tr>
				</c:forEach>
				</tbody>
		     </c:if>
		   </table>
		</div>
	</div>
	<!-- 페이징 처리 -->     
	<div id="pagination__wrapper" align="center"><!-- flush 는 갱신의 의미 -->
	  <jsp:include page="/WEB-INF/views/common/paging.jsp" flush="false">
	  	  <jsp:param value="${pageNumber }" name="pageNumber"/>
	  	  <jsp:param value="${pageCountPerScreen }" name="pageCountPerScreen"/>
	  	  <jsp:param value="${recordCountPerPage }" name="recordCountPerPage"/>
	  	  <jsp:param value="${totalRecordCount }" name="totalRecordCount"/>
	  	  <jsp:param value="${projectseq}" name="projectseq_participant"/>
	  	  <jsp:param value="participant.do" name="actionPath"/>
	  </jsp:include>
	</div>
</div>
</div>
<script>
//전체선택 체크박스 클릭
$(document).ready(function () {
	$("#check_All").click(function(){
		//만약 전체 선택 체크박스가 체크된상태일경우
		if($("#check_All").prop("checked")) {
			//해당화면에 전체 checkbox들을 체크해준다
			$("input[type=checkbox]").prop("checked",true);
			
		}
		// 전체선택 체크박스가 해제된 경우
		else {
			//해당화면에 모든 checkbox들의 체크를해제시킨다.
			$("input[type=checkbox]").prop("checked",false);
		}
	});
	
	
	// 그 줄 선택시 체크박스 되게 하려고.... 잠시 보류
	/*
	$(document).on("click", ".check_tr", function () {
		alert("야    호");
		if($(this).child("input[type=checkbox]").prop("checked")){
			$(this).child("input[type=checkbox]").prop("checked",false);
		}else{
			$(this).child("input[type=checkbox]").prop("checked",true);
		}
	});
	*/
});

</script>