<%@page import="donzo.thefun.model.ProjectDto"%>
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
/* $baseColor: #8152f0;
$borderRadius: 10px;
$imageBig: 100px;
$imageSmall: 60px;
$padding: 10px; */

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
   overflow-y: scroll;
   max-height: 500px;
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
      border: none; 
      box-shadow: none;
      overflow: visible;
   }
}
</style>

	<header id="line_header">
	<div class="container text-center">
	<!-- <h1 class="head_title">SEARCH</h1> -->
	<p>참여 현황</p>
	<div align="right"  style="margin-top: 5%;margin-bottom: 3%;">
	<a href="projectDetail.do?seq=${participant_Dto.seq }" class="btn btn-primary">프로젝트 보러가기</a>
	</div>
	</div>
	</header>
	
<div class="container">
<%-- <div class="card" >
	 <div class="card-header">
	 <span onclick="location.href='projectDetail.do?seq=${seq }'"><strong>${participant_Dto.title} 프로젝트</strong></span>
	 입금받을 계좌 번호 : ${participant_Dto.bank }
	 </div>
	 <div class="card-body" style="overflow-y: scroll;height: 500px;">
	   <h5 class="card-title"><!-- 기능하자 승재야 --></h5>
	   <!-- 내용 -->
	   
    <table class="type07" style="width: 100%;text-align: center;" border="1">
	<thead>
		<c:if test="${empty participant_List }">
		<tr>
			<th colspan="5">후원 내역이 없습니다</th>
		</tr>	
		</c:if>
	</thead>
	
	<thead>
		<c:if test="${!empty participant_List }">
		 <tr>
         <th>번호</th>
         <th>참여자</th>
         <th>후원일자</th>
         <th>상품 / 옵션 정보</th>
         <th>상태</th>
         </tr>
		</c:if>
	</thead><!-- head -->
	<tbody> --%>
		<%-- <!-- list jsp:include로 보내려면 이렇게 -->
		  <c:set var="part_List" value="${participant_List }" scope="request"/>
		  
	      <jsp:include page="/WEB-INF/views/project/project_participant_list.jsp" flush="false">
	      	<jsp:param value="${part_List }" name="part_List"/>
	      </jsp:include> --%>
	<!-- </tbody>
	</table> -->
	   
   <!-- 
   <div class="table-users">
   <div class="header">참여 리스트</div>
	  
	   
	   
	</div> -->
	
	
	
	<div class="table-users">
		<!-- 테이블 헤더 부분 -->
	   <div class="parti_header">
	   " <c:set var="str" value="${participant_Dto.title }"/>
		<c:set var="len" value="${fn:length(str)}"/>
		<c:choose>
		<c:when test="${len ge 30}"><strong>&nbsp;${fn:substring(str,0,30) } ...</strong></c:when>
		<c:otherwise><strong>&nbsp;${str }</strong></c:otherwise>
		</c:choose>
	 " 프로젝트 참여 목록</div>
	   
	   <table class="parti_table" style="text-align: center;overflow-y: scroll;max-height: 10px;vertical-align: middle;" cellpadding="5px">
	   <colgroup>
	   	<col width="5%"><col width="15%"><col width="20%"><col width="40%"><col width="15%"><col width="5%">
	   </colgroup>
	   <c:choose>
	   <c:when test="${empty participant_List }">
		<tr>
			<th colspan="5">참여 내역이 없습니다</th>
		</tr>	
		</c:when>
		
	    <c:when test="${!empty participant_List }">
	      <tr>
	         <th>번호</th>
	         <th>참여자 ID</th>
	         <th>후원일자</th>
	         <th>상품 / 옵션 정보</th>
	         <th>총 결제금액</th>
	         <th>상태</th>
	      </tr>
	
	      <!-- list jsp:include로 보내려면 이렇게 -->
		  <c:set var="part_List" value="${participant_List }" scope="request"/>
		  
	      <jsp:include page="/WEB-INF/views/project/project_participant_list.jsp" flush="false">
	      	<jsp:param value="${part_List }" name="part_List"/>
	      </jsp:include>
	      
	     </c:when>
		</c:choose>
	
	   </table>
	</div>
	
	
	</div>
<!-- </div> -->
<!-- </div> -->

