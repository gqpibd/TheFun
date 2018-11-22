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
	ProjectService projectService; //주석 풀어서 쓰길...
	
	
	@RequestMapping(value="main.do", method= {RequestMethod.GET, RequestMethod.POST}) 
	   public String goMain() {
	      logger.info("ProjectController goMain 메소드 " + new Date());   
	      return "mainView.tiles";
	   }
	
	
	
	
	
	/*@RequestMapping(value="어쩌구.do", method= {RequestMethod.GET, RequestMethod.POST}) 
	public String hahaha() {
		logger.info("ProjectController 어쩌구 메소드 " + new Date());
		
		return "뭔.tiles";
	}*/
}
