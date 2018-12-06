<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int totalRecordCount;	// 전체 글 수
	int pageNumber;			// 현재 페이지 : 현재 페이지의 번호	23 개의 글 -> 3 페이지	0 1 2
	int pageCountPerScreen;	// 스크린당 페이지 수
	int recordCountPerPage;	// 페이지 당 글수
	
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

<!-- float: left -->
<div style="width: 96%; text-align: center;" align="center">
	<a href="#none" title="처음 페이지" onclick="goPage('0');">
		<img alt="처음 페이지" src="image/common/angle-double-left-solid.svg" style="width: 11px; height: 11px;">
	</a>&nbsp;
		<%
		// 
		if(screenStartPageIndex > 1){	// 글의 수가 100개가 넘었을 때 보인다.
			%>
			<a href="#none" title="이전 페이지" onclick="goPage('<%= screenStartPageIndex - 1 %>')">
				<img alt="이전 페이지" src="image/common/angle-left-solid.svg" style="width: 11px; height: 11px;">
			</a>&nbsp;
			<%
		}
		
		// 1 [2] 3
		for (int i = screenStartPageIndex; i < screenEndPageIndex; i++) {
			if(i == pageNumber){
				%>
				<span style="font-size: 14pt; color: #000000; font-weight: bold;">
					<%= i + 1 %>  <!-- 현재 페이지 -->
				</span>&nbsp;
				<%
			}else{
				%>
				<a href="#none" title="<%=i+1%> 페이지" onclick="goPage(<%=i%>);" style="font-size: 14pt; color: #000000; font-weight: normal;">
					[<%=i+1%>]
				</a>&nbsp;
				<%
			}
		}
		if(screenEndPageIndex < totalPageCount){	//[1][2] ~ 9[10] 
			%>
			<a href="#none" title="다음 페이지" onclick="goPage(<%=screenEndPageIndex%>)">
				<img alt="다음 페이지" src="image/common/angle-right-solid.svg" style="width: 11px; height: 11px;">
			</a>&nbsp;
			<%
		}
		
		int end_page = 0;
		
		if(totalPageCount > 0){
			end_page = totalPageCount - 1;
		}

		%>
		
	<a href="#none" title="마지막 페이지" onclick="goPage(<%=end_page%>)">
		<img alt="마지막 페이지" src="image/common/angle-double-right-solid.svg" style="width: 11px; height: 11px;">
	</a>

</div>
<script>
/* 페이지 번호를 클릭했을 때 */
function goPage(pageNumber) {
	$("#_pageNumber").val(pageNumber);
	$("#s_keywordTextField").val($("#s_keywordTextField").val());
	/* alert(pageNumber); */
	$("#_frmFormSearch").attr({"target":"_self", "action":"myOrderList.do"}).submit();
}
</script>
<!-- <script>
$(document).ready(function () {
	$("#search_Btn").click(function () {
		$("#s_keywordTextField").text($("#s_keywordTextField").text());
		$("#_frmFormSearch").attr("action","searchProjectList.do").submit();
	});
});
   
function search_Enter() {	// 엔터 쳤을 때 검색
	$("#s_keywordTextField").text($("#s_keywordTextField").text());
	$("#_frmFormSearch").attr("action","searchProjectList.do").submit();
}
/* 페이지 번호를 클릭했을 때 */
function goPage(pageNumber) {
	$("#_pageNumber").val(pageNumber);
	alert(pageNumber);
	$("#_frmFormSearch").attr({"target":"_self", "action":"searchProjectList.do"}).submit();
}
   </script> -->
<%-- <div style="float: left; width: 4%; text-align: center;">
	<span style="font-size: 1em; color: #000000">
	<%if(totalRecordCount != 0 ){%>
		<%=pageNumber + 1%>/<%=totalPageCount%>
	<%}%>
	</span>
</div> --%>

