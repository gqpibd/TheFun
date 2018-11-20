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
	
	@RequestMapping(value="login.do", method= {RequestMethod.GET, RequestMethod.POST}) 
	public String login() {
		logger.info("MemberController login " + new Date());
		
		return "account/login";
	}
	
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
	
	@RequestMapping(value="loginAf.do", method= {RequestMethod.GET, RequestMethod.POST}) 
	public String loginAf(HttpServletRequest req, MemberDto dto) {
		logger.info("MemberController loginAf " + new Date());
		req.getSession().setAttribute("login", dto);
		logger.info(dto.toString());
		return "main";
	}
	
	@RequestMapping(value="regiAf.do", method= {RequestMethod.GET, RequestMethod.POST}) 
	public String regiAf(MemberDto dto) {
		logger.info("MemberController regiAf " + new Date());
		logger.info("MemberController dto = " + dto);
		memberService.addAccount(dto);
		return "redirect:/login.do";
	}
	
	@RequestMapping(value="regiMain.do", method= {RequestMethod.GET, RequestMethod.POST}) 
	public String regiMain() {
		logger.info("MemberController regiMain " + new Date());
		
		return "account/regiMain";
	}
	
	


}
