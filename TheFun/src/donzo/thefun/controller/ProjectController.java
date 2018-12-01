package donzo.thefun.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Date;
import java.util.Enumeration;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.social.google.api.plus.Activity.Article;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import donzo.thefun.model.OptionDto;
import donzo.thefun.model.ProjectDto;
import donzo.thefun.model.ProjectParam;
import donzo.thefun.service.ProjectService;
import donzo.thefun.util.FUpUtil;
import net.sf.json.JSONObject;


@Controller
public class ProjectController {
	
	private static final Logger logger = LoggerFactory.getLogger(ProjectController.class);
	
	@Autowired
	ProjectService projectService; 

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
		
		//댓글 가져오기 
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
		
		//기부일 경우
		
		
		//리워드일 경우
		
		//옵션들
		model.addAttribute("optionList",projectService.getOptions(seq));
		return "selectReward.tiles";
	}
	
	// 주문하기 창(결제 및 배송지 정보 입력)으로 이동 
	@RequestMapping(value="goOrderReward.do", method= {RequestMethod.GET, RequestMethod.POST}) 
	public String goOrderReward(int projectSeq, int[] check, Model model) {
		logger.info("ProjectController goOrder 메소드 " + new Date());	

		//현재 선택한 프로젝트 정보
		model.addAttribute("projectdto",projectService.getProject(projectSeq));
		
		//선택한 옵션정보
		List<OptionDto> optionList = projectService.getSelectOptions(check);
		model.addAttribute("selectOptions",optionList);

		return "orderReward.tiles";

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
		
//		logger.info("sn : " + sn + " start : " + start + " end : " + end);
		
		// 8 프로젝트씩 보여주려고
		pParam.setStart(start); // <- 여기 이상하다
		pParam.setEnd(end);
		pParam.setRecordCountPerPage(8);
		
		List<ProjectDto> list = projectService.searchProjectList(pParam);
		int totalRecordCount = projectService.getProjectCount(pParam);
		
		// 확인용
//		for (int i = 0; i < list.size(); i++) {
//			ProjectDto dto = list.get(i);
//			logger.info("list : " + dto.toString());
//		}
		
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
			- newProjectDto : 새로 만들 프로젝트의 입력값(id, fundtype, dategory, title, content, 
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
		if(newProjectDto.getFundtype().equals("reward")) {
			for (int i = 0; i < option_total; i++) {
				
				logger.info(i + "번째 재고 : [" + op_stock[i]+"]");
				
				if(op_stock[i] != null && op_stock[i].trim().length()>0) {
					logger.info("재고 있음");
					newPotionlist.add(new OptionDto(0, op_title[i], op_content[i], 
							Integer.parseInt(op_price[i]), Integer.parseInt(op_stock[i])));
				}else {
					logger.info("재고가 없어!!!");
					newPotionlist.add(new OptionDto(0, op_title[i], op_content[i], 
							Integer.parseInt(op_price[i]), 0));
				}
				
			}
			
			for (int i = 0; i < newPotionlist.size(); i++) {
				logger.info(i + "번째 리스트 : " + newPotionlist.get(i).toString());
			}
		}
		
		// [1] DB에  프로젝트 & 옵션 추가!(+ 프로젝트  SEQ값 찾아옴)
		int projectSeq = projectService.projectWrite(newProjectDto, newPotionlist);
		
		// [2] 파일 업로드
			// [2]-1. 경로설정 (실제 폴더에 올리기)
			// 이건 d드라이브 안에 upload폴더라는 절대경로?로 업로드! 주의할점~ servlet-context.xml에 써준 uploadTempDir부분과 이름(upload)을 맞춰줘야 한다
			// String uploadPath = "d:\\upload";
			// 아래는 톰캣 서버에 올리는 방법(이건 오류가 잦음)
			String uploadPath = req.getServletContext().getRealPath("/upload");
			
			logger.info("업로드 경로 : " + uploadPath);
			
			// [2]-2. 실제 파일명을 취득후, 프로젝트 seq값으로 변경(==> 중복파일명 오류를 피하기 위함)
			String realFileName = mainImage.getOriginalFilename();
			String changedFileName =FUpUtil.getSeqFileName(realFileName, projectSeq);
			File file = new File(uploadPath + "/" + changedFileName);
			logger.info("파일 : " + uploadPath + "/" + changedFileName);	// 경로확인

			// [2]-3. 실제 업로드 부분
			FileUtils.writeByteArrayToFile(file, mainImage.getBytes());
		
		return "newProject.tiles";
	}
		
	// 스마트 에디터 이미지 업로드 테스트중(승지)
	@ResponseBody	// <== ajax에 필수
	@RequestMapping(value="summernotePhotoUpload.do",produces="application/String; charset=UTF-8",
					method= {RequestMethod.GET, RequestMethod.POST}) 
	public String summernotePhotoUpload(HttpServletRequest request, HttpServletResponse response,
				@RequestParam("summerFile") MultipartFile summerFile) throws IOException {
		logger.info("오오오 왠열 어허허허허허헠ㅋㅋ summernotePhotoUpload 들어옴 " + new Date());
		logger.info("파일 원래 이름 = " + summerFile.getOriginalFilename());
		
		response.setContentType("text/html;charset=utf-8");
		// 업로드할 폴더 경로
		String realFolder = request.getSession().getServletContext().getRealPath("/upload");
		UUID uuid = UUID.randomUUID();

		// 업로드할 파일 이름
		String org_filename = summerFile.getOriginalFilename();
		String str_filename = uuid.toString() + org_filename;

		System.out.println("원본 파일명 : " + org_filename);
		System.out.println("저장할 파일명 : " + str_filename);

		String filepath = realFolder + "\\" + str_filename;
		System.out.println("파일경로 : " + filepath);

		File f = new File(filepath);
		if (!f.exists()) {
			f.mkdirs();
		}
		summerFile.transferTo(f);
		
		return "upload/"+str_filename;
	}
	
	// 프로젝트 수정 페이지로 들어가는 메소드(승지)
	@RequestMapping(value="projectUpdate.do", method= {RequestMethod.GET, RequestMethod.POST}) 
	public String projectUpdate(int seq, Model model) throws Exception {
		logger.info("ProjectController projectUpdate 들어옴 " + new Date());
		ProjectDto findProject = projectService.getProject(seq);
		model.addAttribute("findPro", findProject);
		return "projectUpdate.tiles";
	}
	
	// 실제로 수정하는 메소드(승지)
	@RequestMapping(value="projectUpdateAf.do", method= {RequestMethod.GET, RequestMethod.POST}) 
	public String projectUpdateAf(ProjectDto newProjectDto,
							HttpServletRequest req,
							@RequestParam(value="fileload", required=false) MultipartFile newImage) throws Exception {
		logger.info("ProjectController projectUpdateAf 들어옴 " + new Date());
		// 업데이트 값 확인
		logger.info("SEQ = " +newProjectDto.getSeq());
		logger.info("제목 = " +newProjectDto.getTitle());
		logger.info("요약 = "+newProjectDto.getSummary());
		logger.info("내용 = "+newProjectDto.getContent());
		logger.info("은행 = "+newProjectDto.getBank());
		logger.info("이미지 = "+newImage.getOriginalFilename());
		
		// DB 수정
		projectService.updateProject(newProjectDto);
		
		// 파일 수정
		String uploadPath = req.getServletContext().getRealPath("/upload");
		//String uploadPath = req.getServletContext().getRealPath("d:\\upload");
	
		String realFileName = newImage.getOriginalFilename();
		String changedFileName = FUpUtil.getSeqFileName(realFileName, newProjectDto.getSeq());
		
		try {
			File file = new File(uploadPath + "/" + changedFileName);
			// 실제 업로드
			FileUtils.writeByteArrayToFile(file, newImage.getBytes());	// 해당 경로에 동일한 이름의 이미지 파일이 있으면 자동 덮어씌워질것.
		} catch(Exception e) {
			logger.info("수정 이미지 파일 업로드에 실패했습니다");
		}
		
		return "redirect:/projectDetail.do?seq="+newProjectDto.getSeq();
	}
	
	// 내 등록 프로젝트 삭제하는 메소드(승지)
	@RequestMapping(value="projectDelete.do", method= {RequestMethod.GET, RequestMethod.POST}) 
	public String projectDelete(int seq) throws Exception {
		logger.info("ProjectController projectDelete 들어옴 " + new Date());
		
		
		return "projectUpdate.tiles";
	}
	
	// 프로젝트 승인
	@RequestMapping(value="approve.do", method= {RequestMethod.GET, RequestMethod.POST})
	public String approve(Model model, int projectseq) throws Exception{
		logger.info("ProjectController approve " + new Date());
		projectService.approveProject(projectseq);
		
		return "redirect:/projectDetail.do?seq=" + projectseq;
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
		
		if(mainParam.getS_sort() == null || mainParam.getS_sort().equals("")) {
			mainParam.setS_sort("FUNDACHIVED");
		} else if(mainParam.getS_sort().equals("buycountDESC")) {
			mainParam.setS_sort("BUYCOUNT");
		} else if(mainParam.getS_sort().equals("fundachivedDESC")) {
			mainParam.setS_sort("FUNDACHIVED");
		} else if(mainParam.getS_sort().equals("sdateDESC")) {
			mainParam.setS_sort("SDATE");
		}
		
//		4페이지씩 보여주려고
		mainParam.setStart(1);
		mainParam.setEnd(4);
		mainParam.setRecordCountPerPage(8);
		
//		logger.info("mainParam 출력 : " + mainParam.toString());
		
		List<ProjectDto> mainPageList = projectService.searchProjectList(mainParam);
		
//		for (int i = 0; i < mainPageList.size(); i++) {
//			ProjectDto dto = mainPageList.get(i);
//			logger.info("list : " + dto.toString());
//		}
		
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
	
	//내 일정 이동 (내 프로젝트 보기)
		@RequestMapping(value="mySchedule.do", method= {RequestMethod.GET, RequestMethod.POST})
		public String mySchedule(Model model, ProjectDto pro) throws Exception{
			logger.info("ProjectController myCalendar " + new Date());
			
			List<ProjectDto> myschedule = projectService.mySchedule(pro);
			
			for (int i = 0; i < myschedule.size(); i++) {
				ProjectDto dto = myschedule.get(i);
				logger.info("Schedule list : " + dto.toString());
			}
			model.addAttribute("schedule", myschedule);
			return "mySchedule.tiles";
		}
	 
}
