<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:requestEncoding value="utf-8"/> 

<link rel="stylesheet" href="http://storage.googleapis.com/code.getmdl.io/1.0.1/material.teal-red.min.css">
<style type="text/css">

.mdl-grid {
	max-width: 1200px;
}
.mdl-card__media {
	margin: 0;
}
.mdl-card__media > img {
	max-width: 100%;
}
.mdl-card__actions {
	display: flex;
	box-sizing:border-box;
	align-items: center;
}
.mdl-card__actions > .mdl-button--icon {
	margin-right: 3px;
	margin-left: 3px;
}

.mdl-button:focus{
	outline:none;
}
</style>

<script type="text/javascript">
document.addEventListener("DOMContentLoaded", function(){
	var alarmCount = ${alarmList.size()}; 	
	setGridCss(alarmCount);
});

function setGridCss(alarmCount){
	if(alarmCount >= 4){
		console.log("alarmCount>=4");
		$(".mdl-grid").css("max-width",'1200px');	
		$("div[name='alarmCard']").addClass("mdl-cell--3-col");
	}else if(alarmCount >= 3){
		console.log("alarmCount>=3");
		$(".mdl-grid").css("max-width",'900px');	
		$("div[name='alarmCard']").addClass("mdl-cell--4-col").removeClass("mdl-cell--3-col");
	}else if(alarmCount >= 2){
		console.log("alarmCount>=2");
		$(".mdl-grid").css("max-width",'600px');	
		$("div[name='alarmCard']").addClass("mdl-cell--6-col").removeClass("mdl-cell--4-col");
	}else if(alarmCount == 1){
		console.log("alarmCount==1");
		$(".mdl-grid").css("max-width",'300px');		
		$("div[name='alarmCard']").removeClass("mdl-cell").removeClass("mdl-cell--6-col").removeClass("mdl-cell--4-col-tablet");	
	}
}

function deleteAlarm(seq,selector){ // 알람을 읽지 않고 삭제하는 경우
	
	$.ajax({
		type:"get",
		url:"deleteAlarm.do",
		data:"seq=" + seq,
		
		success:function(data){	// 등록되어 있으면 바로 로그인 시킴		
			setAlarmCount(); // 상단바에 알람 갯수 변경. 이 함수는 topbar에 선언되어 있음
			console.log($(selector).parents().eq(1));
			$(selector).parents().eq(1).remove();
			var alarmCount = $("#alarmContainer").children().length;
			setGridCss(alarmCount);	
		}
	})
}
</script> 
<div class="mdl-grid" id="alarmContainer">
<c:choose>
	<c:when test="${alarmList ne null and alarmList.size() == 0}">
		새로운 소식이 없습니다.
	</c:when>
	<c:otherwise>
			<c:forEach items="${alarmList}" var="item">									
				<div name="alarmCard" class="mdl-card mdl-cell mdl-cell--4-col-tablet mdl-shadow--2dp">
					<figure class="mdl-card__media">
						<img src="upload/${item.projectseq}" alt="" />
					</figure>
					<div class="mdl-card__title">
						<h1 class="mdl-card__title-text">${item.ptitle}</h1>
					</div>
					<div class="mdl-card__supporting-text" style="width:100%">
						<p>${item.getDateKor()}</p>
						<p> ${item.getMessage()} </p>
						
					</div>
					<div class="mdl-card__actions mdl-card--border">
						<button onclick="location.href='readAlarm.do?seq=${item.seq}&projectseq=${item.projectseq}'"
							class="mdl-button mdl-button--colored mdl-js-button mdl-js-ripple-effect">프로젝트로 이동</button>
						<div class="mdl-layout-spacer"></div>
						
						<button class="mdl-button mdl-button--icon mdl-button--colored" onclick="deleteAlarm(${item.seq},this)">
							<i class="fas fa-times"></i>
						</button>
					</div>
				</div>
			</c:forEach>	
		
	</c:otherwise>
</c:choose>
 