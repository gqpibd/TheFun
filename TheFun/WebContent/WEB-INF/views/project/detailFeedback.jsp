<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:requestEncoding value="utf-8"/> 

 
<title>디테일_피드백</title>
<style type="text/css">
.pupple {
	color: #8152f0;
	font-weight: bold;
}

.addreply {
	color: #8152f0;
	font-weight: bold;
	text-decoration: underline;
}

.strongGray {
	color: #5c5c5c;
	font-weight: bold;
}

.liteGray {
	color: #818181;
}
</style>

<p class="strongGray">피드백 <span class="pupple" id="feedbackCnt"></span></p>
<hr>

<div id="reviewBody">
	<div></div>
</div>

<script type="text/javascript">
$(document).ready(function(){
	setReviewList();
});
function setReviewList(){
	$.ajax({
		url:"selectReviewList.do", // 접근대상
		type:"get",		// 데이터 전송 방식
		data:"seq=${projectdto.seq}", // 전송할 데이터
		dataType :"json",
		success:function(data){
			//console.log(data);
			
			var table = document.createElement('table');
			table.setAttribute("width", "100%");
			
			var items = data['reviews'];
			$("#feedbackCnt").text(items.length);
			console.log($("#feedbackCnt").text());
			if(items.length>0){
				for (i = 0; i < items.length; i++) {
				  
			      var tr1 = document.createElement('tr');
			      var tr1Content = "<td align='left' class='strongGray'><span style='margin-right:10px'> <img src='"+items[i].profile+"' width='10' class='profile re-img' align='middle'>" + 
			      				  "<b style='font-size:1.5em'>"+ items[i].nickname +"</b></span>";
			      for(j=1;j<=5;j++){
			    	  if(items[i].score >= j){
			    		  tr1Content+= "<span class='fas fa-star' style='color:#8152f0;font-size:1.2em;'></span>";
			    	  }else{
			    		  tr1Content+= "<span class='far fa-star' style='color:#8152f0;font-size:1.2em;'></span>";
			    	  }
			      }
			      tr1Content += "</td>";
			      tr1.innerHTML += tr1Content;
			      
			      var tr2 = document.createElement('tr');	
				  tr2.innerHTML = "<td colspan='2' align='left' class='liteGray'><b>"+ items[i].otitle +"</b>&nbsp;"+ items[i].ocontent +"</td>";
				  
			      var tr3 = document.createElement('tr');
			      tr3.innerHTML = "<td colspan='2' align='left' class='strongGray'>"+ items[i].comment + "</td>";
			      var tr4 = document.createElement('tr');
			      tr4.innerHTML = "<td colspan='2' align='left' class='liteGray'><font style='font-size:13px'>"+ items[i].date + "</font></td>";
			      var tr5 = document.createElement('tr');
			      tr5.innerHTML = "<td colspan='2'><hr> </td>";
			      
			      table.appendChild(tr1);
			      table.appendChild(tr2);
			      table.appendChild(tr3);
			      table.appendChild(tr4);
			      table.appendChild(tr5);
			    }			
				
				var reviewBody = document.getElementById("reviewBody");
				reviewBody.replaceChild(table, reviewBody.childNodes[0]);
			}			
		},
		error:function(){ // 또는					 
			console.log("통신실패!");
		}
	});		
}




</script>