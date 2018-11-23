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
	
	@RequestMapping(value="main.do", method= {RequestMethod.GET, RequestMethod.POST})
	public String main(Model model) throws Exception{
		logger.info("ProjectController main.do " + new Date());
		
		ProjectParam mainParam = new ProjectParam();
		// null 들어오면 xml 에서 오류 발생. 그거 방지위함 xml 헷갈려서 그냥 이렇게 했는데 나중에 고칠 예정
		if(mainParam.getS_type() == null) {
			mainParam.setS_type("");
		}
		
		if(mainParam.getS_category() == null) {
			mainParam.setS_category("");
		}
		
		if(mainParam.getS_keyword() == null) {
			mainParam.setS_keyword("");
		}
		
		if(mainParam.getS_summary() == null) {
			mainParam.setS_summary("");
		}
//		4페이지씩 보여주려고
		mainParam.setStart(1);
		mainParam.setEnd(4);
		mainParam.setRecordCountPerPage(8);
		
		List<ProjectDto> mainPageList = projectService.searchProjectList(mainParam);
		
		for (int i = 0; i < mainPageList.size(); i++) {
			ProjectDto dto = mainPageList.get(i);
			logger.info("list : " + dto.toString());
		}
		
		model.addAttribute("list", mainPageList);
		model.addAttribute("recordCountPerPage", mainParam.getRecordCountPerPage());
				
		return "main.tiles";
	}
	
	@RequestMapping(value="searchProjectList.do", method= {RequestMethod.GET, RequestMethod.POST})
	public String searchProjectList(Model model, ProjectParam pParam) throws Exception{
		logger.info("ProjectController searchProjectList.do " + new Date());
		logger.info("searchProjectList.do 로 들어온 pParam : " + pParam.toString());
		
		// null 들어오면 xml 에서 오류 발생. 그거 방지위함 xml 헷갈려서 그냥 이렇게 했는데 나중에 고칠 예정
		if(pParam.getS_type() == null) {
			pParam.setS_type("");
		}
		
		if(pParam.getS_category() == null) {
			pParam.setS_category("");
		}
		
		if(pParam.getS_keyword() == null) {
			pParam.setS_keyword("");
		}
		
		if(pParam.getS_summary() == null) {
			pParam.setS_summary("");
		}
		
		
		// paging 처리 
		int sn = pParam.getPageNumber();
		int start = (sn) * pParam.getRecordCountPerPage() + 1;	// 0으로 들어온
		int end = (sn + 1) * pParam.getRecordCountPerPage();		// 1 ~ 10
		
		System.out.println("sn : " + sn + " start : " + start + " end : " + end);
		
		// 8페이지씩 보여주려고
		pParam.setStart(start); // <- 여기 이상하다
		pParam.setEnd(end);
		pParam.setRecordCountPerPage(8);
		
		List<ProjectDto> list = projectService.searchProjectList(pParam);
		int totalRecordCount = projectService.getProjectCount(pParam);
		
		// 확인용
		for (int i = 0; i < list.size(); i++) {
			ProjectDto dto = list.get(i);
			logger.info("list : " + dto.toString());
		}
		
		model.addAttribute("pageNumber", sn);
		model.addAttribute("pageCountPerScreen", 10);	// 10개씩 표현한다. 페이지에서 표현할 총 페이지
		model.addAttribute("recordCountPerPage", pParam.getRecordCountPerPage());	// 맨끝 페이지의 개수 표현
		model.addAttribute("totalRecordCount", totalRecordCount);
		
		model.addAttribute("s_type", pParam.getS_type());
		model.addAttribute("s_category", pParam.getS_category());
		model.addAttribute("s_keyword", pParam.getS_keyword());
		model.addAttribute("s_summary", pParam.getS_summary());
		
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
