<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page import="donzo.thefun.model.ProjectDto"%>
<!DOCTYPE html>

<div class="card">
	 <div class="card-header">
	 ${ProjectDto.title } 여기는 참가 현황 뷰 입금받을 계좌 번호 : ${ProjectDto.bank }
	 </div>
	 <div class="card-body">
	   <h5 class="card-title">기능하자 승재야</h5>
	   <a href="main.do" class="btn btn-primary">상품 보러가기</a>
	</div>
</div>