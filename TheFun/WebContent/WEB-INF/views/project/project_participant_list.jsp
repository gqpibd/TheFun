<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8"/>   

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

<tr>
   <td>${i.count }</td><!-- 번호  -->
   <td>${part_Dto.id}</td><!-- 참여자 -->
   <td><fmt:formatDate value="${rdate}" pattern="yyyy.MM.dd. HH:mm"/></td><!-- 참여일자 -->
   <td>${part_Dto.otitle} : <span class="card-text"><c:forTokens items="${part_Dto.ocontent}" delims="/" var="content"><li class="liteGray list-group-item" style="float: right;width: 50%;padding: 0;">${content} (${part_Dto.count} 건)</li></c:forTokens></span></td><!-- 상품 / 옵션 정보 -->
   <td><fmt:formatNumber value="${part_Dto.price }" type="number"/> 원</td>
   <td>
   	<c:choose>
   		<c:when test="${part_Dto.status eq 'deliveried'}">
   			<a href="#none" class="btn btn-outline-warning">배송 현황</a>
   		</c:when>
   		<c:when test="${part_Dto.status ne 'deliveried'}">
   			<a href="#none" class="btn btn-outline-danger">배송 하기</a>
   		</c:when>
	</c:choose>
   </td><!-- 상태 -->
</tr>
	
</c:forEach>