package donzo.thefun.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import donzo.thefun.model.MemberDto;
import donzo.thefun.service.MemberService;


@Controller
public class MemberController {
	
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
	
	@Autowired
	MemberService memberService;	
	
	// 로그인 처리
	@RequestMapping(value="loginAf.do", method= {RequestMethod.GET, RequestMethod.POST}) 
	public String loginAf(HttpServletRequest req, Model model, MemberDto dto, String loginType) {
		logger.info("MemberController loginAf " + new Date());
		logger.info(dto.toString());
		logger.info(loginType);
		if(dto.getPwd() != null && loginType.equals("normal")) { // 계정 연동 로그인이 아닌 경우
			dto = memberService.tryLogin(dto);
			if(dto == null) { // 로그인 실패
				return "redirect:/login.do?message=retry";
			}
		}else if(loginType.equals("externalAccount")){ // 계정 연동 로그인인 경우
			logger.info("로그인 결과:" + dto);
			dto = memberService.tryLogin(dto);
		}
		req.getSession().setAttribute("login", dto);
		return "redirect:/main.do";
	}
	
	// 네이버 로그인 처리
	/*@RequestMapping(value = "naverLogin.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String naverLogin(HttpServletRequest request, HttpServletResponse resp, MemberDto dto, String loginType) {
		logger.info("MemberController loginAf " + new Date());
		PrintWriter out;
		try {
			out = resp.getWriter();
		
		
			String clientId = "vb6UHNxUFoBsi487fDmI";// 애플리케이션 클라이언트 아이디값";
			String clientSecret = "nQ5HvM2rRQ";// 애플리케이션 클라이언트 시크릿값";
			String code = request.getParameter("code");
			String state = request.getParameter("state");
			String redirectURI;
			
			redirectURI = URLEncoder.encode("http://localhost:8090/TheFun/naverLogin.do", "UTF-8");
			
			String apiURL;
			apiURL = "https://nid.naver.com/oauth2.0/token?grant_type=authorization_code&";
			apiURL += "client_id=" + clientId;
			apiURL += "&client_secret=" + clientSecret;
			apiURL += "&redirect_uri=" + redirectURI;
			apiURL += "&code=" + code;
			apiURL += "&state=" + state;
			//String access_token = "";
			//String refresh_token = "";
			System.out.println("apiURL=" + apiURL);
		
			URL url = new URL(apiURL);
			HttpURLConnection con = (HttpURLConnection) url.openConnection();
			con.setRequestMethod("GET");
			int responseCode = con.getResponseCode();
			BufferedReader br;
			System.out.print("responseCode=" + responseCode);
			if (responseCode == 200) { // 정상 호출
				br = new BufferedReader(new InputStreamReader(con.getInputStream()));
			} else { // 에러 발생
				br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
			}
			String inputLine;
			StringBuffer res = new StringBuffer();
			while ((inputLine = br.readLine()) != null) {
				res.append(inputLine);
			}
			br.close();
			if (responseCode == 200) {
				out.println(res.toString());
			}
		} catch (Exception e) {
			System.out.println(e);
		}
		request.getSession().setAttribute("login", dto);
		return "redirect:/main.do";
	}*/
	
	// 로그아웃 처리
	@RequestMapping(value="logout.do", method= {RequestMethod.GET, RequestMethod.POST}) 
	public String logout(HttpServletRequest req) {
		logger.info("MemberController logout " + new Date());		
		req.getSession().invalidate();
		return "redirect:/main.do";
	}
	
	// 회원가입 처리
	@RequestMapping(value="regiAf.do", method= {RequestMethod.GET, RequestMethod.POST}) 
	public String regiAf(HttpServletResponse resp, MemberDto dto) {
		logger.info("MemberController regiAf " + new Date());
		logger.info("MemberController dto = " + dto);
		if(memberService.addAccount(dto)) {
			try {
				resp.getWriter().println("<script>alert('회원가입이 완료되었습니다. 로그인 해주세요')</script>");
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return "redirect:/login.do";
	}

	/*-------------Ajax--------------*/
	// 아이디 중복 검사
	@ResponseBody
	@RequestMapping(value="idCheck.do", method= {RequestMethod.GET, RequestMethod.POST}) 
	public String idCheck(String id) {
		logger.info("MemberController idCheck " + new Date());
		String result = "OK";
		if(memberService.idExists(id)) {
			result = "NOTOK";
		}
		return result;
	}
	
	// 이메일 중복 검사
	@ResponseBody
	@RequestMapping(value="emailCheck.do", method= {RequestMethod.GET, RequestMethod.POST}) 
	public String emailCheck(String email) {
		logger.info("MemberController emailCheck " + new Date());
		String result = "OK";
		if(memberService.emailExists(email)) {
			result = "NOTOK";
		}
		return result;
	}		
	
	/*-------------이 아래는 페이지 이동만--------------*/
	// 로그인 페이지로 이동
	@RequestMapping(value="login.do", method= {RequestMethod.GET, RequestMethod.POST}) 
	public String login(Model model, String message) {		
		logger.info("MemberController login " + new Date());	
		
		model.addAttribute("message",message);
		return "account/login";
	}
}
