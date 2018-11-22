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
	
	// 마이페이지로 이동
	@RequestMapping(value="getMypage.do", method= {RequestMethod.GET, RequestMethod.POST})
	public String getMypage(MemberDto mem, Model model) throws Exception{
		logger.info("MemberController getMypage " + new Date());
		logger.info("getMypage mem" + mem.toString());
		MemberDto mypage = memberService.getMypage(mem);
		
		model.addAttribute("myp", mypage);
		
		//return "getMypage.tiles";
		return "mypage/mypage";
	}
	
	// 내 정보 불러오기(내정보 보기)
	@RequestMapping(value="myInfo.do", method= {RequestMethod.GET, RequestMethod.POST})
	public String getMyinfo(MemberDto mem, Model model) throws Exception{
		logger.info("MemberController myInfo " + new Date());
		
		/*String id ="testJY";
		mem.setId(id);*/
		logger.info("myInfo mem" + mem.toString());
		MemberDto myinfo = memberService.getMypage(mem);		
		
		int n = 1;
		if(myinfo != null && !myinfo.getId().equals("")) {//null 값 혹은 0 으로 들어 왔을때 의미 없는 걸로 세팅해줌..	
			if(myinfo.getNickname()==null || myinfo.getNickname().equals("")) {
				myinfo.setNickname("별명"+ (n++));
			}
			if(myinfo.getPhone()==null || myinfo.getPhone().equals("")) {
				myinfo.setPhone("");
			}
			if(myinfo.getEmail()==null || myinfo.getEmail().equals("")) {
				myinfo.setEmail("이메일을 적어주세요");
			}
			if(myinfo.getAddress()==null || myinfo.getAddress().equals("")) {
				myinfo.setAddress("주소를 설정해 주세요");
			}
			if(myinfo.getInfo()==null || myinfo.getInfo().equals("")) {
				myinfo.setInfo("자신을 소개해보세요");
			}
			if(myinfo.getAuth()==0) {
				myinfo.setAuth(1);
			}
			model.addAttribute("myi", myinfo);
		}
		
		//return "getMypage.tiles";
		return "mypage/myInfo";	
	}
	
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
