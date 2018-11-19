package donzo.thefun.controller;

import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import donzo.thefun.model.MemberDto;
import donzo.thefun.service.MemberService;


@Controller
public class MemberController {
	
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
	
	@Autowired
	MemberService memberService; //주석 풀어서 쓰길...
	
	
	@RequestMapping(value="login.do", method= {RequestMethod.GET, RequestMethod.POST}) 
	public String login() {
		logger.info("MemberController login " + new Date());
		
		return "account/login";
	}
	
	@RequestMapping(value="loginAf.do", method= {RequestMethod.GET, RequestMethod.POST}) 
	public String loginAf(HttpServletRequest req, MemberDto dto) {
		logger.info("MemberController loginAf " + new Date());
		req.getSession().setAttribute("login", dto);
		logger.info(dto.toString());
		return "main";
	}
	
	@RequestMapping(value="regiMain.do", method= {RequestMethod.GET, RequestMethod.POST}) 
	public String regiMain() {
		logger.info("MemberController regiMain " + new Date());
		
		return "account/regiMain";
	}
	
	


}
