<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:requestEncoding value="utf-8"/> 

<style type="text/css">

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

.list_reply li {
    overflow: hidden;
    position: relative;
    padding: 10px 20px 10px 20px;
    border-bottom: 1px solid #fff;
    width : 100%;
}
.re_reply { /* 대댓 */
    margin-left: 60px;
}

.re-img{ /* 댓글 프로필 */	
    width: 33px;
    height: 33px;
    border-radius: 33px;
    margin: 5px;
    vertical-align: middle;
}
.reply_content {
    display: block;
    float: none;
    padding: 0 28px 0 40px;
}
.nickname {
    font-size: 20px;   
    font-weight: bold;
}


/*----------------툴팁----------------*/
.mtooltip {
    position: absolute;
    right:0;
    display: inline-block;
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
	border-radius: 100%;
} 
.lablehover:hover{
	background: #f3f3f3;
}

.img_clickable{
	cursor: pointer;
}
</style>

<!-- 댓글 창 -->
<ul id="replies" class="list_reply"> 
	<c:choose>
	<c:when test="${qnaList eq null or qnaList.size() == 0}"><!-- list가 null 일 때 -->
		<li>등록된 댓글이 없습니다. 첫 번째 댓글을 남겨주세요</li>
	</c:when>
	<c:otherwise>	<!-- 댓글이 하나라도 있을 때 -->	
	<c:forEach items="${qnaList}" var="item" varStatus="vs">		
		<li class="reply">		
		<c:if test="${item.seq ne item.refseq}">	<!-- 대댓일 때 표시 --> 
		<!-- <i class="fas fa-reply" style="float: left; width: 20px; margin-right: 13px"></i> -->
 		<img src="image/detail/rere.png" style="float: left; width: 20px; margin-right: 13px">
		</c:if>
		<c:choose>
			<c:when test="${item.isDel()}">
				<div class="reply_content">삭제된 댓글입니다</div>
			</c:when> 
			<c:when test="${item.isHidden()}"> <!-- 일단 무조건 안보임.. 나중에 권한 검사 추가 -->
				<div class="reply_content">비밀 댓글입니다</div>
			</c:when> 
			<c:otherwise> <!-- 일반 댓글 -->
				<c:if test="${login ne null and item.id eq login.id}"> <!-- 작성자일 때 수정, 삭제 가능하게 -->
					<div class="mtooltip" align="right">
						<!-- <span> -->
						<img src="image/detail/more.png" aria-hidden="true" width="4px" align="right" style="cursor: pointer" >												
						<!-- <span class="fas fa-stroopwafel" aria-hidden="true" width="3px" align="right" style="cursor: pointer" ></span> -->
						
						<span class="mtooltiptext">
						<label class="lablehover" onclick="modify('${item.seq }','${item.content }')" id="${item.seq}" class="aTag">수정</label><br>
						<label class="lablehover" onclick="deleteReply(${item.seq})" class="aTag">삭제</label><br>						
						</span>
					</div> 
				</c:if>	
				<c:choose>
					<c:when test="${item.seq ne item.refseq}"> <!-- 대댓일 때 들여쓰기 -->
						<div style="margin-left: 30px">				
					</c:when>
					<c:otherwise>
						<div>				
					</c:otherwise>
				</c:choose>
				<div>
				 	<img src="${item.profile}" class="profile re-img img_clickable" width="10" align="middle" onclick="location.href='MemberController?command=userPage&id=${item.id}'">
				 	<font style="font-size: 17px; font-weight: bold;" >${item.nickname}</font>
					<c:if test="${item.id eq projectdto.id}"> <!-- 게시글 작성자 표시 -->  
				 		<img src="images/icons/writer.png" width="60"> 
				 	</c:if>
			 	</div>
			 	<div class="reply_content">
			 	<c:if test="${item.towhom ne null and item.towhom ne '' }"><!-- 다른 사람 호출하는 태그가 있을 때 --> 
					<b>@${item.towhom}</b> 
				</c:if>
				 	${item.content}
				<br> 
				<font style="font-size: 3px; color: graytext;">${item.regdate}</font><br> <!-- 날짜 -->
				<c:if test="${login ne null}">
					<button class="btn btn-navy btn-border" name="${item.refseq}" onclick="addReply(this)" id="${item.seq}" toWhom="${item.id}">답변</button>
				</c:if>				
				</div>
				<hr>
			</div>
			</c:otherwise>
		</c:choose>
		</li>
	</c:forEach>
	</c:otherwise>
	</c:choose>
</ul>
<div class="mwrap" align="center" style="margin:auto">
	<c:choose>
	
	<c:when test="${login eq null}"> <!-- 로그인 상태가 아니면 -->
		댓글을 작성하려면 <label style="cursor: pointer;" onclick="location.href='login.do?callback=projectDetail.do?seq=${projectdto.seq}'"><b>로그인</b></label>해주세요
	</c:when>
	<c:otherwise>
	비밀댓글 표시필요!!
	<form action="addQna.do" id='newQna'>		
		<input type="hidden" name="id" value="${login.id}"> <!-- 작성자 아이디 --> 
		<input type="hidden" name="projectseq" value="${projectdto.seq }"> <!-- 관련 프로젝트 번호 -->		
		<div align=left style="margin-left:5px">
			<img src='${login.profile}' width='10'
				class='profile re-img' align='middle'>
				<font style="font-size: 20px; font-weight: bold;">${login.nickname}</font>
		</div>		
		<textarea class="mtextarea" id="new_reply_content" placeholder="댓글을 작성해 주세요" name="content" style="height:50px;"></textarea>
		<div align=right style="padding: 10px">
			<button class="fun_btn" id="new_reply" type="button" onclick="checkAndSubmit(this)">등록</button>
		</div>
	</form>
	</c:otherwise>
	</c:choose>
</div>
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


function addReply(re_btn){       // 댓글에 답글 추가
	$("#rere_write").remove();
	var refseq = $(re_btn).attr('name');
	var toWhom = $(re_btn).attr('toWhom');
	var selector = "[name='" + refseq +"']";
	var item = "<li class='reply' id='rere_write'>"+
	"<div class='mwrap' align='center' style='adding: 10px;background: #fff;margin:auto' >"+
		"<form action='addQna.do' id='addreply'>"+			
			"<input type='hidden' name='id' value='${login.id}'>" +
			"<input type='hidden' name='projectseq' value='${projectdto.seq}'>" +
			"<input type='hidden' name='refseq' value='"+refseq+"'>" +
			"<input type='hidden' name='towhom' value='"+toWhom+"'>"+
			"<div align='left'>"+
				"<img src='${login.profile}' width='10' class='profile re-img' align='middle'>" +
				"<span class='nickname'>${login.nickname}</span>"+
				"<textarea class='mtextarea' id='writeReply' placeholder='"+toWhom+"님에게 댓글 작성' name='content' required></textarea>"+
				"<div align=right style='padding: 10px'>"+
					"<button class='fun_btn' type='button' onclick='checkAndSubmit(this)'>등록</button>"+
	"</div></div></form></div></li>";
	$(selector).last().parents().eq(2).after(item);
	console.log($(selector).text());
}  

//취소
function cancel(item,reSeq) {
	$(item).parents().eq(3).replaceWith(origin);	
}

//댓글 삭제
function deleteReply(reSeq) {
	var check = confirm("정말 삭제하시겠습니까?");			
	if (check) {
		location.href = "delQna.do?seq=" + reSeq +"&projectseq=${projectdto.seq}";
	}
}

//댓글 수정
function modify(reSeq,content){ 	
	$("#mcancel").click();
	var item = "<li class='reply' id='mmodify'>"+
	"<div class='mwrap' align='center' style='padding: 10px;background: #fff;margin:auto' >"+
	"<form action='updateQna.do' id='updateQna'>"+		
		"<input type='hidden' name='seq' value="+reSeq+">"+
		"<input type='hidden' name='projectseq' value=${projectdto.seq}>"+
		"<div align='left'>"+
			"<img src='${login.profile}' width='10' class='profile re-img' align='middle' >"+ 
			"<span class='nickname'>${login.nickname}</span>"+
			"<textarea class='mtextarea' id='updateReply' name='content'>"+content+"</textarea>"+
			"<div align=right style='padding: 10px'>"+
				"<button class='fun_btn' type='button' onclick='checkAndSubmit(this)'style='margin: 5px;'>수정</button>"+
				"<button class='fun_btn' type='button' style='margin: 5px;'onclick='deleteReply("+reSeq+")'>삭제</button>"+
				"<button id='mcancel' class='fun_btn' type='button' style='margin: 5px;'onclick='cancel(this,"+reSeq+")'>취소</button>"+
	"</div></div></form></div></li>";
	
	var selector = "label[id='" + reSeq +"']";
	origin = $(selector).parents().eq(2).html(); // 현재 내용 저장 --> 취소하면 돌아가야됨
	//console.log(origin)
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



