<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:requestEncoding value="utf-8"/> 

<link rel="stylesheet" href="CSS/admin/manage.css">

<div align="center" id="bbsTable">
	<div class="h1">
		<h1>관리자 페이지</h1>
	</div>
	<span>승인을 기다리는 프로젝트가 ${pList.size()}개 있습니다.</span>
	<table class="type08">
		<col width="70">
		<col width="500">
		<col width="150">
		<col width="150">
		<col width="150">
		<thead>
			<tr>
				<th>번호</th>
				<th>제목</th>
				<th>등록일</th>
				<th>시작일</th>
				<th>작성자</th>
			</tr>
		</thead>
		<tbody>
			<c:choose>
			<c:when test="${pList eq null}">			
				<tr>
					<td colspan="4">작성된 글이 없습니다</td>
				</tr>
			</c:when>
			<c:otherwise>
			<c:forEach items="${pList}" var="project" varStatus="i">			
			<tr class="hover_tr" style="cursor:pointer" onclick="location.href='projectDetail.do?seq=${project.seq}'">
				<td>${i.count}</td>
				<td>${project.title}</td>
				<td>${project.getDateForm(project.regdate)}</td>				
				<td>${project.getDateForm(project.sdate)}</td>
				<td>${project.id}</td>
			</tr>
			</c:forEach>

			</c:otherwise>
			</c:choose>
		</tbody>
	</table>
	<%-- <jsp:include page="paging.jsp">
		<jsp:param name="actionPath" value="bbslist.jsp" />
		<jsp:param name="nowPage"
			value="<%=String.valueOf(paging.getNowPage())%>" />
		<jsp:param name="totalCount"
			value="<%=String.valueOf(paging.getTotalCount())%>" />
		<jsp:param name="countPerPage"
			value="<%=String.valueOf(paging.getCountPerpage())%>" />
		<jsp:param name="blockCount"
			value="<%=String.valueOf(paging.getBlockCount())%>" />		
	</jsp:include> --%>
</div>
<script type="text/javascript">
$(".hover_tr").mouseover(function () {
	$(this).children().css("background-color","#F7EEF8");
}).mouseout(function () {
	$(this).children().css("background-color","#ffffff");		
});
</script>