<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link href="CSS/common/pagination.css" rel="stylesheet">
<%
	int totalRecordCount;	// 전체 글 수
	int pageNumber;			// 현재 페이지 : 현재 페이지의 번호	23 개의 글 -> 3 페이지	0 1 2
	int pageCountPerScreen;	// 스크린당 페이지 수
	int recordCountPerPage;	// 페이지 당 글수
	String actionPath = request.getParameter("actionPath");	// 페이징을 보함하고 있는 현재 페이지
	
	String projectSeq = request.getParameter("projectseq");	// 프로젝트 참가자 현황을 볼 때 필요
	
	/*
	
	totalRecordCount : 123
	pageNumber : 11					<- 현재 페이지
	pageCountPerScreen : 10			<- 
	recordCountPerPage : 10
	totalPageCount : 13
	screenStartPageIndex : 10
	screenEndPageIndex : 4
	
	int totalRecordCount;       //총 글 수
	int pageNumber;             //현재 머무르고있는 페이지
	int pageCountPerScreen;    //총 페이지 수
	int recordCountPerPage;    //페이지당 글 수
	
	*/
	
	String st1 = request.getParameter("totalRecordCount");
	if(st1 == null){	
		totalRecordCount = 0;
	} else {			
		totalRecordCount = Integer.parseInt(st1);
	}
	
	String st2 = request.getParameter("pageNumber");
	if(st2 == null){	
		pageNumber = 0;
	} else {			
		pageNumber = Integer.parseInt(st2);
	}
	
	String st3 = request.getParameter("pageCountPerScreen");
	if(st3 == null){	
		pageCountPerScreen = 0;
	} else {			
		pageCountPerScreen = Integer.parseInt(st3);
	}
	
	String st4 = request.getParameter("recordCountPerPage");
	if(st4 == null){	
		recordCountPerPage = 0;
	} else {			
		recordCountPerPage = Integer.parseInt(st4);
	}
	
	// 총 페이지 수
	int totalPageCount = totalRecordCount / recordCountPerPage;
	//		  1 	   =			13  	  /  8
	
	if((totalRecordCount % recordCountPerPage) != 0){
		totalPageCount++;
	}
	
	// 						  1	 	   2		3		 4
	// 0 1 2 ~ 9 			1 ~ 10 	11 ~ 20  21 ~ 30  31 ~ 31
	int screenStartPageIndex = ((pageNumber + 1) / pageCountPerScreen) * pageCountPerScreen;	//	(int)1/10  는 0 이 나옴 
	//			0						0					10					10
	
	int screenEndPageIndex = (((pageNumber + 1) / pageCountPerScreen) * pageCountPerScreen) + pageCountPerScreen ;
	//			10						0					10					10					10
	
	if(screenEndPageIndex > totalPageCount) {
		screenEndPageIndex = totalPageCount;
	}
	
	if((pageNumber + 1) % pageCountPerScreen == 0){
		screenStartPageIndex = ((pageNumber + 1) / pageCountPerScreen) - pageCountPerScreen;
		screenEndPageIndex = pageNumber + 1;
	}
%>

<!-- <div class="pagination__wrapper"> -->
<ul class="pagination">
	<li><button class="prev" title="이전 페이지" onclick="goPage('<%= pageNumber>0?pageNumber-1:0 %>');">&#10094;</button></li>
	<% for (int i = screenStartPageIndex; i < screenEndPageIndex; i++) {
		if(i == pageNumber){ // 현재페이지
	%>
		<li><button class="active" ><%= i + 1 %></button></li>
	<%}else{%>
		<li>
	      <button onclick="goPage(<%=i%>)"><%= i + 1 %></button>
	    </li>				
	<%}}%>
	<%
	int end_page = 0;
	if(totalPageCount > 0){
		end_page = totalPageCount - 1;
	}
	%>	
  <li><button class="next" title="next page" onclick="goPage(<%=pageNumber<end_page?pageNumber+1:end_page%>)">&#10095;</button></li>
</ul>
  
<form id="_frmFormSearch" name="frmForm1" > <!-- method="post" -->
	<!-- controller로 넘겨주기 위한 값 -->
	<input type="hidden" name="pageNumber" id="_pageNumber" value="${(empty pageNumber)?0:pageNumber}">
	<input type="hidden" name="recordCountPerPage" id="_recordCountPerPage" value="${(empty recordCountPerPage) ? 8 : recordCountPerPage}">
	<input type="hidden" name="s_keyword" value="${s_keyword }">
	<input type="hidden" name="more_s_keyword" value="${more_s_keyword }" id="_more_s_keyword">
	<input type="hidden" name="s_type" value="${s_type }">
	<input type="hidden" name="s_category" value="${s_category }">
	<input type="hidden" name="s_summary" value="${s_summary }">
	<input type="hidden" name="s_sort" value="${s_sort }">
	<input type="hidden" name="s_asc_desc" value="${s_asc_desc }">
	<input type="hidden" name="s_complete" value="${s_complete }">
	<input type="hidden" name="s_condition" value="${s_condition }">
	<input type="hidden" name="doc_title" value="${doc_title }">
	
	<!-- 참가현황 페이징시 project seq 필요 -->
	<input type="hidden" name="projectseq" value="<%=projectSeq%>">
</form>

<script>
/* 페이지 번호를 클릭했을 때 */
function goPage(pageNumber) {
	$("#_pageNumber").val(pageNumber);	
	$("#s_keywordTextField").val($("#s_keywordTextField").val());	
	//$("#_frmFormSearch").attr({"target":"_self", "action":"searchProjectList.do", "method":"post"}).submit();
	$("#_frmFormSearch").attr({"target":"_self", "action":"<%=actionPath%>", "method":"post"}).submit();
}

</script>

