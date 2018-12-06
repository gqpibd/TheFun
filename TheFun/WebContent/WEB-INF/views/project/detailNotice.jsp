<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:requestEncoding value="utf-8"/> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<style type="text/css">
 .pupple{
 font-family: "Nanum Gothic", sans-serif;
 	color:#8152f0;
 	font-weight: bold;
 }
 .strongGray{
 font-family: "Nanum Gothic", sans-serif;
  color: #5c5c5c;
  font-weight: bold;
  
 }
 .liteGray{
 font-family: "Nanum Gothic", sans-serif;
	 color: #818181;
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
</style>
<table style="width: 100%">
<tr>
	<td align="left" class="strongGray">판매자 공지 <strong class="pupple" id="noticecount">${projectdto.noticecount}</strong>건</td>
	
	<!-- if 작성자라면 공지 작성 가능-->
	<c:if test="${login ne null and login.id eq projectdto.id}">
		<td align="right" class="pupple"> <img src="image/detail/writeBtn.jpg" width="100px" style="cursor: pointer" onclick="openNoticeModal()"> </td>
	</c:if>
	<!-- if부분 -->
</tr>
</table>

 <!-- main content -->

<br><br>

<table id="noticeTable">
<c:forEach items="${noticeInfo }" var="notice" varStatus="status">
	<fmt:parseDate value="${notice.regdate}" var="dateFmt" pattern="yyyy-MM-dd HH:mm:ss"/>
	
	<tr style='height: 50px; vertical-align: bottom;'>
		<td class="strongGray">
			<font class="pupple" style="font-weight: bold;">#${noticeInfo.size() - status.count +1}</font>&nbsp;${notice.title }
		</td>
	</tr>
	<tr>
		<td>
			<font class="liteGray" size="2px">
				작성일 : <fmt:formatDate value="${dateFmt}" pattern="yyyy년MM월dd일 HH시mm분"/>
			</font>
		</td>
	</tr>
	<tr>
		<td class="liteGray">${notice.content }<br></td>
	</tr>
	
</c:forEach>

</table>

<script type="text/javascript">
function checkAndSubmitNotice(){
	var ntitle = $("#noticeTitle").val().trim();
	var ncontent = $("#newNoticeContent").val().trim();
	if(ntitle == ''){
		alert("제목을 입력해 주세요");
		return;
	}else if(ncontent == ''){
		alert("내용을 입력해 주세요");
		return;
	}else{
		var newNoticeData = {
			projectseq: '${projectdto.seq}',
			title: ntitle,
			content: ncontent
		};
		console.log(newNoticeData);		
		$.ajax({
			dataType:'json',
			type:"post",
			url:"addNotice.do",
			//data:"projectseq=${projectdto.seq}&title=" + title + "&content=" + content,
			data:newNoticeData,
			async:true, // 비동기
			success:function(data){ // 번호를 받자			
					alert("공지가 등록되었습니다.");					
					$("#exit").click();
					$("#noticeTable").prepend(
							"<tr style='height: 50px; vertical-align: bottom;'><td class=strongGray'><font class='pupple' style='font-weight: bold;'>#"+
							data.number + "</font>&nbsp;" + ntitle +"</td></tr>" +
							"<tr><td><font class='liteGray' size='2px'> 작성일 : " + data.date + "</font>" +
							"</td></tr>"+
							"<tr><td class='liteGray'>"+ncontent+"<br></td></tr>"
							); 
					$("#noticecount").text(data.number);
					$("#noticecounttab").html("<b>"+data.number+"</b>");
			},
			error:function(req, stu, err){
				alert("통신실패");
			}		
		});	
	}	
}

function openNoticeModal() {
	$("#noticeModal").modal('show');
}
</script>

<div class="modal fade" id="noticeModal" tabindex="-1" role="dialog" aria-labelledby="noticeModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="noticeModalLabel"><b>공지사항 작성</b></h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>     
      <div class="modal-body">
          <div class="form-group">
            <label for="recipient-name" class="col-form-label">제목</label>
            <input type="text" class="form-control" id="noticeTitle" name="title">
          </div>
          <div class="form-group">
            <label for="message-text" class="col-form-label">내용</label>
            <textarea class="form-control" id="newNoticeContent" name="content"></textarea>
          </div>       
      </div>
      <div class="modal-footer">
        <button type="button" class="btn cancel_btn" data-dismiss="modal" id="exit">취소</button>
        <button type="button" class="btn fun_btn" onclick="checkAndSubmitNotice()">공지 등록</button>
      </div>
    </div>
  </div>
</div>