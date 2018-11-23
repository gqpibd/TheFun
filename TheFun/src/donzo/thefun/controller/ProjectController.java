package donzo.thefun.controller;

import java.util.Date;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import donzo.thefun.model.OptionDto;
import donzo.thefun.service.ProjectService;


@Controller
public class ProjectController {
	
	private static final Logger logger = LoggerFactory.getLogger(ProjectController.class);
	
	@Autowired
	ProjectService projectService; //주석 풀어서 쓰길...

	@RequestMapping(value="detail.do", method= {RequestMethod.GET, RequestMethod.POST}) 
	public String detail(int seq,Model model) {
		logger.info("ProjectController detail 메소드 " + new Date());	
		
		//현재 선택한 프로젝트 정보
		model.addAttribute("projectdto",projectService.getProject(seq));
		
		//회사 정보
		model.addAttribute("writer",projectService.getWriter(seq));
		
		//옵션들
		model.addAttribute("optionList",projectService.getOptions(seq));
		
		//구매자 수
		model.addAttribute("howmanyBuy",projectService.howmanyBuy(seq));
		
		//새소식 가져오기
		model.addAttribute("noticeInfo",projectService.getNotice(seq));
		return "project/detail";
	}
	
	@RequestMapping(value="goSelectReward.do", method= {RequestMethod.GET, RequestMethod.POST}) 
	public String goSelectReward(int seq,Model model) {
		logger.info("ProjectController goOrderReward 메소드 " + new Date());	
	
		//현재 선택한 프로젝트 정보
		model.addAttribute("projectdto",projectService.getProject(seq));
		
		//옵션들
		model.addAttribute("optionList",projectService.getOptions(seq));
		
		return "project/selectReward";
	}
	
	@RequestMapping(value="goOrderReward.do", method= {RequestMethod.GET, RequestMethod.POST}) 
	public String goOrderReward(int projectSeq, int[] check, Model model) {
		logger.info("ProjectController goOrder 메소드 " + new Date());	

		//로그인 정보
		
		//현재 선택한 프로젝트 정보
		model.addAttribute("projectdto",projectService.getProject(projectSeq));
		
		//선택한 옵션정보
		List<OptionDto> optionList = projectService.getSelectOptions(check);
		model.addAttribute("selectOptions",optionList);

		return "project/orderReward";

	}
	
	@RequestMapping(value="order.do", method= {RequestMethod.GET, RequestMethod.POST}) 
	public String order(int projectSeq, int[] opSeq, int[] opCount, Model model) {
		logger.info("ProjectController goOrder 메소드 " + new Date());	

		//buy테이블에 add 
		
		//선택한옵션 seq[]랑 수량[]

		return "main";

	}	
	@RequestMapping(value="main.do", method= {RequestMethod.GET, RequestMethod.POST}) 
	public String goMain() {
		logger.info("ProjectController goMain 메소드 " + new Date());	
		
		return "main";
	}
	
}
