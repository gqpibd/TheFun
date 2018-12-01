<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:requestEncoding value="utf-8"/> 

<style type="text/css">

.list_reply{
	padding-inline-start: 5px;
}
.mtextarea {
	/* margin-left: 20px; */
	margin-top: 10px;
	width:100%;
	resize: none;
	overflow-y: hidden; /* prevents scroll bar flash */
	padding: 0.7em;  /* prevents text jump on Enter keypress */	
	line-height: 1.1;
	border-radius: 3px;
	outline:none; /* 포커스 되었을 때 아웃라인 없앰 */	
	height: 100%;
}
.reply{ /* 댓글 하나가 한 덩어리로 묶인다. */
	position: relative;
}

.reply_content{
	padding-left: 10px;
}

.list_reply li {
    overflow: hidden;
    position: relative;
    /* padding: 10px 10px 10px 20px; */
    /* padding-top: 5px;
    padding-bottom: 5px; */
    border-bottom: 1px solid #fff;
    width : 100%;
}
.re_reply { /* 대댓 */
    margin-left: 50px;
}

.re-img{ /* 댓글 프로필 */	
    width: 33px;
    height: 33px;
    border-radius: 33px;
    margin: 5px;
    vertical-align: middle;
}

.nickname {
    font-size: 20px;   
    font-weight: bold;
}
/* -------------reply btn---------------- */
.rereBtn {
    background-color: #ffffff;
    border-radius: 3px;
    border: 1px solid #dcdcdc;
    display: inline-block;
    cursor: pointer;
    color: #666666;
    font-family: Arial;
    font-size: 15px;
    font-weight: bold;
    padding: 5px 10px;
    text-shadow: 0px 1px 0px #ffffff;
}
.rereBtn:hover {
	background-color:#f6f6f6;
}
.rereBtn:focus {
	outline: none;
}

/*----------------툴팁----------------*/
.mtooltip {
    float: right; 
    position: relative;
    right:0;
    display: inline-block;
    padding: 10px;
}

.mtooltip .mtooltiptext{
    visibility: hidden;
    width: 80px;
    background-color: white;
    text-align: center;
    border-radius: 5px;
    padding: 3px 0;
    
    /* Position the tooltip */
    position: absolute;
    z-index: 1;
    top: -5px;
    right: 105%;
}

.mtooltip:hover .mtooltiptext {
    visibility: visible;
}
/*------------------------------------*/

.lablehover{
	width : 100%;
	cursor: pointer;
	border-radius: 50px;
} 
.lablehover:hover{
	background: #f3f3f3;
}

.img_clickable{
	cursor: pointer;
}

/*  비밀댓글 체크박스  */
*,
*::before,
*::after {
  transition: 400ms all ease-in-out 50ms;
  box-sizing: border-box;
  -webkit-backface-visibility: hidden;
          backface-visibility: hidden;
}

.hiddenCheckbox {
  display: none;
}
/*Button is :CHECKED*/

input[type="checkbox"]:checked ~ .checkDiv {
  background: rgba(73,168,68,1);
  box-shadow: 0 0 2px rgba(73,168,68,1);
}

input[type="checkbox"]:checked ~ .checkDiv .checkLabel {
  left: 37px;
  -webkit-transform: rotate(360deg);
          transform: rotate(360deg);
}


/*shared*/

.checkDiv, .checkLabel {
  border-radius: 50px;
}


/*'un':checked state*/

.checkDiv {
  height: 30px;
  width: 65px;
  background: rgba(43, 43, 43, 1);
  position: relative;  
  box-shadow: 0 0 2px rgba(43,43,43,1); 
  
}

.checkLabel {
  height: 25px;
  width: 25px;
  background: rgba(255, 255, 255, 1);
  position: absolute;
  top: 2px;
  left: 3px;
  cursor: pointer;
}

.checkLabel::before {
   content: '';
  height: 21px;
  width: 4px;
  position: absolute;
  top: calc(50% - 11px);
  left: calc(50% - 2px);
  -webkit-transform: rotate(45deg);
          transform: rotate(45deg);
}

.checkLabel::after {
 	content: '';
    height: 4px;
    width: 22px;
    position: absolute;
    top: calc(50% - 2px);
    left: calc(50% - 11px);
    -webkit-transform: rotate(45deg);
    transform: rotate(45deg);
}

.checkLabel::before,
.checkLabel::after{
  background: rgba(43,43,43,1);
  border-radius: 5px;
}

/* pesduo class on toggle */

input[type="checkbox"]:checked ~ .checkDiv .checkLabel::before{
  height: 17px;
  top: calc(55% - 10px);
  left: calc(60% - 2px);
  background: rgba(73,168,68,1);
}
input[type="checkbox"]:checked ~ .checkDiv .checkLabel::after{
  width: 9.5px;
  top: calc(95% - 10px);
  left: calc(22.5% - 3.5px);
  background: rgba(73,168,68,1);
}
</style>

<!-- 댓글 창 -->
<ul id="replies" class="list_reply"> 
	<c:choose>
	<c:when test="${qnaList eq null or qnaList.size() == 0}"><!-- list가 null 일 때 -->
		<li style="text-align: center;">등록된 댓글이 없습니다. 첫 번째 댓글을 남겨주세요</li>
	</c:when>
	<c:otherwise>	<!-- 댓글이 하나라도 있을 때 -->	
	<c:forEach items="${qnaList}" var="item" varStatus="vs">		
		<li class="reply">		
		<c:if test="${item.seq ne item.refseq}">	<!-- 대댓일 때 표시 --> 
		<!-- <i class="fas fa-reply" style="float: left; width: 20px; margin-right: 13px"></i> -->
 		<img src="image/detail/rere.png" style="float: left; width: 15px; margin-left: 13px; margin-right: 13px;">
		</c:if>
		<c:choose>
			<c:when test="${item.isDel()}">
				<div class="reply_content">삭제된 댓글입니다</div><hr>
			</c:when> 
			<c:when test="${item.isHidden() and (item.id ne login.id) and (login.id ne item.towhom) and (login.id ne projectdto.id)}"> <!-- 비밀댓글이고 못 볼때 -->				
				<div class="reply_content"><i class="fas fa-lock ml-2"></i>&nbsp;비밀 댓글입니다 </div><hr>
			</c:when> 
			<c:otherwise> <!-- 일반 댓글 -->
				<c:if test="${login ne null and item.id eq login.id}"> <!-- 작성자일 때 수정, 삭제 가능하게 -->
					<div class="mtooltip" align="right">
						<!-- <span> -->
						<img src="image/detail/more.png" aria-hidden="true" width="4px" align="right" style="cursor: pointer" >												
						<!-- <span class="fas fa-stroopwafel" aria-hidden="true" width="3px" align="right" style="cursor: pointer" ></span> -->
						
						<span class="mtooltiptext">
						<label class="lablehover" onclick="modify('${item.seq }','${item.content }','${item.isHidden()}')" id="${item.seq}" class="aTag">수정</label><br>
						<label class="lablehover" onclick="deleteReply(${item.seq})" class="aTag">삭제</label><br>						
						</span>
					</div> 
				</c:if>	
				<c:choose>
				<c:when test="${item.seq ne item.refseq}">
					<div style="margin-left: 30px" class="reply_content">				
				</c:when>
				<c:otherwise>
					<div class="reply_content">				
				</c:otherwise>
				</c:choose>
				<div>
				 	<img src="${item.profile}" class="profile re-img" width="10" align="middle">
				 	<font style="font-size: 17px; font-weight: bold;" >${item.nickname}</font>
					<c:if test="${item.id eq projectdto.id}"> <!-- 게시글 작성자 표시 -->  
				 		<!-- <img src="images/icons/writer.png" width="60"> --> 
				 		<span style="border-radius: 50px; border: 1px solid #8152f0; color: #8152f0; width: 90px; font-size: 5px; padding: 3px 6px 3px 6px"> 작성자 </span>
				 	</c:if>
				 	<c:if test="${item.isHidden()}">
				 		&nbsp;<i class="fas fa-lock" style="opacity: 0.5"></i>
				 	</c:if>
				 	
			 	</div>
			 	<div class="reply_content">
			 	<c:if test="${item.towhom ne null and item.towhom ne '' }"><!-- 다른 사람 호출하는 태그가 있을 때 --> 
					<b>@${item.towhomnickname}</b> 
				</c:if>
				 	${item.content}
				<br> 
				<font style="font-size: 3px; color: graytext;">${item.regdate}</font><br> <!-- 날짜 -->
				<c:if test="${login ne null}">
					<button class="rereBtn" name="${item.refseq}" onclick="addReply(this)" id="${item.seq}" toWhom="${item.id}" toWhomNick="${item.nickname}">답변</button>
				</c:if>				
				</div>
			</div>
			<hr>
			</c:otherwise>
		</c:choose>
		</li>
	</c:forEach>
	</c:otherwise>
	</c:choose>
</ul>
	<c:choose>
	
	<c:when test="${login eq null}"> <!-- 로그인 상태가 아니면 -->
		<div style="width:100%; text-align: center">댓글을 작성하려면 <label style="cursor: pointer;" onclick="location.href='login.do?callback=projectDetail.do?seq=${projectdto.seq}'"><b>로그인</b></label>해주세요</div>
	</c:when>
	<c:otherwise>
	<form action="addQna.do" id='newQna'>		
		<input type="hidden" name="id" value="${login.id}"> <!-- 작성자 아이디 --> 
		<input type="hidden" name="nickname" value="${login.nickname}"> <!-- 작성자 닉네임 : 알람 생성에 필요 --> 
		<input type="hidden" name="projectseq" value="${projectdto.seq }"> <!-- 관련 프로젝트 번호 -->		
		<input type="hidden" name="projectWriter" value="${projectdto.id }"> <!-- 프로젝트 작성자 아이디 -->
		<div align=left style="margin-left:5px">
			<img src='${login.profile}' width='10'
				class='profile re-img' align='middle'>
				<font style="font-size: 20px; font-weight: bold;">${login.nickname}</font>
		</div>		
		<textarea class="mtextarea" id="new_reply_content" placeholder="댓글을 작성해 주세요" name="content" style="height:50px;"></textarea>
		<div align=right>
			<table>
			<tr>
				<td>비밀글</td>
				<td>
					<input class="hiddenCheckbox" type="checkbox" id="toggleNormal" name='secret' />
					<div class="checkDiv">
					  <label class="checkLabel" for="toggleNormal"></label>			
					</div>
				</td>
				<td style="padding-left: 10px;">
					<button class="fun_btn" id="new_reply" type="button" onclick="checkAndSubmit(this)">등록</button>
				</td>
			</tr>
			</table>
		</div>
	</form>
	</c:otherwise>
	</c:choose>

<script type="text/javascript">

//textarea 자동 크기 조절			
// 동적으로 생성된 태그에 이벤트를 적용하기 위해서는 $(document).on()으로 해줘야 한다.
// $(".wrap").on('keyup', 'textarea',function(e){ --> 이렇게 하면 원래 있던 태그에만 적용됨
$(document).ready(function(){
	var origin; // 수정 전, 원래 있던거
	$('.mtextarea').css('height','50px');
	$(document).on('keyup', 'textarea',".wrap",function(e){
		$(this).css('height', 'auto' );
		$(this).height( this.scrollHeight );
	});
	$('.wrap').find( 'textarea' ).keyup();
});


function addReply(re_btn){       // 댓글에  추가
	$("#rere_write").remove();
	var refseq = $(re_btn).attr('name');
	var toWhom = $(re_btn).attr('toWhom');
	var toWhomNick = $(re_btn).attr('toWhomNick');
	
	var selector = "[name='" + refseq +"']";
	var item = "<li class='reply' id='rere_write'>"+	
		"<form action='addQna.do' id='addreply'>"+			
			"<input type='hidden' name='id' value='${login.id}'>" +
			"<input type='hidden' name='nickname' value='${login.nickname}'>" +
			"<input type='hidden' name='projectseq' value='${projectdto.seq}'>" +			
			"<input type='hidden' name='projectWriter' value='${projectdto.id }'>"+			
			"<input type='hidden' name='refseq' value='"+refseq+"'>" +
			"<input type='hidden' name='towhom' value='"+toWhom+"'>"+
			"<div align='left'>"+
				"<img src='${login.profile}' width='10' class='profile re-img' align='middle'>" +
				"<span class='nickname'>${login.nickname}</span>"+
				"<textarea class='mtextarea' id='writeReply' placeholder='"+toWhomNick+"님에게 댓글 작성' name='content' required></textarea>"+
				"<div align=right>"+
				"<table><tr><td>비밀글</td>"+
					"<td><input class='hiddenCheckbox' type='checkbox' id='toggleRere' name='secret'/>"+
						"<div class='checkDiv'><label class='checkLabel' for='toggleRere'></label></div></td>"	+		
					"<td style=padding-left: 10px;'><button class='fun_btn' type='button' onclick='checkAndSubmit(this)'>등록</button>"+
				"</td></tr></table>"+
			"</div></div><hr></form></li>";
	$(selector).last().parents().eq(2).after(item);
	console.log($(selector).text());
}  

//취소
function cancel(item,reSeq) {
	$(item).parents().eq(8).replaceWith("<li class='reply' >" + origin + "</li>");	
}

//댓글 삭제
function deleteReply(reSeq) {
	var check = confirm("정말 삭제하시겠습니까?");			
	if (check) {
		location.href = "delQna.do?seq=" + reSeq +"&projectseq=${projectdto.seq}";
	}
}

//댓글 수정
function modify(reSeq,content,status){
	var ischecked = "";
	if(status == 'true'){
		ischecked = "checked='checked'";
	}
	$("#mcancel").click();
	var item = "<li class='reply' ><div class='mwrap' align='center' style='padding: 10px;background: #fff;margin:auto' id='mmodify'>"+
	"<form action='updateQna.do' id='updateQna'>"+		
		"<input type='hidden' name='seq' value="+reSeq+">"+
		"<input type='hidden' name='projectseq' value=${projectdto.seq}>"+
		"<div align='left'>"+
			"<img src='${login.profile}' width='10' class='profile re-img' align='middle' >"+ 
			"<span class='nickname'>${login.nickname}</span>"+
			"<textarea class='mtextarea' id='updateReply' name='content'>"+content+"</textarea>"+
			"<div align=right>"+
			"<table> <tr><td>비밀글</td><td><input class='hiddenCheckbox' type='checkbox' id='toggleRere' name='secret' "+ ischecked+"/>"+
			"<div class='checkDiv'><label class='checkLabel' for='toggleRere'></label></div></td><td>"+
				"<button class='fun_btn' type='button' onclick='checkAndSubmit(this)'style='margin: 5px;'>수정</button></td><td>"+
				"<button class='fun_btn' type='button' style='margin: 5px;'onclick='deleteReply("+reSeq+")'>삭제</button></td><td>"+
				"<button id='mcancel' class='fun_btn' type='button' style='margin: 5px;'onclick='cancel(this,"+reSeq+")'>취소</button></td>"+
			"</tr></table>"
	"</div></div></form></div></li>";
	
	var selector = "label[id='" + reSeq +"']";
	origin = $(selector).parents().eq(2).html(); // 현재 내용 저장 --> 취소하면 돌아가야됨
	console.log(origin)
	$(selector).parents().eq(2).replaceWith(item);				
}

function checkAndSubmit(selector){
	if($(selector).closest("form").find("textarea").val() != ''){
		$(selector).closest("form").submit();
		//console.log($(selector).closest("form").find("textarea").val());
	}else{
		console.log("비었음!");
	}
}
</script>



