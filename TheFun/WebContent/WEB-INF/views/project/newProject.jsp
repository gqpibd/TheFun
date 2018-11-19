<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:requestEncoding value="utf-8"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<!-- <meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no"> -->
</head>
<body>

<div id="header">
	<jsp:include page="/WEB-INF/views/common/header.jsp" flush="false">
		<jsp:param value="${header }" name="header"/>
	</jsp:include>
</div>
<br><br><br><br>
	<p >
	프로젝트 개요
	</p>
	<form style="width: 70%; margin: 0 auto;">
		<div class="form-control">
			<table>
			<colgroup>
				<col width="auto;">
				<col width="80%">
			</colgroup>
				<tr>
					<th>프로젝트 제목</th>
				</tr>
				<tr>
					<th style="color: #4B088A">프로젝트 제목을 입력해주세요</th>
					<td align="right">
						<button style="color: #4B088A">입력하기</button>
					</td>
				</tr>
			</table>
		</div>
		<div class="form-control">
			<table>
				<colgroup>
					<col width="auto;">
					<col width="80%">
				</colgroup>
				<tr>
					<th>프로젝트 대표 이미지</th>
				</tr>
				<tr>
					<th style="color: #4B088A">프로젝트 대표이미지를 등록해주세요</th>
					<td align="right">
						<button style="color: #4B088A">업로드하기</button>
					</td>
				</tr>
			</table>
		</div>
		<div class="form-control">
			<table>
				<colgroup>
					<col width="auto;">
					<col width="80%">
				</colgroup>
				<tr>
					<th>프로젝트 요약</th>
				</tr>
				<tr>
					<th style="color: #4B088A">프로젝트 요약을 입력해주세요</th>
					<td align="right">
						<button style="color: #4B088A">입력하기</button>
					</td>
				</tr>
			</table>
		</div>
		<div class="form-control">
			<table>
				<colgroup>
					<col width="auto;">
					<col width="80%">
				</colgroup>
				<tr>
					<th>프로젝트 카테고리</th>
				</tr>
				<tr>
					<th style="color: #4B088A">프로젝트 카테고리를 입력해주세요</th>
					<td align="right">
						<button style="color: #4B088A">입력하기</button>
					</td>
				</tr>
			</table>
		</div>
	
		<input type="button" class="form-control" placeholder="Text input" value="hahaha">
	
	</form>
<div id="footer">
	<jsp:include page="/WEB-INF/views/common/footer.jsp" flush="false">
		<jsp:param value="${footer }" name="footer"/>
	</jsp:include>
</div>

</body>
</html>