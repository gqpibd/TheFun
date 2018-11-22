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

import donzo.thefun.model.ProjectDto;
import donzo.thefun.model.ProjectParam;
import donzo.thefun.service.ProjectService;


@Controller
public class ProjectController {
	
	private static final Logger logger = LoggerFactory.getLogger(ProjectController.class);
	
	@Autowired
	ProjectService projectService;
	
	@RequestMapping(value="getAllProject.do", method= {RequestMethod.GET, RequestMethod.POST})
	public String getAllProject(Model model, ProjectParam pParam) throws Exception{
		logger.info("ProjectController getAllProject.do " + new Date());
		logger.info("getAllProject.do 로 들어온 pParam : " + pParam.toString());
		
		if(pParam.getS_category() == null) {
			pParam.setS_category("");
		}
		
		List<ProjectDto> list = projectService.getAllProjectList(pParam);
		
		for (int i = 0; i < list.size(); i++) {
			ProjectDto dto = list.get(i);
			logger.info("list : " + dto.toString());
		}
		
		model.addAttribute("list", list);

		return "search.tiles";
	}
	
	
	@RequestMapping(value="detail.do", method= {RequestMethod.GET, RequestMethod.POST})
	public String detail(Model model, int seq) throws Exception{
		logger.info("ProjectController detail.do " + new Date());
		logger.info("detail.do 로 들어온 seq : " + seq);
		
		return "detail.tiles";
	}
	/*@RequestMapping(value="searchProject.do", method= {RequestMethod.GET, RequestMethod.POST})
	public String searchProject(Model model, ProjectParam pParam) throws Exception{
		logger.info("ProjectController searchProject.do " + new Date());
		
		logger.info("ProjectController 로 들어온 pParam : " + pParam.toString());
		
		// paging 처리 
		int sn = pParam.getPageNumber();
		int start = (sn) * pParam.getRecordCountPerPage() + 1;	// 0으로 들어온
		int end = (sn + 1) * pParam.getRecordCountPerPage();		// 1 ~ 10
		
		pParam.setStart(start);
		pParam.setEnd(end);
		
		List<ProjectDto> list = projectService.getAllProjectList(pParam);
		
		for (int i = 0; i < list.size(); i++) {
			ProjectDto dto = list.get(i);
			System.out.println("List : " + dto.toString());
		}
		
		model.addAttribute("List", list);
		
		return "search.tiles";
		
	}*/
	 
	/*
	 참고용 삭제 예정
	 @ResponseBody   
		   @RequestMapping(value="idcheck.do",produces="application/String; charset=utf-8", method=RequestMethod.GET)
		   public String idcheck(String id) {
		      logger.info("HelloController idcheck.do 입니다");
		      logger.info(id);

		      String str = "깜띡이";
		      return str;
		   }*/
	/*@RequestMapping(value="detail.do", method= {RequestMethod.GET, RequestMethod.POST}) 
	public String detail(Model model, int seq) {
		logger.info("ProjectController detail " + new Date());
		
		return "project/detail";
	}*/
}
