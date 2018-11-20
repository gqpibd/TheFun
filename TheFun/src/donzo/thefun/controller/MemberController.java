package donzo.thefun.controller;

import java.util.Date;

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
	MemberService memberService; //주석 풀어서 쓰길...
	
	@ResponseBody
	@RequestMapping(value="getMypage.do", method= {RequestMethod.GET, RequestMethod.POST})
	public MemberDto getMypage(String id) {
		logger.info("MemberController getMypage " + new Date());
		
		MemberDto mypage = memberService.getMypage(id);
		
		
		
		//return "getMypage.tiles";
		return mypage;
	}
	
	/*
	@RequestMapping(value="어쩌구.do", method= {RequestMethod.GET, RequestMethod.POST}) 
	public String hahaha() {
		logger.info("MemberController 어쩌구 메소드 " + new Date());
		
		return "뭔.tiles";
	}
*/
}
