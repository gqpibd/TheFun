package donzo.thefun.controller;

import java.util.Date;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import donzo.thefun.service.MemberService;


@Controller
public class MemberController {
	
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
	
	@Autowired
	MemberService memberService; //주석 풀어서 쓰길...
	
	@RequestMapping(value="login.do", method= {RequestMethod.GET, RequestMethod.POST}) 
	public String login() throws Exception{
		logger.info("MemberController login.do " + new Date());
		
		return "login/login";
	}
	
	@RequestMapping(value="regi.do", method= {RequestMethod.GET, RequestMethod.POST})
	public String regi() throws Exception{
		logger.info("MemberController regi.do " + new Date());
		
		return "login/regi";
	}

}
