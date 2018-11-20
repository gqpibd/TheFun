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
	ProjectService projectService; //주석 풀어서 쓰길...
	
	
	@RequestMapping(value="searchProject.do", method= {RequestMethod.GET, RequestMethod.POST})
	public String searchProject(Model model, ProjectParam pParam) throws Exception{
		logger.info("ProjectController searchProject.do " + new Date());
		
		System.out.println("pParam : " + pParam.toString());
		List<ProjectDto> list = projectService.getProjectList(pParam);
		
		for (int i = 0; i < list.size(); i++) {
			ProjectDto dto = list.get(i);
			
			System.out.println("List : " + dto.toString());
		}
		
		model.addAttribute("List", list);
		
		return "search.tiles";
		
		/*@ResponseBody   
		   @RequestMapping(value="idcheck.do",produces="application/String; charset=utf-8", method=RequestMethod.GET)
		   public String idcheck(String id) {
		      logger.info("HelloController idcheck.do 입니다");
		      logger.info(id);

		      String str = "깜띡이";
		      return str;
		   }*/
	}
	/*@RequestMapping(value="detail.do", method= {RequestMethod.GET, RequestMethod.POST}) 
	public String detail(Model model, int seq) {
		logger.info("ProjectController detail " + new Date());
		
		return "project/detail";
	}*/
	
}
