<%@page import="donzo.thefun.model.ProjectDto"%>
<%@page import="donzo.thefun.model.participantParam"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="UTF-8"/>
<style>
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

/* 테이블 CSS */
.parti_header {
   background-color: #8152f0;
   color: white;
   font-size: 1.5em;
   padding: 1rem;
   text-align: center;
}

.parti_table img {
   border-radius: 50%;
   height: 60px;
   width: 60px;
}

.parti_table tr {
	border-bottom: 1px solid #8152f0;
}


div.table-users {
   /* border: 1px solid #8152f0; */
   /* border-radius: 10px; */
   /* box-shadow: 3px 3px 0 rgba(0,0,0,0.1); */
   max-width: calc(100% - 2em);
   margin: 1em auto;
   /* overflow-y: scroll;
   max-height: 500px; */
   height: 500px;
   width: 90%;
}

table.parti_table {
   width: 100%;
   border:1px solid #8152f0;
   
   table.parti_table td, table.parti_table th { 
      color: #8152f0;
      padding: 10px; 
   }
   
   td {
      text-align: center;
      vertical-align: middle;
      
      &:last-child {
         font-size: 0.95em;
         line-height: 1.4;
         text-align: left;
      }
   }
   
   th { 
      background-color: #8152f0;
      font-weight: 300;
   }
   
   tr {     
      &:nth-child(2n) { background-color: white; }
      &:nth-child(2n+1) { background-color: #8152f0 }
   }
}

@media screen and (max-width: 700px) {   
   table.parti_header, table.parti_header tr, table.parti_header td { display: block; }
   
   table.parti_header td {
      &:first-child {
         position: absolute;
         top: 50%;
         transform: translateY(-50%);
         width: 100px;
      }

      &:not(:first-child) {
         clear: both;
         margin-left: 100px;
         padding: 4px 20px 4px 90px;
         position: relative;
         text-align: left;

         &:before {
            color: #8152f0;
            content: '';
            display: block;
            left: 0;
            position: absolute;
         }
      }

      &:nth-child(2):before { content: 'Name:'; }
      &:nth-child(3):before { content: 'Email:'; }
      &:nth-child(4):before { content: 'Phone:'; }
      &:nth-child(5):before { content: 'Comments:'; }
   }
   
   table.parti_header tr {
      padding: 10px 0;
      position: relative;
      &:first-child { display: none; }
   }
}

@media screen and (max-width: 500px) {
   .parti_header {
      /* background-color: transparent; */
      color: #fff;
      /* font-size: 2em;
      font-weight: 700; */
      padding: 0;
      text-shadow: 2px 2px 0 rgba(0,0,0,0.1);
   }
   
   .parti_header img {
      border: 3px solid;
      border-color: #8152f0;
      height: 100px;
      margin: 0.5rem 0;
      width: 100px;
   }
   
   .parti_header td {
      &:first-child { 
         background-color: #8152f0; 
         border-bottom: 1px solid #8152f0;
         border-radius: 10px 10px 0 0;
         position: relative;   
         top: 0;
         transform: translateY(0);
         width: 100%;
      }
      
      &:not(:first-child) {
         margin: 0;
         padding: 5px 1em;
         width: 100%;
         
         &:before {
            font-size: .8em;
            padding-top: 0.3em;
            position: relative;
         }
      }
      
      &:last-child  { padding-bottom: 1rem !important; }
   }
   
   .parti_header tr {
      background-color: white !important;
      border: 1px solid #8152f0;
      border-radius: 10px;
      box-shadow: 2px 2px 0 rgba(0,0,0,0.1);
      margin: 0.5rem 0;
      padding: 0;
   }
   
   .table-users { 
      /* border: none;  */
      box-shadow: none;
      overflow: visible;
   }
}
</style>

<link rel="stylesheet" href="CSS/common/table.css"><!-- 위치 바뀌면 제대로 안 들음! -->
<style type="text/css">
/* 테이블 화면 작아졌을 때 */
@media screen and (max-width: 992px) {
  .parti_table tbody tr td:nth-child(1):before {
     content: "후원일자";
  }
  .parti_table tbody tr td:nth-child(2):before {
    content: "후원 프로젝트 정보";
  }
  .parti_table tbody tr td:nth-child(3):before {
    content: "후원금액(수량)";
  }
  .parti_table tbody tr td:nth-child(4):before {
    content: "작성자";
  }
  .parti_table tbody tr td:nth-child(5):before {
    content: "상태";
  }
  .parti_table td.c {
    text-align: left;
  }
}
</style>

	<header id="line_header">
	<div class="container text-center">
	<!-- <h1 class="head_title">SEARCH</h1> -->
	<p>참여 현황</p>
	<div align="right"  style="margin-top: 5%;margin-bottom: 3%;">
	<a href="projectDetail.do?seq=${projectseq_participant }" class="btn btn-primary">프로젝트 보러가기</a>
	</div>
	</div>
	</header>
	
	<%-- 
	<!-- 참가현황 페이징시 project seq 필요 -->
	<input type="hidden" name="projectseq_participant" value="${projectseq_participant }" id="_projectseq_participant">
	<!-- 참가현황 페이징에 펀드 타입 필요 -->
	<input type="hidden" name="fundtype" value="${fundtype }" id="_fundtype">
	 --%>
								
<div class="container">
	<div class="table-users">
		<!-- 테이블 헤더 부분 -->
	   <%-- <div class="parti_header">
	   " <c:set var="str" value="${participant_Dto.title }"/>
		<c:set var="len" value="${fn:length(str)}"/>
		<c:choose>
		<c:when test="${len ge 30}"><strong>&nbsp;${fn:substring(str,0,30) } ...</strong></c:when>
		<c:otherwise><strong>&nbsp;${str }</strong></c:otherwise>
		</c:choose>
	 " 프로젝트 참여 목록</div> --%>
	 
	 	<div class="parti_header">프로젝트 참여 목록 : 총 ${totalRecordCount } 건</div>
	   
	   <table class="parti_table" style="text-align: center;vertical-align: middle;border:1px solid #8152f0;" cellpadding="5px">
	    <c:if test="${empty participant_List }">
		<tr>
			<th class="column2 c">참여 내역이 없습니다</th>
		</tr>	
		</c:if>
		
	    <c:if test="${!empty participant_List }">
		      <tr>
		      	 <th class="column1"><input type="checkbox" id="check_All"></th>
		         <th class="column2">참여자</th>
		         <th class="column3">참여일자</th>
		         <th class="column4">상품 / 옵션 정보</th>
		         <th class="column5">총 결제금액</th>
		         <th class="column6">상태</th>
		      </tr>
		
		      <!-- list jsp:include로 보내려면 이렇게 -->
			  <c:set var="part_List" value="${participant_List }" scope="request"/>
			  
		      <jsp:include page="/WEB-INF/views/project/project_participant_list.jsp" flush="false">
		      	<jsp:param value="${part_List }" name="part_List"/>
		      </jsp:include>
		      
		     	<!-- <tr>
		      	 <th class="column1"><input type="checkbox" id="check_All"></th>
		         <th class="column2">참여자 ID</th>
		         <th class="column3">후원일자</th>
		         <th class="column4">총 후원금액</th>
		         <th class="column5">상태<th>
		      </tr> -->
		
		      <!-- list jsp:include로 보내려면 이렇게 -->
			  <%-- <c:set var="part_List" value="${participant_List }" scope="request"/>
			  
		      <jsp:include page="/WEB-INF/views/project/project_participant_list.jsp" flush="false">
		      	<jsp:param value="${part_List }" name="part_List"/>
		      </jsp:include> --%>
		      
	     </c:if>
	     
	
	   </table>
	   
	   <!-- 페이징 처리 -->     
	  <div id="pagination__wrapper" align="center" style="margin-bottom: 10%;"><!-- flush 는 갱신의 의미 -->
	  	  <jsp:include page="/WEB-INF/views/common/paging.jsp" flush="false">
	  	  
	  	  	  <jsp:param value="${pageNumber }" name="pageNumber"/>
	  	  	  <jsp:param value="${pageCountPerScreen }" name="pageCountPerScreen"/>
	  	  	  <jsp:param value="${recordCountPerPage }" name="recordCountPerPage"/>
	  	  	  <jsp:param value="${totalRecordCount }" name="totalRecordCount"/>
	  	  	  
	  	  	  <jsp:param value="${projectseq_participant }" name="projectseq_participant"/>
	  	  	  <jsp:param value="${fundtype }" name="fundtype"/>
	  	  	  
	  	  	  <jsp:param value="participant.do" name="actionPath"/>
	  	  </jsp:include>
	  </div>
		  
	</div>
	
	
	</div>
<!-- </div> -->
<!-- </div> -->

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

check_tr
</script>

