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
	
	@RequestMapping(value="feedBack.do", method= {RequestMethod.GET, RequestMethod.POST}) 
	public String feedBack() {
		logger.info("ProjectController feedBack " + new Date());	
		return "project/detailFeedback";
	}
	
	@RequestMapping(value="newProject.do", method= {RequestMethod.GET, RequestMethod.POST}) 
	public String newProject() throws Exception{
		logger.info("ProjectController newProject 들어옴 " + new Date());
		return "project/newProject";
	}
	
	@RequestMapping(value="newProjectAf.do", method= {RequestMethod.GET, RequestMethod.POST}) 
	public String newProjectAf(ProjectDto newProjectDto,
							int option_total,
							String[] op_title, String[] op_content, String[] op_price, String[] op_stock,
							HttpServletRequest req,
							@RequestParam(value="fileload", required=false) MultipartFile mainImage) throws Exception {
		/* 파라미터 해석ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ
			- newProjectDto : 새로 만들 프로젝트의 입력값(id(이건 나중에..), fundtype, dategory, title, content, 
												summary, tag, bank, goalfund, 
												sdate, edate, pdate, shipdate)
			- option_total : 생성할 옵션(리워드) 개수
			- 배열값 4개 : 각 옵션의 제목, 내용, 가격, 재고
			- mainImage : 메인이미지로 등록한 파일명
		 */
		
		logger.info("ProjectController newProjectAf 들어옴 " + new Date());
		
		// 일단 id 내껄로 함.(로그인 페이지 되면 나중에 jsp에서 아예 받아오는걸로 바꿀것.)
		newProjectDto.setId("tmdwlfk");
		
		logger.info("newProjectDto : " + newProjectDto.toString());
		logger.info("mainImage 파일명 : " + mainImage.getOriginalFilename());
		
		
		// 배열로 입력된 갯수만큼 받아온 옵션입력값을 전부 list로 넣어준다.
		List<OptionDto> newPotionlist = new ArrayList<OptionDto>();
		for (int i = 0; i < option_total; i++) {
			newPotionlist.add(new OptionDto(0, op_title[i], op_content[i], 
								Integer.parseInt(op_price[i]), Integer.parseInt(op_stock[i])));
		}
		
		// [1] DB에  프로젝트+옵션 추가!! (+ 인설트한  프로젝트 seq값 가져오기)
		int projectSeq = projectService.projectWrite(newProjectDto, newPotionlist);
		
		// [2] 파일 업로드
			// [2]-1. 경로설정 (톰켓에 올리기)
			String uploadPath = req.getServletContext().getRealPath("/upload");
				// 아래는 실제 폴더에 올리는 방법.(이게 더 오류가 안날거 같긴한데.. 일단 톰캣으로 해보자)
				// String uploadPath = "d:\\tmp";
			logger.info("업로드 경로 : " + uploadPath);
			
			// [2]-2. 실제 파일명을 취득후, 프로젝트 seq값으로 변경
			String realFileName = mainImage.getOriginalFilename();
			
		
		return "project/newProject";
	}
	
}
