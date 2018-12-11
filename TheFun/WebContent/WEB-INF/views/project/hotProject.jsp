<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:requestEncoding value="utf-8"/>   
<!DOCTYPE html>

<style>
#line_header {
  background: #fff;
  color: #00000090;
  padding: 20px;
}

#line_header p {
  font-family: 'Allura';
  color: #00000090;
  font-size: 40px;
}
</style>

<%-- <c:when test="${doc_title eq 'categoryBest'}"> --%>
<header id="line_header">
<div class="container text-center">
<!-- <h1 class="head_title">SEARCH</h1> -->
<p>분야별 인기 프로젝트</p>
</div>
</header>
<%-- </c:when> --%>
	

<!-- 1 -->
<div class="container" style="margin-bottom: 3%;">
<div class="row">
<h3 class="my-4">기부 - 인권 프로젝트</h3>
<!-- list jsp:include로 보내려면 이렇게 설정해서 보내주면 된다.-->
<c:set var="list" value="${human_List }" scope="request"/>

<jsp:include page="/WEB-INF/views/project/project_list.jsp" flush="false">

	<jsp:param value="${s_type }" name="s_type"/>
	<jsp:param value="${s_category }" name="s_category"/>
	<jsp:param value="${s_keyword }" name="s_keyword"/>
	<jsp:param value="${s_summary }" name="s_summary"/>
	<jsp:param value="${s_asc_desc }" name="s_asc_desc"/>
	
	<jsp:param value="${human_List }" name="list"/>
</jsp:include>

</div>
</div>


<!-- 2 -->
<div class="container" style="margin-bottom: 3%;">
<div class="row">
<h3 class="my-4">기부 - 동물 프로젝트</h3>
<!-- list jsp:include로 보내려면 이렇게 설정해서 보내주면 된다.-->
<c:set var="list" value="${dona_Animal_List }" scope="request"/>

<jsp:include page="/WEB-INF/views/project/project_list.jsp" flush="false">

	<jsp:param value="${s_type }" name="s_type"/>
	<jsp:param value="${s_category }" name="s_category"/>
	<jsp:param value="${s_keyword }" name="s_keyword"/>
	<jsp:param value="${s_summary }" name="s_summary"/>
	<jsp:param value="${s_asc_desc }" name="s_asc_desc"/>
	
	<jsp:param value="${dona_Animal_List }" name="list"/>
</jsp:include>

</div>
</div>


<!-- 3 -->
<div class="container" style="margin-bottom: 3%;">
<div class="row">
<h3 class="my-4">리워드 - 음식 프로젝트</h3>
<!-- list jsp:include로 보내려면 이렇게 설정해서 보내주면 된다.-->
<c:set var="list" value="${food_List }" scope="request"/>

<jsp:include page="/WEB-INF/views/project/project_list.jsp" flush="false">

	<jsp:param value="${s_type }" name="s_type"/>
	<jsp:param value="${s_category }" name="s_category"/>
	<jsp:param value="${s_keyword }" name="s_keyword"/>
	<jsp:param value="${s_summary }" name="s_summary"/>
	<jsp:param value="${s_asc_desc }" name="s_asc_desc"/>
	
	<jsp:param value="${food_List }" name="list"/>
</jsp:include>

</div>
</div>


<!-- 4 -->
<div class="container" style="margin-bottom: 3%;">
<div class="row">
<h3 class="my-4">리워드 - IT / 전자 프로젝트</h3>
<!-- list jsp:include로 보내려면 이렇게 설정해서 보내주면 된다.-->
<c:set var="list" value="${it_List }" scope="request"/>

<jsp:include page="/WEB-INF/views/project/project_list.jsp" flush="false">

	<jsp:param value="${s_type }" name="s_type"/>
	<jsp:param value="${s_category }" name="s_category"/>
	<jsp:param value="${s_keyword }" name="s_keyword"/>
	<jsp:param value="${s_summary }" name="s_summary"/>
	<jsp:param value="${s_asc_desc }" name="s_asc_desc"/>
	
	<jsp:param value="${it_List }" name="list"/>
</jsp:include>

</div>
</div>


<!-- 5 -->
<div class="container" style="margin-bottom: 3%;">
<div class="row">
<h3 class="my-4">리워드 - 동물 프로젝트</h3>
<!-- list jsp:include로 보내려면 이렇게 설정해서 보내주면 된다.-->
<c:set var="list" value="${reward_animal_List }" scope="request"/>

<jsp:include page="/WEB-INF/views/project/project_list.jsp" flush="false">

	<jsp:param value="${s_type }" name="s_type"/>
	<jsp:param value="${s_category }" name="s_category"/>
	<jsp:param value="${s_keyword }" name="s_keyword"/>
	<jsp:param value="${s_summary }" name="s_summary"/>
	<jsp:param value="${s_asc_desc }" name="s_asc_desc"/>
	
	<jsp:param value="${reward_animal_List }" name="list"/>
</jsp:include>

</div>
</div>