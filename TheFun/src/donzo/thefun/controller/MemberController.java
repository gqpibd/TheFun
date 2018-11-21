package donzo.thefun.controller;

import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
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
	public String loginAf(HttpServletRequest req, MemberDto dto, String loginType) {
		logger.info("MemberController loginAf " + new Date());
		logger.info(dto.toString());
		logger.info(loginType);
		if(dto.getPwd() != null && loginType.equals("normal")) { // 계정 연동 로그인이 아닌 경우
			dto = memberService.tryLogin(dto);
			if(dto == null) { // 로그인 실패
				return "redirect:/login.do";
			}
		}else if(loginType.equals("externalAccount")){ // 계정 연동 로그인인 경우
			dto = memberService.tryLogin(dto);
		}
		req.getSession().setAttribute("login", dto);
		return "redirect:/main.do";
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
	public String regiAf(MemberDto dto) {
		logger.info("MemberController regiAf " + new Date());
		logger.info("MemberController dto = " + dto);
		memberService.addAccount(dto);
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
	public String login() {
		logger.info("MemberController login " + new Date());		
		return "account/login";
	}
}
