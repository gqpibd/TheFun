<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<fmt:requestEncoding value="UTF-8"/>

<style type="text/css">
 .pTitle{
 	font-weight: bold;
 	color: black;
 	font-size: large;
 }
 .pName{
 	color: gray;
 	font-size: small;
 }
 </style>
 
 <!-- Page Content -->
<div class="container">
	<!-- 메인 사진 -->
	<div class="row" align="center">
		<div align="center">
			<img class="img-fluid" src="image/main/mainImg1.PNG">
		</div>
	</div>
	<!-- /.row -->

	<!-- 리스트 -->
	<h3 class="my-4">HOT 프로젝트</h3>
	<div class="row">

        <div class="col-md-3 col-sm-6 mb-4">
          <form action="detail.do"  id="gotoDetail"><!-- //가짜 정보. 코드합칠때 main 전체는 합치지 말것-->
          <input type="hidden" name="seq" value="1">	<!-- //가짜 정보. 코드합칠때 main 전체는 합치지 말것-->
          <input type="hidden" name="id" value="eee"><!-- //가짜 정보. 코드합칠때 main 전체는 합치지 말것-->
            <img class="img-fluid" src="image/main/mainImg7.PNG" onclick="godetail()"id="img"><!-- //가짜 정보. 코드합칠때 main 전체는 합치지 말것-->
          <p class="pTitle">프로젝트 타이틀</p><!-- //가짜 정보. 코드합칠때 main 전체는 합치지 말것-->
          <p class="pName">카테고리 | 회사이름</p><!-- //가짜 정보. 코드합칠때 main 전체는 합치지 말것-->
           </form>       
           <script type="text/javascript">
           $("#img").mouseover(function () {	
        		$(this).css("cursor","pointer");
        	}); 

           function godetail() {
        	   $("#gotoDetail").attr("action","projectDetail.do").submit();
		}
           </script>
        </div>
      </div>
	<div class="row">

		<div class="col-md-3 col-sm-6 mb-4">
			<a href="#"> <img class="img-fluid" src="image/main/mainImg7.PNG"
				alt="">
			</a><br>
			<p class="pTitle">프로젝트 타이틀</p>
			<p class="pName">카테고리 | 회사이름</p>
		</div>

		<div class="col-md-3 col-sm-6 mb-4">
			<a href="#"> <img class="img-fluid" src="image/main/mainImg7.PNG"
				alt="">
			</a><br>
			<p class="pTitle">프로젝트 타이틀</p>
			<p class="pName">카테고리 | 회사이름</p>
		</div>

		<div class="col-md-3 col-sm-6 mb-4">
			<a href="#"> <img class="img-fluid" src="image/main/mainImg7.PNG"
				alt="">
			</a><br>
			<p class="pTitle">프로젝트 타이틀</p>
			<p class="pName">카테고리 | 회사이름</p>
		</div>

		<div class="col-md-3 col-sm-6 mb-4">
			<a href="#"> <img class="img-fluid" src="image/main/mainImg7.PNG"
				alt="">
			</a><br>
			<p class="pTitle">프로젝트 타이틀</p>
			<p class="pName">카테고리 | 회사이름</p>
		</div>

	</div>
	<!-- /.row 리스트끝-->

</div>
<!-- /.container 메인컨테이너 끝-->