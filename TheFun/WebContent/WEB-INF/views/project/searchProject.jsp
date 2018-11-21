<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:requestEncoding value="utf-8"/>   

<h1>서치뷰입니다.</h1>

<c:forEach items="${list }" var="dto" varStatus="i">
	<h5>${dto.toString() }</h5>
</c:forEach>