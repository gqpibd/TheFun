<%@ page import="donzo.thefun.model.pageparam.participantParam"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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

	<header id="line_header">
	<div class="container text-center">
	<!-- <h1 class="head_title">SEARCH</h1> -->
	${projectDto.title}
	<p>참여 현황</p>
	<div align="right"  style="margin-top: 5%;margin-bottom: 3%;">
	<c:if test="${projectDto.isReward()}">
		<button onclick="finishFunding()" class="btn btn-primary" style="float: left;">선택한 항목 배송 처리</button>
	</c:if>	
	<c:if test="${projectDto.isReward() eq false}">
		<button onclick="finishFunding()" class="btn btn-primary" style="float: left;">선택한 항목 완료 처리</button>
	</c:if>
	<a href="projectDetail.do?seq=${projectDto.seq}" class="btn btn-primary">프로젝트 보러가기</a>
	</div>
	</div>
	</header>

<!-- container 칸이 좁아보여서 넓힘 -->					
<div class="" style="margin-left: 10%;margin-right: 10%;">
	<div class="table-users">
		<div class="parti_header">
			<span style="float: left;margin-right: 2%;margin-left: 2%;"></span>프로젝트 참여내역 (${totalRecordCount }건)
		</div>
	
   <form id = "finishFunding">
   <input type="hidden" name="projectseq" value="${projectDto.seq}"> <!-- 알람생성을 위해 프로젝트 정보전달 -->
   <input type="hidden" name="isReward" value="${projectDto.isReward()}">
	<div align="center">
		<div class="container-table100">
			<table class="funTable" style="border-radius: 0;width: 100%">
			<c:choose>
			<c:when test="${fn:length(participant_List) == 0}">
		   		<thead>
					<tr class="table100-head"><th class="column2 c">아직 프로젝트에 참여한 회원이 없습니다</th></tr>
				</thead>
			</c:when>		
		    <c:otherwise>
			    <thead>
					<tr class="table100-head" style="font-weight:bold;background: #8152f0">			
						<th class="column1 c"><input type="checkbox" id="check_All"></th>		
						<th class="column2 c">후원자</th>
						<th class="column3 c">후원일자</th>
						<th class="column4 c">후원금액(원)</th>
						<th class="column5 c">상태</th>
						<c:if test="${projectDto.isReward()}"><!-- 리워드일 때 -->
							<th class="column6 c">옵션</th>
						</c:if>
					</tr>
				</thead>
				<tbody class="funTbody">
			 	<c:forEach items="${participant_List }" var="part_Dto" varStatus="i">
					<tr class="check_tr">
						<td class="column1 c">
							<c:if test="${part_Dto.isComplete_success()}">
								<input type="checkbox" name="check_finish" value="${part_Dto.seq}">
							</c:if>
						</td>
						<td class="column2 c">${part_Dto.id}</td><!-- 후원자 -->
						<td class="column3 c">${part_Dto.getDateKr()}</td><!-- 후원일자 -->
						<td class="column4 c"><fmt:formatNumber value="${part_Dto.price * part_Dto.count}" type="number"/>원 (<fmt:formatNumber value="${part_Dto.price}" type="number"/> * ${part_Dto.count })</td>
						<td class="column5 c">${part_Dto.getStatusKr()}</td> <!-- 상태 -->
						<c:if test="${projectDto.isReward()}"><!-- 리워드일 때 -->							
							<td  class="column6 c" style="text-align: left;">${part_Dto.otitle} : <span><c:forTokens items="${part_Dto.ocontent}" delims="/" var="content"><li style="padding: 0;">${content} (${part_Dto.count} 건)</li></c:forTokens></span></td><!-- 상품 / 옵션 정보 -->
						</c:if>							
					</tr>
				</c:forEach>
				</tbody>
		     </c:otherwise>
		     </c:choose>
		   </table>
		</div>
	</div>
   </form>
	<!-- 페이징 처리 -->     
	<div id="pagination__wrapper" align="center"><!-- flush 는 갱신의 의미 -->
	  <jsp:include page="/WEB-INF/views/common/paging.jsp" flush="false">
	  	  <jsp:param value="${pageNumber }" name="pageNumber"/>
	  	  <jsp:param value="${pageCountPerScreen }" name="pageCountPerScreen"/>
	  	  <jsp:param value="${recordCountPerPage }" name="recordCountPerPage"/>
	  	  <jsp:param value="${totalRecordCount }" name="totalRecordCount"/>
	  	  <jsp:param value="${projectDto.seq}" name="projectseq"/>
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
	$(document).on("click", ".check_tr", function () {
		//alert("야    호" + $(this).children().children("input[name='check_finish']").val());
		if($(this).children().children("input[name='check_finish']").prop("checked")){
			$(this).children().children("input[name='check_finish']").prop("checked",false);
		}else{
			$(this).children().children("input[name='check_finish']").prop("checked",true);
		}
	});
	
});
function finishFunding(){
	var len = $("input:checkbox[name='check_finish']:checked").length;
	if(len == 0){
		return;
	}
	
	var formData = $("#finishFunding").serialize(); // 이렇게 하면 폼 데이터를 ajax로 전송 
	$.ajax({
		type : "post",
		url : "finishFunding.do",
		cache : false,
		data : formData,
		success:function(data){	
			var msg = "기부 완료";
			if('${isReward}' == 'true'){
				msg = "배송 완료";
			}
			for(i=0;i<len;i++){
				$("input:checkbox[name='check_finish']:checked").eq(i).css("display","none");
				//console.log($("input:checkbox[name='check_finish']:checked").eq(i).parents().eq(1).children().eq(4));
				$("input:checkbox[name='check_finish']:checked").eq(i).parents().eq(1).children().eq(4).text(msg);
			}
		},
		error:function(req, stu, err){
			alert("통신실패");
		}
	}); 	
}
</script>