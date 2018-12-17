<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:requestEncoding value="utf-8"/> 

<title>디테일_후원자</title>
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

<p class="strongGray">기부 내역 <span class="pupple" id="supportCnt"></span>건</p>
<hr>

<div id="reviewBody">
	<div></div>
</div>

<script type="text/javascript">
function setReviewList(){
	$.ajax({
		url:"selectDonationList.do", // 접근대상
		type:"get",		// 데이터 전송 방식
		data:"seq=${projectdto.seq}", // 전송할 데이터
		dataType :"json",
		success:function(data){
			//console.log(data);
			
			var table = document.createElement('table');
			table.setAttribute("width", "100%");
			
			var items = data['supporters'];
			$("#supportCnt").text(items.length);
			//console.log($("#feedbackCnt").text());
			if(items.length>0){
				for (i = 0; i < items.length; i++) {				  
			      var tr1 = document.createElement('tr');
			      var tr1Content = "<td align='left' class='strongGray'><span style='margin-right:10px'> <img src='"+items[i].profile+"' class='profile re-img' align='middle'>" + 
			      				  "<b style='font-size:1.2em'>"+ items[i].nickname +"</b>님이 <span style='color:#8152f0; font-weight:bold'>" + numberWithCommas(items[i].price) +"</span>원 후원하셨습니다.</span>";			      
			      tr1Content += "</td>";
			      tr1.innerHTML += tr1Content;
			      var tr2 = document.createElement('tr');
			      tr2.innerHTML = "<td colspan='2' align='left' class='liteGray'><font style='font-size:13px'>"+ items[i].date + "</font></td>";
			      var tr3 = document.createElement('tr');
			      tr3.innerHTML = "<td colspan='2'><hr> </td>";
			      
			      table.appendChild(tr1);
			      table.appendChild(tr2);	
			      table.appendChild(tr3);			      
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

//1000단위 , 찍기
function numberWithCommas(x) {
     return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}
</script>