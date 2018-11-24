package donzo.thefun.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

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
							ProjectDto newProjectDto,
							int option_total,
							String[] op_title, String[] op_content, String[] op_price, String[] op_stock,
							/*OptionDto newOptionDto, */
							HttpServletRequest req,
							@RequestParam(value="fileload", required=false) MultipartFile mainImage) throws Exception {
		
		
		logger.info("ProjectController newProjectAf 들어옴 " + new Date());
		
		newProjectDto.setId("tmdwlfk");
		logger.info("newProjectDto : " + newProjectDto.toString());
		// Project 게시물 추가
		projectService.projectWrite(newProjectDto);
		
		//logger.info("mainImage 파일명 : " + mainImage.getOriginalFilename());
		
		for (int i = 0; i < option_total; i++) {
			// 배열로 입력된 갯수만큼 받아온 옵션입력값을 전부 list로 넣어준다.
			List<OptionDto> newPotionDto = new ArrayList<OptionDto>();
			newPotionDto.set(i, new OptionDto(0, op_title[i], op_content[i], 
								Integer.parseInt(op_price[i]), Integer.parseInt(op_stock[i])));
			/*logger.info("op_title 값 : " + op_title[i] );
			logger.info("op_content 값 : " + op_content[i] );
			logger.info("op_price 값 : " + op_price[i] );
			logger.info("op_stock 값 : " + op_stock[i] );*/
		}
		
		
		
		
		
		
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
		 */
		//logger.info("newOptionDto : " + newOptionDto.toString());
				/*for (int i = 0; i < option_total; i++) {
				logger.info("newOptionDto : " + list.get(i).toString());
				}*/
		
		
		
		return "project/newProject";
	}
	
}
