package donzo.thefun.controller;

import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.aop.ThrowsAdvice;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import donzo.thefun.model.OptionDto;
import donzo.thefun.model.ProjectDto;
import donzo.thefun.model.ProjectInputDto;
import donzo.thefun.service.ProjectService;


@Controller
public class ProjectController {
	
	private static final Logger logger = LoggerFactory.getLogger(ProjectController.class);
	
	@Autowired
	ProjectService projectService;
	
	
	@RequestMapping(value="newProject.do", method= {RequestMethod.GET, RequestMethod.POST}) 
	public String newProject() throws Exception{
		logger.info("ProjectController newProject 들어옴 " + new Date());
		return "project/newProject";
	}
	
	
	@RequestMapping(value="newProjectAf.do", method= {RequestMethod.GET, RequestMethod.POST}) 
	public String newProjectAf(/*String title, String summary, String fundtype, String category,
							String content, String tags, int goalfund, String bank,
							String sdate, String edate, String pdate, String shipdate,*/
							@ModelAttribute ProjectInputDto inputDto,
							/*int option_total,
							String[] op_title, String[] op_content, String[] price, String[] stock,*/
							HttpServletRequest req,
							@RequestParam(value="fileload", required=false) MultipartFile mainImage) throws Exception {
		
		
		logger.info("ProjectController newProjectAf 들어옴 " + new Date());
		logger.info("결과값 : " + inputDto.toString());
		/*logger.info("title : " + title);
		logger.info("summary : " + summary);
		logger.info("fundtype : " + fundtype);
		logger.info("category : " + category);
		logger.info("content : " + content);
		logger.info("tags : " + tags);
		logger.info("goalfund : " + goalfund+"");
		logger.info("bank : " + bank);
		logger.info("sdate : " + sdate);
		logger.info("edate : " + edate);
		logger.info("pdate : " + pdate);
		logger.info("shipdate : " + shipdate);
		//logger.info("projectDto : " + projectDto.toString());
		*/
		logger.info("mainImage 파일명 : " + mainImage.getOriginalFilename());
		
		/*for (int i = 0; i < option_total; i++) {
			logger.info("op_title 값 : " + op_title[i] );
			logger.info("op_content 값 : " + op_content[i] );
			logger.info("price 값 : " + price[i] );
			logger.info("stock 값 : " + stock[i] );
		}
		*/
		
		return "project/newProject";
	}
	
}
