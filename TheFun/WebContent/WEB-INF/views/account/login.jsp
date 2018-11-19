<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width"/>
<title>The Fun_더 아름다운 세상을 위한 펀딩 로그인</title>
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script> <!-- 카카오로그인  -->
<script type="text/javascript" src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.0.js" charset="utf-8"></script><!-- 네이버 아이디로 로그인 -->
</head>
<body>
<div align="center">
<img src="image/main/banner.jpg" width="200px">
<table>
<tr>
	<td> <input type="text" name="id" value="아이디"> </td>
</tr>
<tr>
	<td><input type="text" name="pw" value="비밀번호"> </td>
</tr>
<tr>
	<td><input type="checkbox">아이디 저장  </td>
</tr>
<tr>
	<td><img src="image/login/loginBtn.jpg" width="130px"> </td>
</tr>
<tr>
	<td align="center">또는</td>
</tr>
<tr>
	<td> <!-- 카카오계정 -->	
	<a id="custom-login-btn" href="javascript:loginWithKakao()">
	<img src="image/login/kakao_login_btn_medium.png" onmouseover="this.src='image/login/kakao_login_btn_medium_ov.png'"
	onmouseleave="this.src='image/login/kakao_login_btn_medium.png'"/>
	</a>
	<script type='text/javascript'>	 
	    // 사용할 앱의 JavaScript 키를 설정해 주세요.
	    Kakao.init('dd0c44a9e5b9f94ce480a440c3113d2d');
	    // 카카오 로그인 버튼을 생성합니다.
		  
		function loginWithKakao() {
			// 로그인 창을 띄웁니다.
			Kakao.Auth.login({
				success : function(authObj) {
					Kakao.API.request({
						url : '/v1/user/me',
						success : function(res) {
							console.log(res.id);//<---- 콘솔 로그에 id 정보 출력(id는 res안에 있기 때문에  res.id 로 불러온다)
							//console.log(res.kaccount_email);//<---- 콘솔 로그에 email 정보 출력 (어딨는지 알겠죠?)
							console.log(res.properties['nickname']);//<---- 콘솔 로그에 닉네임 출력(properties에 있는 nickname 접근 
							// res.properties.nickname으로도 접근 가능 )
							console.log(authObj.access_token);//<---- 콘솔 로그에 토큰값 출력
							location.href="loginAf.do?id=" + res.id +"&nickname=" + res.properties['nickname'];
						}
					})
				},
				fail : function(err) {
					alert(JSON.stringify(err));
				}
			});
		};
	</script>
	</td>
	<td>
	<div id="naverIdLogin"></div>
	<!-- //네이버아이디로로그인 버튼 노출 영역 -->
	
	<!-- 네이버아디디로로그인 초기화 Script -->
	<script type="text/javascript">
		var naverLogin = new naver.LoginWithNaverId(
			{
				clientId: "vb6UHNxUFoBsi487fDmI",
				callbackUrl: "http://localhost:8090/TheFun/",
				isPopup: false, /* 팝업을 통한 연동처리 여부 */
				loginButton: {color: "green", type: 3, height: 60} /* 로그인 버튼의 타입을 지정 */
			}
		);
		
		/* 설정정보를 초기화하고 연동을 준비 */
		naverLogin.init();
		
	</script>
	</td>
</tr>
<tr>
	<td>아직도 더펀 계정이 없으신가요? <a href="#"> <font color="#8152f0">회원가입</font></a>
	</td>
</tr>
</table>
</div>
</body>
</html>