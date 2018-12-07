<%@page import="donzo.thefun.model.ProjectDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<fmt:requestEncoding value="UTF-8"/>
<style>
#line_header {
  background: #fff;
  color: #00000090;
  padding: 20px;
}

#line_header p {
  font-family: 'Allura';
  color: #00000090;
  font-size: 40px;
}

/* 테이블 CSS */
.header {
   /* background-color: darken($baseColor, 5%); */
   color: black;
   font-size: 1.5em;
   padding: 1rem;
   text-align: center;
   text-transform: uppercase;
}
img {
   border-radius: 50%;
   /* height: $imageSmall;
   width: $imageSmall; */
}

.table-users {
   /* border: 1px solid darken($baseColor, 5%); */
   /* border-radius: $borderRadius; */
   box-shadow: 3px 3px 0 rgba(0,0,0,0.1);
   /* max-width: calc(100% - 2em); */
   margin: 1em auto;
   overflow: hidden;
   /* width: 800px; */
}
</style>

	<header id="line_header">
	<div class="container text-center">
	<!-- <h1 class="head_title">SEARCH</h1> -->
	<p>프로젝트 참여 현황</p>
	<div align="right"  style="margin-top: 5%;">
	<a href="projectDetail.do?seq=${participant_Dto.seq }" class="btn btn-primary">해당 프로젝트 보러가기</a>
	</div>
	</div>
	</header>
	
<div class="container">
<div class="card" style="overflow-y: scroll; height:500px;">
	 <div class="card-header">
	 <span onclick="location.href='projectDetail.do?seq=${participant_Dto.seq }'"><strong>${participant_Dto.title} 프로젝트</strong></span>
	 입금받을 계좌 번호 : ${participant_Dto.bank }
	 </div>
	 <div class="card-body">
	   <h5 class="card-title">기능하자 승재야</h5>
	   내용
	   
    <table class="type07" id="myparticipant_List">
	<thead>
		<c:if test="${empty participant_List }">
		<tr>
			<th colspan="6">후원 내역이 없습니다</th>
		</tr>	
		</c:if>
	</thead>
	
	<thead>
		<c:if test="${not empty participant_List }">
		<tr>
			<th>후원일자</th>
			<th colspan="2">후원 프로젝트 정보</th>
			<th>후원금액(수량)</th>
			<th>작성자</th>
			<th>상태</th>
			<!-- <th>추가할 어떤 것</th> -->
		</tr>	
		</c:if>
	</thead><!-- head -->
	</table>
	   
   <!-- 테이블 표현 -->
   <div class="table-users">
   <!-- <div class="header">참여 리스트</div> -->
   
   <table cellspacing="0" border="1">
      <tr>
         <th>번호</th>
         <th>후원일자</th>
		 <th>후원 프로젝트 정보</th>
		 <th>후원금액(수량)</th>
         <th>참여자</th>
         <th>상품 / 옵션 정보</th>
         <th>참여자 결제 정보</th>
         <th>상태</th>
      </tr>
      
      <!-- list jsp:include로 보내려면 이렇게 -->
	  <c:set var="list" value="${participant_List }" scope="request"/>
      
      <jsp:include page="/WEB-INF/views/project/project_participant_list.jsp" flush="false">
      
      	<jsp:param value="${list }" name="list"/>
      	
      </jsp:include>
      
      
      
   </table>
	   
	   
	</div>
</div>
</div>
</div>

