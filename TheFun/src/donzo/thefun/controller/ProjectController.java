package donzo.thefun.controller;

import java.util.Date;

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
		System.out.println("새소식 : "+projectService.getNotice(seq));
		return "project/detail";
	}
	
	@RequestMapping(value="goOrderReward.do", method= {RequestMethod.GET, RequestMethod.POST}) 
	public String goOrderReward(int seq,Model model) {
		logger.info("ProjectController goOrderReward 메소드 " + new Date());	
	
		//현재 선택한 프로젝트 정보
		model.addAttribute("projectdto",projectService.getProject(seq));
		
		//옵션들
		model.addAttribute("optionList",projectService.getOptions(seq));
		System.out.println(projectService.getProject(seq).toString());
		return "project/selectReward";
		
	}
	
		
	@RequestMapping(value="main.do", method= {RequestMethod.GET, RequestMethod.POST}) 
	public String goMain() {
		logger.info("ProjectController goMain 메소드 " + new Date());	
		return "main";
	}
	
}
