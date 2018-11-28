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
	font-family: "Nanum Gothic", sans-serif;
}

.addreply {
	color: #8152f0;
	font-weight: bold;
	text-decoration: underline;
	font-family: "Nanum Gothic", sans-serif;
}

.strongGray {
	color: #5c5c5c;
	font-weight: bold;
	font-family: "Nanum Gothic", sans-serif;
}

.liteGray {
	color: #818181;
	font-family: "Nanum Gothic", sans-serif;
}

/* 별점 + 후기 */
.cont {
	width: 93%;
	max-width: 350px;
	text-align: center;
	margin: 4% auto;
	padding: 30px 0;
	/* background: #111; */
	/* color: #EEE;  */
	/* border-radius: 5px; */
	/* border: thin solid #444; */
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
	/* background: #222; */
	border: 1px solid #222;
	resize: none;
	width: 100%;
	max-width: 100%;
	/* height: 100px; */
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
<img src="image/detail/writeBtn.jpg" width="100px"> <br>
<hr>


<!-- 별점 및 후기 남기는 부분 -->
<div class="cont">
<div class="stars">
<form action="">	
  <input class="star star-5" id="star-5-2" type="radio" name="star"/>
  <label class="star star-5" for="star-5-2"></label>
  <input class="star star-4" id="star-4-2" type="radio" name="star"/>
  <label class="star star-4" for="star-4-2"></label>
  <input class="star star-3" id="star-3-2" type="radio" name="star"/>
  <label class="star star-3" for="star-3-2"></label>
  <input class="star star-2" id="star-2-2" type="radio" name="star"/>
  <label class="star star-2" for="star-2-2"></label>
  <input class="star star-1" id="star-1-2" type="radio" name="star"/>
  <label class="star star-1" for="star-1-2"></label>
  <div class="rev-box">
    <textarea class="review" col="30" name="review"></textarea>
    <label class="review" for="review">후기를 적어주세요</label>
  </div>
</form>
</div>
</div>

<table style="width: 100%">
<tr>
	<td colspan="2" align="left" class="strongGray">댓글 title</td>
</tr>
<tr>
	<td colspan="2" align="left" class="liteGray">댓글 content</td>
</tr>
<tr>
	<td align="left" class="liteGray">작성자 이름</td>
	<td align="right" class="addreply"> 답글달기</td>
	
</tr>
<tr>
	<td colspan="2"><hr> </td>
</tr>
</table>
<script type="text/javascript">
// textarea 자동 크기 조절			
// 동적으로 생성된 태그에 이벤트를 적용하기 위해서는 $(document).on()으로 해줘야 한다.
// $(".wrap").on('keyup', 'textarea',function(e){ --> 이렇게 하면 원래 있던 태그에만 적용됨
$(document).on('keyup', 'textarea',".wrap",function(e){
	$(this).css('height', 'auto' );
	$(this).height( this.scrollHeight );
});
$('.wrap').find( 'textarea' ).keyup();
</script>