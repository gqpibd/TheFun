<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>


<!-- ////////////////////////////////////////////////// -->
<!-- 후기게시판 메뉴 부분 -->
<div> <!-- css용 div태그 -->
<form action="" name="" id="" method="post">
<table>

<tr>
	<td>
		<span> <!-- css용 span태그 -->
			<button type="button" id="">질문하기</button>
		</span>
	</td>

	<td>
		<span> <!-- css용 span태그 -->
			<button type="button" id="">1:1질문하기</button>
		</span>
	</td>
	
	<td>검색:</td>
	
	<td>
		<select id="" name="">
			<option value="" selected="selected">선택</option>
			<option value="title">제목</option>
			<option value="contents">내용</option>
		</select>
	</td>
	
	<td>
		<input type="text" id="" name="" value="">
	</td>
	
	<td>
		<span> <!-- css용 span태그 -->
			<button type="button" id="">검색</button>
		</span>
	</td>
</tr>

</table>


<!-- controller로 넘겨주기 위한 데이터 값 -->
<input type="hidden" name="" id="" value="<!-- el태그? -->">
<input type="hidden" name="" id="" value="<!-- el태그? -->">


</form>
</div>
<!-- /////////////////////////////////////////////////////////////// -->


<!-- /////////////////////////////////////////////////////////////// -->
<!-- 후기게시판 -->
<%-- <jsp:useBean id="ubbs" class="donzo.thefun.utill."/> <!-- ??? --> --%>

<table>
	<colgroup>
		<col style="width:70px;">
		<col style="width:auto;">
		<col style="width:100px;">
		<col style="width:100px;">
		<col style="width:100px;">
	</colgroup>

<!-- 후기게시판 머릿 부분-->
<thead>
	<tr>
		<th>번호</th>
		<th>제목</th>
		<th>아이디</th>
		<th>답변상태</th>
		<th>작성일</th>
	</tr>
</thead>


<!-- 후기게시판 메인 부분 -->
<tbody>

	<!-- <c:if test=""> -->
	<tr>
		<td colspan="5">후기 글이 없습니다.</td>
	</tr>	
	<!-- </c:if> -->
	
	
	<!-- for문(bbsdto bbs: bbsaferlist) -->
	<!-- <c:forEach items="" var="" varStatus=""> -->
	
	<!-- depth = ubbs.getDepth(); -->
	<%-- <jsp:setProperty property="" name="" value=""/> --%>

	<tr>
		<td> <!-- 번호 -->
		<!-- el태그 vs.count -->
		</td>
		
		<td style="text-align: left;"> <!-- 제목: 프로젝트후기글 -->
			<%-- <jsp:getProperty property="" name=""/>
			<c:if test="">
				이 글은 게시자에 의해서 삭제 되었습니다 	
			</c:if> --%>
			<!-- <c:if test="">
				<a href="">
				el태그 제목값
				</a>			
			</c:if> -->
		</td>
		
		<td> <!-- 아이디 -->
		<!-- el태그 -->
		</td>	
		
		<td> <!-- 답변상태 -->
		<!-- el태그 -->
		</td>
		
		<td> <!-- 작성일 -->
		<!-- el태그 -->
		</td>
		
	</tr>		
<!-- </c:forEach> -->
	
</tbody>


<!-- 후기게시판 끝 부분 -->
<tfoot>
	<tr>
		<th align="right">
			<span> <!-- css용 span태그 -->
				<button type="button" id="">글쓰기</button>
			</span>
		</th>
	</tr>
</tfoot>

</table>
<!-- /////////////////////////////////////////////////////////////// -->


<!-- //////////////////////////// -->
<!-- 후기게시판 페이징 부분 -->
<div> <!-- css용 div태그 -->
	<jsp:include page="<%-- 페이징 경로 --%>" flush="false">
		<jsp:param value="<%-- el태그 --%>" name="<%-- 페이징jsp --%>"/>
		<jsp:param value="<%-- el태그 --%>" name="<%-- 페이징jsp --%>"/>
		<jsp:param value="<%-- el태그 --%>" name="<%-- 페이징jsp --%>"/>
		<jsp:param value="<%-- el태그 --%>" name="<%-- 페이징jsp --%>"/>
	</jsp:include>
</div>
<!-- /////////////////////////////// -->


<!-- ///////////////////////////////// -->
<script>
/* 후기글쓰기 버튼 스크립트 */
 
/* 검색 스크립트 */

/* 페이지 이동 클릭 스크립트 */

</script>
<!-- ////////////////////////////// -->

</body>
</html>