<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:requestEncoding value="utf-8"/> 

<style type="text/css">

textarea {
	/* margin-left: 20px; */
	margin-top: 10px;
	width:100%;
	resize: none;
	overflow-y: hidden; /* prevents scroll bar flash */
	padding: 0.7em;  /* prevents text jump on Enter keypress */	
	line-height: 1.1;
	border-radius: 3px;
	outline:none; /* 포커스 되었을 때 아웃라인 없앰 */	
}
.reply{ /* 댓글 하나가 한 덩어리로 묶인다. */
	position: relative;
}

.list_reply li {
    overflow: hidden;
    position: relative;
    padding: 10px 20px 10px 20px;
    border-bottom: 1px solid #fff;
    width : 90%;
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
</style>

<!-- 댓글 창 -->
<ul id="replies" class="list_reply"> 
	<c:choose>
	<c:when test="${qnaList ne null}">	<!-- 댓글이 하나라도 있을 때 -->
	<c:forEach items="${qnaList}" var="item" varStatus="vs">		
		<li class="reply">		
		<c:if test="${item.seq ne re.refseq}">	<!-- 대댓일 때 표시 --> 
		<img src="images/icons/rere.png" style="float: left; width: 20px; margin-right: 13px">
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
						<span class="glyphicon glyphicon-option-vertical " aria-hidden="true" width="3px" align="right" style="cursor: pointer" ></span>						
						<span class="mtooltiptext">
						<label onclick="modify('${item.seq }','${item.content }')" id="${item.seq}" class="aTag">수정</label><br>
						<label onclick="deleteReply(${item.seq})" class="aTag">삭제</label><br>						
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
				 	<img src="${item.profile}" class="profile re-img img_clickable" width="10" align="middle" 
				 	onerror="this.src='image/profile/default.jpg'" onclick="location.href='MemberController?command=userPage&id=${item.id}'">
				 	<font style="font-size: 17px; font-weight: bold;" >${item.id} 이름으로 수정</font>
					<c:if test="${item.id eq projectdto.id}"> <!-- 게시글 작성자 표시 -->  
				 		<img src="images/icons/writer.png" width="60"> 
				 	</c:if>
			 	</div>
			 	<div class="reply_content">
				 	${item.content}
				<br> 
				<font style="font-size: 3px; color: graytext;">${item.regdate}</font><br> <!-- 날짜 -->
				<c:if test="${login ne null}">
					<button class="btn btn-navy btn-border" name="${item.refseq }" onclick="addReply(this)" id="${item.seq}" toWhom="${item.id}">답변</button>
				</c:if>				
				</div>
			</div>
			</c:otherwise>
		</c:choose>
		</li>
	</c:forEach>
	</c:when> 	
	<c:otherwise><!-- list가 null 일 때 -->
		<li>등록된 댓글이 없습니다. 첫 번째 댓글을 남겨주세요</li>
	</c:otherwise>
	</c:choose>
</ul>

<div class="wrap" align="center" style="width: 90%; margin:auto">
	<c:choose>
	
	<c:when test="${login eq null}"> <!-- 로그인 상태가 아니면 -->
		댓글을 작성하려면 <label style="cursor: pointer;" onclick="loginView()"><b>로그인</b></label>해주세요
	</c:when>
	<c:otherwise>
	<form action="ReplyController">
		<input type="hidden" name="command" value="addReply"> 
		<input type="hidden" name="id" value="${login.id}"> 
		<input type="hidden" name="pdsSeq" value="${projectdto.seq }">
		<div align=left style="margin-left:5px">
			<img src='${login.profile}' width='10'
				class='profile re-img' align='middle'
				onerror="this.src='images/profiles/default.png'" ><font style="font-size: 20px; font-weight: bold;">${login.nickname}</font>
		</div>
		<textarea id="new_reply_content" placeholder="댓글을 작성해 주세요" name="content"></textarea>
		<div align=right style="padding: 10px">
			<button class="mybtn" id="new_reply" type="submit">등록</button>
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
	$(document).on('keyup', 'textarea',".wrap",function(e){
		$(this).css('height', 'auto' );
		$(this).height( this.scrollHeight );
	});
	$('.wrap').find( 'textarea' ).keyup();
});

<%-- function addReply(re_btn){       // 댓글 추가
	$("#rere_write").remove();
	var name = $(re_btn).attr('name');
	var toWhom = $(re_btn).attr('toWhom');
	var selector = "[name='" + name +"']";
				
	$.ajax({
		url:"reply.jsp", // 접근대상
		type:"get",		// 데이터 전송 방식
		data:"command=rere&id=<%=id%>&pdsSeq=<%=pds.getSeq()%>&toWhom="+toWhom+"&reRef="+name, 
		success:function(data, status, xhr){
			console.log(data);
			$(selector).last().parents().eq(2).after(data).trigger("create");
		},
		error:function(){ // 또는					 
			console.log("통신실패!");
		}
	});	

}  
 --%>
//취소
<%-- function cancel(item,reSeq) {
	$.ajax({
		url:"reply.jsp", // 접근대상
		type:"get",		// 데이터 전송 방식
		data:"command=cancel&loginId=<%=id%>&pdsWriter=<%=pds.getId()%>&reSeq="+reSeq, 
		success:function(data, status, xhr){
			//console.log(data.trim());
			console.log($(this).parents().eq(5));
			$(item).parents().eq(4).replaceWith(data.trim());
		},
		error:function(){ // 또는					 
			console.log("통신실패!");
		}
	});	
}

//댓글 삭제
function deleteReply(reSeq) {
	var check = confirm("정말 삭제하시겠습니까?");			
	if (check) {
		location.href = "ReplyController?command=delete&reSeq=" + reSeq + "&pdsSeq=" + <%=pds.getSeq()%>;
	}
}

//댓글 수정
function modify(reSeq,content){ 			
	console.log(reSeq);
	var selector = "label[id='" + reSeq +"']";					
	$.ajax({
		url:"reply.jsp", // 접근대상
		type:"get",		// 데이터 전송 방식
		data:"command=modify&id=<%=id%>&pdsSeq=<%=pds.getSeq()%>&content="+content +"&reSeq="+reSeq, 
		success:function(data, status, xhr){
			//console.log(data.trim());
			$(selector).parents().eq(2).replaceWith(data.trim());
		},
		error:function(){ // 또는					 
			console.log("통신실패!");
		}
	});			
}
 --%>
</script>



