package donzo.thefun.controller;

import java.util.Date;

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
	MemberService memberService; //주석 풀어서 쓰길...
	
	
	@RequestMapping(value="getMypage.do", method= {RequestMethod.GET, RequestMethod.POST})
	public String getMypage(MemberDto mem, Model model) throws Exception{
		logger.info("MemberController getMypage " + new Date());
		
		/*String id ="testJY";
		mem.setId(id);*/
		logger.info("getMypage mem" + mem.toString());
		MemberDto mypage = memberService.getMypage(mem);
		
		model.addAttribute("myp", mypage);
		
		//return "getMypage.tiles";
		return "mypage/mypage";
	}
	
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
				myinfo.setPhone("연락처를 적어주세요");
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
	
	/*
	@RequestMapping(value="어쩌구.do", method= {RequestMethod.GET, RequestMethod.POST}) 
	public String hahaha() {
		logger.info("MemberController 어쩌구 메소드 " + new Date());
		
		return "뭔.tiles";
	}
*/
}
