package donzo.thefun.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.FileUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import donzo.thefun.model.OptionDto;
import donzo.thefun.model.ProjectDto;
import donzo.thefun.model.ProjectParam;
import donzo.thefun.service.BuyService;
import donzo.thefun.service.ProjectService;
import donzo.thefun.util.FUpUtil;


@Controller
public class ProjectController {
	
	private static final Logger logger = LoggerFactory.getLogger(ProjectController.class);
	
	@Autowired
	ProjectService projectService; 
	@Autowired
	BuyService buyservice;

	// 프로젝트 상세보기로 이동	
	@RequestMapping(value="projectDetail.do", method= {RequestMethod.GET, RequestMethod.POST}) 
	public String projectDetail(int seq,Model model) {
		logger.info("ProjectController projectDetail 메소드 " + new Date());	
		logger.info("projectDetail project : " + projectService.getProject(seq) );
		//현재 선택한 프로젝트 정보
		model.addAttribute("projectdto",projectService.getProject(seq));
		
		//회사 정보
		model.addAttribute("writer",projectService.getWriter(seq));
		
		//옵션들
		model.addAttribute("optionList",projectService.getOptions(seq));
				
		//새소식 가져오기 
		model.addAttribute("noticeInfo",projectService.getNotice(seq));
		
		//새소식 가져오기 
		model.addAttribute("qnaList",projectService.getQna(seq));
		return "projectDetail.tiles";
	}
	
	// 프로젝트 관리 창으로 이동	
	@RequestMapping(value="projectManage.do", method= {RequestMethod.GET, RequestMethod.POST}) 
	public String projectManage(Model model) {
		logger.info("ProjectController projectManage 메소드 " + new Date());
		List<ProjectDto> pList = projectService.getWaitingList();
		model.addAttribute("pList",pList);
		return "projectManage.tiles";
	}
		
	// 옵션선택창으로 이동
	@RequestMapping(value="goSelectReward.do", method= {RequestMethod.GET, RequestMethod.POST}) 
	public String goSelectReward(int seq,Model model) {
		logger.info("ProjectController goOrderReward 메소드 " + new Date());	
	
		//현재 선택한 프로젝트 정보
		model.addAttribute("projectdto",projectService.getProject(seq));
		
		//옵션들
		model.addAttribute("optionList",projectService.getOptions(seq));
		
		return "selectReward.tiles";
	}
	
	// 주문하기 창(결제 및 배송지 정보 입력)으로 이동 
	@RequestMapping(value="goOrderReward.do", method= {RequestMethod.GET, RequestMethod.POST}) 
	public String goOrderReward(int projectSeq, int[] check, Model model) {
		logger.info("ProjectController goOrder 메소드 " + new Date());	

		//로그인 정보
		
		//현재 선택한 프로젝트 정보
		model.addAttribute("projectdto",projectService.getProject(projectSeq));
		
		//선택한 옵션정보
		List<OptionDto> optionList = projectService.getSelectOptions(check);
		model.addAttribute("selectOptions",optionList);

		return "orderReward.tiles";

	}
	
	//주문완료
	@RequestMapping(value="addOrder.do", method= {RequestMethod.GET, RequestMethod.POST}) 
	public String addOrder(String loginId,int projectSeq, int[] opSeq, int[] opCount, Model model) {
		
		System.out.println("플잭시퀀스:"+projectSeq);
		for(int i=0; i<opSeq.length;i++) {
			System.out.println("옵션시퀀스 : "+opSeq[i]);
			System.out.println("옵션수량 : "+opCount[i]);
		}
		
		//주문 insert & 옵션재고 update
		buyservice.addOrders(loginId,projectSeq, opSeq, opCount);

		return "redirect:/main.do";
	}
	
	// 프로젝트 검색
	@RequestMapping(value="searchProjectList.do", method= {RequestMethod.GET, RequestMethod.POST})
	public String searchProjectList(Model model, ProjectParam pParam) throws Exception{
		logger.info("ProjectController searchProjectList.do " + new Date());
		logger.info("searchProjectList.do 로 들어온 pParam : " + pParam.toString());
		
		// null 들어오면 xml 에서 오류 발생. 그거 방지위함 xml 헷갈려서 그냥 이렇게 했는데 나중에 고칠까요?
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
		
		if(pParam.getS_sort() == null || pParam.getS_sort().equals("")){
			pParam.setS_sort("FUNDACHIVED");
		} else if(pParam.getS_sort().equals("buycountDESC")) {
			pParam.setS_sort("BUYCOUNT");
		} else if(pParam.getS_sort().equals("fundachivedDESC")) {
			pParam.setS_sort("FUNDACHIVED");
		} else if(pParam.getS_sort().equals("sdateDESC")) {
			pParam.setS_sort("SDATE");
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
		
		model.addAttribute("s_summary", pParam.getS_summary());
		
		model.addAttribute("s_type", pParam.getS_type());
		model.addAttribute("s_category", pParam.getS_category());
		model.addAttribute("s_keyword", pParam.getS_keyword());
		model.addAttribute("s_sort", pParam.getS_sort());	// 정렬기준
		
		model.addAttribute("list", list);

		return "search.tiles";
	}
	
	
	// 새 프로젝트 등록	
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
		
		logger.info("newProjectDto : " + newProjectDto.toString());
		logger.info("mainImage 파일명 : " + mainImage.getOriginalFilename());
		
		// 배열로 입력된 갯수만큼 받아온 옵션입력값을 전부 list로 넣어준다.
		List<OptionDto> newPotionlist = new ArrayList<OptionDto>();
		for (int i = 0; i < option_total; i++) {
			newPotionlist.add(new OptionDto(0, op_title[i], op_content[i], 
								Integer.parseInt(op_price[i]), Integer.parseInt(op_stock[i])));
		}
		
		// [1] DB에  프로젝트 & 옵션 추가!(+ 프로젝트  SEQ값 찾아옴)
		int projectSeq = projectService.projectWrite(newProjectDto, newPotionlist);
		
		// [2] 파일 업로드
			// [2]-1. 경로설정 (톰켓에 올리기)
			String uploadPath = req.getServletContext().getRealPath("/upload");
				// 아래는 실제 폴더에 올리는 방법.(이게 더 오류가 안날거 같긴한데.. 일단 톰캣으로 해보자)
				// String uploadPath = "d:\\tmp";
			logger.info("업로드 경로 : " + uploadPath);
			
			// [2]-2. 실제 파일명을 취득후, 프로젝트 seq값으로 변경(==> 중복파일명 오류를 피하기 위함)
			String realFileName = mainImage.getOriginalFilename();
			String changedFileName =FUpUtil.getSeqFileName(realFileName, projectSeq);
			File file = new File(uploadPath + "/" + changedFileName);
			System.out.println("파일 : " + uploadPath + "/" + changedFileName);	// 경로확인

			// [2]-3. 실제 업로드 부분
			FileUtils.writeByteArrayToFile(file, mainImage.getBytes());
		
		return "newProject.tiles";
	}
	
	// 메인 화면으로 이동
	@RequestMapping(value="main.do", method= {RequestMethod.GET, RequestMethod.POST}) 
	public String goMain(Model model) throws Exception {
		logger.info("ProjectController goMain 메소드 " + new Date());	
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
		
		if(mainParam.getS_sort() == null) {
			mainParam.setS_sort("FUNDACHIVED");
		}
		else if(mainParam.getS_sort().equals("buycountDESC")) {
			mainParam.setS_sort("BUYCOUNT");
		} else if(mainParam.getS_sort().equals("fundachivedDESC")) {
			mainParam.setS_sort("FUNDACHIVED");
		} else if(mainParam.getS_sort().equals("sdateDESC")) {
			mainParam.setS_sort("SDATE");
		} else {
			mainParam.setS_sort("FUNDACHIVED");
		}
		
//		4페이지씩 보여주려고
		mainParam.setStart(1);
		mainParam.setEnd(4);
		mainParam.setRecordCountPerPage(8);
		
		System.out.println("mainParam 출력 : " + mainParam.toString());
		
		List<ProjectDto> mainPageList = projectService.searchProjectList(mainParam);
		
		for (int i = 0; i < mainPageList.size(); i++) {
			ProjectDto dto = mainPageList.get(i);
			logger.info("list : " + dto.toString());
		}
		
		model.addAttribute("list", mainPageList);
		model.addAttribute("recordCountPerPage", mainParam.getRecordCountPerPage());
				
		return "home.tiles";
	}
	
	/*------------- 화면만 이동 -------------*/
	// 피드백
	/*@RequestMapping(value="feedBack.do", method= {RequestMethod.GET, RequestMethod.POST}) 
	public String feedBack() {
		logger.info("ProjectController feedBack " + new Date());	
		return "project/detailFeedback";
	}*/
	
	// 새 프로젝트 창으로 이동
	@RequestMapping(value="newProject.do", method= {RequestMethod.GET, RequestMethod.POST}) 
	public String newProject() throws Exception{
		logger.info("ProjectController newProject 들어옴 " + new Date());
		return "newProject.tiles";
	}
	
	//내 일정 이동 (Calendar==schedule)
		@RequestMapping(value="mySchedule.do", method= {RequestMethod.GET, RequestMethod.POST})
		public String mySchedule(Model model, ProjectDto pro) throws Exception{
			logger.info("ProjectController myCalendar " + new Date());
			//model.addAttribute("schedule", projectService.mySchedule(pro));
			
			return "mySchedule.tiles";
		}
	 
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
