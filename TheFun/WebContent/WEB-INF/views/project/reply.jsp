<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
   
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>


<!-- 댓글 창 -->
<ul>
	<li>
		<img src="image/icons/rere.png" style="float: left; width: 20px; margin-right: 13px">
			<div>삭제된 댓글입니다.</div>
			
			<div align="right">
				<img src="image/icons/more.png" width="3px" align="right">
				<span>
				<label onclick="">수정</label><br>
				<label onclick="">삭제</label><br> 
				</span>
			</div>
			<div style="margin-left: 30px">
			<div>
				<div>
				<img src="" width="10" align="middle"
				onerror="this.src=''" onclick="">
				<font style="font-size: 17px; font-weight: bold;"></font>
				<img src="image/icons/writer.png" width="60">
				</div>
				
				<div>
					<b></b>
					<br>
					<font style="font-size: 3px;" color=" graytext"></font><br>
						<button name="" onclick="" id="" toWhom="">답변</button>			
				
				</div>
			</div>
		
	</li>
	
	<li>등록된 댓글이 없습니다. 첫 번째 댓글을 남겨주세요.</li>

</ul>

<div align="center" style="width: 90%; margin: auto;" >
	댓글을 작성하려면<label style="cursor: pointer;" onclick="login.jsp"><b>로그인</b></label>을 해주세요.

	<form action="QnaController">
		<input type="hidden" name="" value="">
		<input type="hidden" name="" value="">
		<input type="hidden" name="" value="">
		
		<div>
			<img src='image/profiles/.png' width="10" class="" align="middle"
			onerror="this.src='image/profiles/default.png'">
			<font style="font-size: 20px; font-weight: bold;"></font>
		</div>
		
		<textarea id="" placeholder="댓글을 작성해 주세요." name=""></textarea>
	
		<div align="right" style="padding: 10px;">
			<button type="submit" class="" id="">등록</button>
		</div>
	</form>
</div>






<script type="text/javascript">

//textarea 자동 크기 조절			
// 동적으로 생성된 태그에 이벤트를 적용하기 위해서는 $(document).on()으로 해줘야 한다.
// $(".wrap").on('keyup', 'textarea',function(e){ --> 이렇게 하면 원래 있던 태그에만 적용됨
$(document).on('keyup', 'textarea',".wrap",function(e){
	$(this).css('height', 'auto' );
	$(this).height( this.scrollHeight );
});
$('.wrap').find( 'textarea' ).keyup();


function addReply(re_btn){       // 댓글 추가
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

//취소
function cancel(item,reSeq) {
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

</script>








</body>
</html>