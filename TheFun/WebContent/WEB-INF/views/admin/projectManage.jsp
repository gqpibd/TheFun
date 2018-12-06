<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:requestEncoding value="utf-8"/> 

<link rel="stylesheet" href="CSS/admin/manage.css">
<style type="text/css">
@media only screen and (max-width: 760px), (min-device-width: 768px) 
   and (max-device-width: 1024px)  {
	/* Force table to not be like tables anymore */
	table, thead, tbody, th, td, tr {
		display: block;
	}

	/* Hide table headers (but not display: none;, for accessibility) */
	thead tr {
		position: absolute;
		/* top: -9999px;
		left: -9999px; */
		opacity:0;
	}

   tr {
     margin: 0 0 1rem 0;
   }
     
   tr:nth-child(odd) {
     background: #ccc;
   }
   
	td {
		/* Behave  like a "row" */
		border: none;
		border-bottom: 1px solid #eee;
		position: relative;
		padding-left: 50%;
	}

	td:before {
		/* Now like a table header */
		position: absolute;
		/* Top/left values mimic padding */
		top: 0;
		left: 6px;
		width: 45%;
		padding-right: 10px;
		white-space: nowrap;
	}
/*Label the data
   You could also use a data-* attribute and content for this. That way "bloats" the HTML, this way means you need to keep HTML and CSS in sync. Lea Verou has a clever way to handle with text-shadow.
	*/
	td:nth-of-type(1):before { content: "펀드 타입"; }
	td:nth-of-type(2):before { content: "카테고리"; }
	td:nth-of-type(3):before { content: "제목"; }
	td:nth-of-type(4):before { content: "등록일"; }
	td:nth-of-type(5):before { content: "시작일"; }
	td:nth-of-type(6):before { content: "작성자"; }
}
</style>
<div align="center" id="bbsTable">
	<div class="h1">
		<h1>관리자 페이지</h1>
	</div>
	<span>승인을 기다리는 프로젝트가 ${pList.size()}개 있습니다.</span>
	<table class="type08">
		<col width="150">
		<col width="150">
		<col width="450">
		<col width="150">
		<col width="150">
		<col width="150">
		<thead>
			<tr>
				
				<th>펀드 타입</th>
				<th>카테고리</th>
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
				
				<td>${project.getFundTypeKr()}</td>
				<td>${project.getCategoryKr()}</td>
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