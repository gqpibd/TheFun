package donzo.thefun.controller;

import java.util.Date;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import donzo.thefun.service.ProjectService;


@Controller
public class ProjectController {
	
	private static final Logger logger = LoggerFactory.getLogger(ProjectController.class);
	
	@Autowired
	ProjectService projectService; 
	
	/* 화면만 이동 */
	// 프로젝트 상세보기로 이동	
	@RequestMapping(value="detail.do", method= {RequestMethod.GET, RequestMethod.POST}) 
	public String detail() {
		logger.info("ProjectController detail 메소드 " + new Date());	
		return "detail.tiles";
	}
	
	// 메인 화면으로 이동
	@RequestMapping(value="main.do", method= {RequestMethod.GET, RequestMethod.POST}) 
	public String goMain() {
		logger.info("ProjectController goMain 메소드 " + new Date());	
		return "mainView.tiles";
	}
	
	// 피드백
	@RequestMapping(value="feedBack.do", method= {RequestMethod.GET, RequestMethod.POST}) 
	public String feedBack() {
		logger.info("ProjectController feedBack " + new Date());	
		return "project/detailFeedback";
	}
	   
}
