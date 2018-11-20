<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:requestEncoding value="utf-8"/>   
<div class="row">
	<div class="col-md-3 col-sm-6 mb-4">
	<table border="1">
	<tr>
	<td>
	  <a href="detail.do?seq=${attribute.getSeq() }">
	    <img class="img-fluid" src="image/thumbnail/${attribute.getSeq() }.png" alt="프로젝트 썸네일">
	  </a>
	  <p>${attribute.toString() }</p>
	<td>
	</tr>
	<tr>
	<td>
		<p class="pTitle">프로젝트 제목</p>
	</td>
	</tr>
	<tr>
	<td>
		<p class="pName">카테고리 | 진행자 이름</p>
	</td>
	</tr>
	</table>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	</div>
</div>
