<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@page import="donzo.thefun.model.ProjectDto"%>
<fmt:requestEncoding value="utf-8"/>   

<style>
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
	/* border-bottom: 1px solid #8152f0;
	border-right: 1px solid #8152f0;
	border-left: 1px solid #8152f0; */
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
   /* border:1px solid #8152f0; */
   
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
         border-right: 1px solid #8152f0;
         border-left: 1px solid #8152f0;
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
<!--
<th>번호</th>
<th>참여자</th>
<th>후원일자</th>
<th>상품 / 옵션 정보</th>
<th>총 결제금액</th>
<th>상태</th>

todolist
- 바이뷰 고쳐서 닉네임 가져오고, 배송 현황 스테이터스 추가? deliveried?
- projectService 바이 컨트롤러에?	
-->
         
<c:forEach items="${part_List }" var="part_Dto" varStatus="i">

<!-- regdate -->
<fmt:parseDate value="${part_Dto.regdate }" var="rdate" pattern="yyyy-MM-dd HH:mm:ss"/>

<%-- <c:choose>
<c:when test="${fundtype eq ProjectDto.TYPE_REWARD}"><!-- 리워드일 때 --> --%>
	<tr>
	   <td><input type="checkbox"></td>
	   <td>${part_Dto.id}</td><!-- 참여자 -->
	   <td><fmt:formatDate value="${rdate}" pattern="yyyy.MM.dd. HH:mm"/></td><!-- 참여일자 -->
	   <td>${part_Dto.otitle} : <span><c:forTokens items="${part_Dto.ocontent}" delims="/" var="content"><li class="liteGray list-group-item" style="float: right;width: 50%;padding: 0;">${content} (${part_Dto.count} 건)</li></c:forTokens></span></td><!-- 상품 / 옵션 정보 -->
	   
	   <td><fmt:formatNumber value="${part_Dto.price * part_Dto.count}" type="number"/> 원</td>
	   <td>
   			<c:when test="${part_Dto.status eq BuyDto.FINISH}">
  				<!-- <a href="#none" class="btn btn-outline-warning"> -->배송 완료<!-- </a> -->
 			</c:when>
 			
	   		<c:when test="${part_Dto.status ne BuyDto.FINISH}">
   			<!-- <a href="#none" class="btn btn-outline-danger"> -->배송 전<!-- </a> -->
   			</c:when>
		</td>
	</tr>
<%-- </c:when> --%>

<%-- <c:when test="${fundtype eq ProjectDto.TYPE_DONATION}"><!-- 기부일 때  -->

</c:when>
</c:choose> --%>
	
</c:forEach>