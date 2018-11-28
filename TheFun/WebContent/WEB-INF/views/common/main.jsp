<%@page import="donzo.thefun.model.ProjectDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:requestEncoding value="utf-8"/>   

 <!-- 차트 css -->
 <link rel="stylesheet" href="https://cdn.rawgit.com/theus/chart.css/v1.0.0/dist/chart.css" />
 
 <!-- 메인 css -->
 <link rel="stylesheet" href="CSS/common/main.css">
 
<div class="container">
	<!-- 메인 사진 -->
	 <div class="row" align="center">
	   <div align="center">
	     <img class="img-fluid" src="image/main/mainImg1.PNG">
	   </div>
	 </div>
	 
	 <!-- 메인 배너 슬라이드 -->
	 
	 <div class="carousel-container">

  <div class="carousel my-carousel carousel--translate">
    <input class="carousel__activator" type="radio" name="carousel" id="F" checked="checked"/>
    <input class="carousel__activator" type="radio" name="carousel" id="G"/>
    <input class="carousel__activator" type="radio" name="carousel" id="H"/>
    <input class="carousel__activator" type="radio" name="carousel" id="I"/>
    <input class="carousel__activator" type="radio" name="carousel" id="J"/>
   <!--  <div class="carousel__controls">
      <label class="carousel__control carousel__control--backward" for="J"></label>
      <label class="carousel__control carousel__control--forward" for="G"></label>
    </div>
    <div class="carousel__controls">
      <label class="carousel__control carousel__control--backward" for="F"></label>
      <label class="carousel__control carousel__control--forward" for="H"></label>
    </div>
    <div class="carousel__controls">
      <label class="carousel__control carousel__control--backward" for="G"></label>
      <label class="carousel__control carousel__control--forward" for="I"></label>
    </div>
    <div class="carousel__controls">
      <label class="carousel__control carousel__control--backward" for="H"></label>
      <label class="carousel__control carousel__control--forward" for="J"></label>
    </div>
    <div class="carousel__controls">
      <label class="carousel__control carousel__control--backward" for="I"></label>
      <label class="carousel__control carousel__control--forward" for="F"></label>
    </div> -->
    <div class="carousel__track">
      <li class="carousel__slide">
        <!-- <h1>F</h1> -->
      </li>
      <li class="carousel__slide">
        <!-- <h1>G</h1> -->
      </li>
      <li class="carousel__slide">
        <!-- <h1>H</h1> -->
      </li>
      <li class="carousel__slide">
        <!-- <h1>I</h1> -->
      </li>
      <li class="carousel__slide">
        <!-- <h1>J</h1> -->
      </li>
    </div>
    <div class="carousel__indicators">
      <label class="carousel__indicator" for="F"></label>
      <label class="carousel__indicator" for="G"></label>
      <label class="carousel__indicator" for="H"></label>
      <label class="carousel__indicator" for="I"></label>
      <label class="carousel__indicator" for="J"></label>
    </div>
  </div>
</div>
	 
	 
	 <!-- /.row -->
	    
	
	<div style="margin-bottom: 100px;"></div>
	
	<!-- 리스트 -->
	<h3 class="my-4">HOT 프로젝트(모금액순)</h3>
	<div align="right"><a href="searchProjectList.do">see all</a></div>
</div>

<!-- list jsp:include로 보내려면 이렇게 -->
<c:set var="list" value="${list }" scope="request"/>

<jsp:include page="/WEB-INF/views/project/project_list.jsp" flush="false">
	<jsp:param value="${pageNumber }" name="pageNumber"/>
	<jsp:param value="${pageCountPerScreen }" name="pageCountPerScreen"/>
	<jsp:param value="${recordCountPerPage }" name="recordCountPerPage"/>
	<jsp:param value="${totalRecordCount }" name="totalRecordCount"/>
	
	<jsp:param value="${s_type }" name="s_type"/>
	<jsp:param value="${s_category }" name="s_category"/>
	<jsp:param value="${s_keyword }" name="s_keyword"/>
	<jsp:param value="${s_summary }" name="s_summary"/>
	
	<jsp:param value="${list }" name="list"/>
</jsp:include>

</body>
</html>