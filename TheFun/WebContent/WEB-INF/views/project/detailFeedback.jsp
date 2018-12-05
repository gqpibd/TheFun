<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:requestEncoding value="utf-8"/> 

<link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css">
 
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

/* 별점 + 후기 */
.cont {
	width: 93%;
	max-width: 350px;
	text-align: center;
	margin: auto;
	padding: 15px 0;
	overflow: hidden;
}

div.stars {
	width: 270px;
	display: inline-block;
}

input.star {
	display: none;
}

label.star {
	float: right;
	padding: 10px;
	font-size: 36px;
	color: #444;
	transition: all .2s;
}

input.star:checked ~ label.star:before {
	content: '\f005';
	color: #FD4;
	transition: all .25s;
}

input.star-5:checked ~ label.star:before {
	color: #FE7;
	text-shadow: 0 0 20px #952;
}

input.star-1:checked ~ label.star:before {
	color: #F62;
}

label.star:hover {
	transform: rotate(-15deg) scale(1.3);
}

label.star:before {
	content: '\f006';
	font-family: FontAwesome;
}

.rev-box {
	overflow: hidden;
	height: 0;
	width: 100%;
	transition: all .25s;
}

textarea.review {
	border: 1px solid #adadad;
	resize: none;
	width: 100%;
	max-width: 100%;
	padding: 10px;
	box-sizing: border-box;	
	overflow-y: hidden; /* prevents scroll bar flash */
	padding: 0.7em; /* prevents text jump on Enter keypress */
	line-height: 1.1;
	border-radius: 3px;
	outline: none; /* 포커스 되었을 때 아웃라인 없앰 */
}

label.review {
	display: block;
	transition: opacity .25s;
}

input.star:checked ~ .rev-box {
	height: 125px;
	overflow: visible;
}

</style>

<p class="strongGray">피드백 <font class="pupple">n</font></p>
<img src="image/detail/writeBtn.jpg" width="100px" onclick="feedbackModal()" style="cursor:porinter">---나중에 마이페이지 완성되면 여기서 없애야함(지금 무조건 66번 구매로 저장)<br>
<hr>


<!-- 별점 및 후기 남기는 부분 -->
<div class="modal fade" id="feedbackModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header" style="display: unset;">
	      <h5 class="modal-title" id="exampleModalLabel">리워드에 대한 후기를 남겨주세요</h5>
	    </div>
		<div class="cont">
		<div class="stars">
		<form id="reviewForm" action="addReview.do" method="post">
		  <input type="hidden" name="seq" value="66"> <!-- buydto에 저장을 위한 임시 값 -->	
		  <input type="hidden" name="projectseq" value="${projectdto.seq}"> <!-- 이 페이지로 돌아오기 위해 프로젝트 번호 전달 -->	
		  <input class="star star-5" id="star-5-2" type="radio" name="score" value="5"/>
		  <label class="star star-5" for="star-5-2"></label>
		  <input class="star star-4" id="star-4-2" type="radio" name="score" value="4"/>
		  <label class="star star-4" for="star-4-2"></label>
		  <input class="star star-3" id="star-3-2" type="radio" name="score" value="3"/>
		  <label class="star star-3" for="star-3-2"></label>
		  <input class="star star-2" id="star-2-2" type="radio" name="score" value="2"/>
		  <label class="star star-2" for="star-2-2"></label>
		  <input class="star star-1" id="star-1-2" type="radio" name="score" value="1"/>
		  <label class="star star-1" for="star-1-2"></label>
		  <div class="rev-box">
		    <textarea class="review" col="30" name="bcomment" placeholder="제품에 대한 평가를 적어주세요"></textarea>		    
		  </div>
		</form>
		</div>
		</div>
		<div class="modal-footer">
	        <button type="button" class="cancel_btn" data-dismiss="modal" id="quit">취소</button>
	        <button type="button" class="fun_btn" onclick="checkAndSendReview()">후기 전송</button>	       
	    </div>
</div>
</div>
</div>
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
			console.log(data);
			
			var table = document.createElement('table');
			table.setAttribute("width", "100%");
			
			var items = data['reviews'];
			if(items.length>0){
				for (i = 0; i < items.length; i++) {
				  
			      var tr1 = document.createElement('tr');
			      var tr1Content = "<td align='left' class='strongGray'><span style='margin-right:10px'> <img src='${login.profile}' width='10' class='profile re-img' align='middle'>" + 
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
				  tr2.innerHTML = "<td colspan='2' align='left' class='liteGray'><b>"+ items[i].otitle +"</b>"+ items[i].ocontent +"</td>";
				  
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



// textarea 자동 크기 조절			
// 동적으로 생성된 태그에 이벤트를 적용하기 위해서는 $(document).on()으로 해줘야 한다.
// $(".wrap").on('keyup', 'textarea',function(e){ --> 이렇게 하면 원래 있던 태그에만 적용됨
$(document).on('keyup', 'textarea',".wrap",function(e){
	$(this).css('height', 'auto' );
	$(this).height( this.scrollHeight );
});
$('.wrap').find( 'textarea' ).keyup();

function feedbackModal(){
	$("#feedbackModal").modal('show');
}
function checkAndSendReview(){
	var score = $(":input:radio[name='score']:checked").val();
	var bcomment = $("textarea[name='bcomment']").val();
	console.log(score);
	console.log(bcomment);
	if(score == null){
		alert("평가를 남겨주세요");
	}
	$("#reviewForm").submit();
}
</script>