<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@page import="donzo.thefun.model.ProjectDto"%>
<%@page import="donzo.thefun.model.BuyDto"%>
<fmt:requestEncoding value="utf-8"/>   

<style>


/* ///// */

@media screen and (max-width: 2000px) {
  
  table, tr, td {
    display: block;
  }

  td:first-child {
    position: absolute;
    top: 50%;
    -webkit-transform: translateY(-50%);
            transform: translateY(-50%);
    width: 100px;
  }
  td:not(:first-child) {
    clear: both;
    margin-left: 100px;
    padding: 4px 20px 4px 90px;	
    position: relative;
    text-align: left;
  }
  td:not(:first-child):before {
    color: #8152f0;
    content: '';
    display: block;
    left: 0;
    position: absolute;
  }
  td:nth-child(2):before {
    content: '후원자:';
  }
  td:nth-child(3):before {
    content: '후원일자:';
  }
  td:nth-child(4):before {
    content: '후원금액';
  }
  td:nth-child(5):before {
    content: '상태';
  }
  td:nth-child(6):before {
    content: '옵션:';
  }
  
  
  tr {
    padding: 10px 0;
    position: relative;
  }
  /* tr:first-child {
    display: none;
  } */
}

@media screen and (max-width: 687px) {
  .header {
    background-color: transparent;
    color: #8152f0;
    font-size: 2em;
    font-weight: 700;
    padding: 0;
    text-shadow: 2px 2px 0 rgba(0, 0, 0, 0.1);
  }
 
 
  table_img {
    border: 3px solid;
    border-color: #daeff1;
    height: 100px;
    margin: 0.5rem 0;
    width: 100px;
  }

  td:first-child {
    background-color: #8152f0;
    /* border-bottom: 1px solid #91ced4; */
    border-radius: 10px 10px 0 0;
    position: relative;
    top: 0;
    -webkit-transform: translateY(0);
            transform: translateY(0);
    width: 100%;
  }
  td:not(:first-child) {
    margin: 0;
    padding: 5px 1em;
    width: 100%;
  }
  td:not(:first-child):before {
    font-size: .8em;
    padding-top: 0.3em;
    position: relative;
  }
  td:last-child {
    padding-bottom: 1rem !important;
  }

  tr {
    background-color: white !important;
    border: 1px solid #8152f0;
    border-radius: 10px;
    box-shadow: 2px 2px 0 rgba(0, 0, 0, 0.1);
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
<!--

td:nth-child(2):before {
    content: '후원자:';
  }
  td:nth-child(3):before {
    content: '후원일자:';
  }
  td:nth-child(4):before {
    content: '후원금액';
  }
  td:nth-child(5):before {
    content: '상태';
  }
  td:nth-child(6):before {
    content: '옵션:';
  }
  
- 바이뷰 고쳐서 닉네임 가져오고
-->
         
<c:forEach items="${part_List }" var="part_Dto" varStatus="i">

<!-- regdate -->
<fmt:parseDate value="${part_Dto.regdate }" var="rdate" pattern="yyyy-MM-dd HH:mm:ss"/>

<c:choose>
<c:when test="${fundtype eq ProjectDto.TYPE_REWARD}"><!-- 리워드일 때 -->
	<tr class="check_tr" style=" display:inline-block;">
	   <td><input type="checkbox" name="check_row"></td>
	   <td>${part_Dto.id} : ${part_Dto.seq }</td><!-- 후원자 -->
	   <td><fmt:formatDate value="${rdate}" pattern="yyyy.MM.dd. HH:mm"/></td><!-- 후원일자 -->
	   <td><fmt:formatNumber value="${part_Dto.price * part_Dto.count}" type="number"/> 원</td> <!-- 후원금액 -->
	   <td>
	   <c:choose>
   			<c:when test="${part_Dto.status eq BuyDto.FINISH}">배송 완료</c:when>
 			
	   		<c:when test="${part_Dto.status ne BuyDto.FINISH}">배송 전</c:when>
 		</c:choose>
		</td>
		<td style="text-align: left;">${part_Dto.otitle} : <span><c:forTokens items="${part_Dto.ocontent}" delims="/" var="content"><li style="padding: 0;">${content} (${part_Dto.count} 건)</li></c:forTokens></span></td><!-- 상품 / 옵션 정보 -->
	   <%-- <li class="list-group-item" style="padding: 0;">${content} (${part_Dto.count} 건)</li></c:forTokens></span></td><!-- 상품 / 옵션 정보 --> --%>
	</tr>
</c:when>

<c:when test="${fundtype eq ProjectDto.TYPE_DONATION}"><!-- 기부일 때  -->
	<tr class="check_tr" style=" display:inline-block;">
	   <td><input type="checkbox" name="check_row"></td>
	   <td>${part_Dto.id} : ${part_Dto.seq }</td><!-- 후원자 -->
	   <td><fmt:formatDate value="${rdate}" pattern="yyyy.MM.dd. HH:mm"/></td><!-- 후원일자 -->
	   <td><fmt:formatNumber value="${part_Dto.price * part_Dto.count}" type="number"/> 원</td>
	   <td>
	   <c:choose>
   			<c:when test="${part_Dto.status eq BuyDto.FINISH}">결제 완료</c:when>
 			
	   		<c:when test="${part_Dto.status ne BuyDto.FINISH}">결제 전</c:when>
 		</c:choose>
		</td>
	   <%-- <td style="text-align: left;">${part_Dto.otitle} : <span><c:forTokens items="${part_Dto.ocontent}" delims="/" var="content"><li style="padding: 0;">${content} (${part_Dto.count} 건)</li></c:forTokens></span></td><!-- 상품 / 옵션 정보 --> --%>
	   <%-- <li class="list-group-item" style="padding: 0;">${content} (${part_Dto.count} 건)</li></c:forTokens></span></td><!-- 상품 / 옵션 정보 --> --%>
	</tr>
</c:when>
</c:choose>
	
</c:forEach>