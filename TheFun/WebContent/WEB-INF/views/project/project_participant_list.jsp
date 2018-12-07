<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:requestEncoding value="utf-8"/>   

<!--
<th>번호</th>
<th>후원일자</th>
<th>후원 프로젝트 정보</th>
<th>후원금액(수량)</th>
<th>참여자</th>

<th>상품 / 옵션 정보</th>
<th>참여자 결제 정보</th>
<th>상태</th>
-->
         
<c:forEach items="${list }" var="dto" varStatus="i">

<tr>
   <td><img class="profile" src="${dto.profile}"></td>
   <td>${dto.name }</td>
   <td>jane.doe@foo.com</td>
   <td>01 800 2000</td>
   <td>Lorem ipsum dolor sit amet, consectetur adipisicing elit. </td>
   <td></td>
   <td></td>
   <td></td>
</tr>

</c:forEach>