package donzo.thefun.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import donzo.thefun.model.LikeDto;
import donzo.thefun.model.MemberDto;
import donzo.thefun.model.OptionDto;
import donzo.thefun.model.ProjectDto;
import donzo.thefun.model.ProjectParam;
import donzo.thefun.model.ProjectmsgDto;
import donzo.thefun.model.StatCountParam;
import donzo.thefun.model.pageParam;
import donzo.thefun.service.AlarmService;
import donzo.thefun.service.LikeService;
import donzo.thefun.service.ProjectService;
import donzo.thefun.util.UtilFunctions;
import donzo.thefun.util.myCal;

@Controller
public class ProjectController {
	
	private static final Logger logger = LoggerFactory.getLogger(ProjectController.class);
	
	@Autowired
	ProjectService projectService; 
	
	@Autowired
	AlarmService alarmService;
	
	@Autowired
	LikeService likeService;
	

	// 프로젝트 상세보기로 이동	
	@RequestMapping(value="projectDetail.do", method= {RequestMethod.GET, RequestMethod.POST}) 
	public String projectDetail(int seq, Model model, HttpServletRequest req, myCal jcal) throws Exception{
		logger.info("ProjectController projectDetail 메소드 " + new Date());	
		
		//현재 선택한 프로젝트 정보
		ProjectDto projectdto = projectService.getProject(seq);
		
		model.addAttribute("projectdto",projectdto);
		
		//달력
		logger.info("ProjectController calendar" + new Date());
		
		//달력에서 필요한 것들 모아놓은 유틸리티야.
		jcal.calculate();
		
		//xml실행하고 결과값을 여따가 저장해
		List<ProjectDto> flist = projectService.getCalendarList(seq);	
		//저장 한거를 여기다가 짐싸
		model.addAttribute("flist", flist);	
		//그 유틸리티도 짐싸
		model.addAttribute("jcal", jcal);		
		
		//회사 정보
		model.addAttribute("writer",projectService.getWriter(seq));
		
		//옵션들
		model.addAttribute("optionList",projectService.getOptions(seq));
				
		//댓글 가져오기 
		model.addAttribute("qnaList",projectService.getQna(seq));
		
		//좋아요 했는지 여부
		String loginId = UtilFunctions.getLoginId(req);
		if(loginId != null) {			
			model.addAttribute("isLike",likeService.isLike(new LikeDto(loginId,seq)));
		}else {
			model.addAttribute("isLike",false);
		}
		
		return "projectDetail.tiles";
	}
	
	// 프로젝트 관리 창으로 이동	
	@RequestMapping(value="projectManage.do", method= {RequestMethod.GET, RequestMethod.POST}) 
	public String projectManage(Model model, pageParam aParam) {
		logger.info("ProjectController projectManage 메소드 " + new Date());
		
		// paging 처리
		int sn = aParam.getPageNumber();
		int start = (sn) * aParam.getRecordCountPerPage() + 1;
		int end = (sn+1) * aParam.getRecordCountPerPage();
		
		aParam.setStart(start);
		aParam.setEnd(end);
		aParam.setStatus("waiting");
		
		List<ProjectDto> pList = projectService.getWaitingPagingList(aParam);
		int totalRecordCount = projectService.getWaitCount();
		
		model.addAttribute("pageNumber", sn);
		model.addAttribute("pageCountPerScreen", 10);	// 10개씩 표현한다. 페이지에서 표현할 총 페이지
		model.addAttribute("recordCountPerPage", aParam.getRecordCountPerPage());	// 맨끝 페이지의 개수 표현
		model.addAttribute("totalRecordCount", totalRecordCount);
		
		model.addAttribute("pList",pList);
		
		return "projectManage.tiles";
	}
		
	// 주문하기 창(결제 및 배송지 정보 입력)으로 이동 
	@RequestMapping(value="goOrderReward.do", method= {RequestMethod.GET, RequestMethod.POST}) 
	public String goOrderReward(int[] projectSeq, int[] selectOpSeq,int[] optionCount, Model model, HttpServletRequest req) { //선택된 옵션seq selectOptions 카운트optionCount
		logger.info("ProjectController goOrderReward 메소드 " + new Date());	
		
		//현재 선택한 프로젝트 정보 복수
		List<ProjectDto> projectdtolist = projectService.getProjectList(projectSeq);
		model.addAttribute("projectdtoList",projectdtolist);
		
		//로그인정보
		model.addAttribute("login",(MemberDto)req.getSession().getAttribute("login"));
		
		if(projectdtolist.get(0).isReward()) {//리워드일경우
			
			//선택한 옵션정보 
			List<OptionDto> optionList = projectService.getSelectOptions(selectOpSeq);
			model.addAttribute("selectOptions",optionList);
			
			//선택한 옵션 갯수, 해시맵 옵션seq : 갯수 value 으로 바꿀것
			model.addAttribute("optionCount",optionCount);
		}
		
		return "orderReward.tiles";

	}
	
	// 장바구니에서 주문하기 창(결제 및 배송지 정보 입력)으로 이동 ==> (승지 => 다슬이에게 값 넘겨주기 완료)
	@RequestMapping(value="goOrderFromBasket.do", method= {RequestMethod.GET, RequestMethod.POST}) 
	public String goOrderFromBasket(HttpServletRequest req, String projectSeq[], String optionSeq[], String count[]) {
		logger.info("ProjectController goOrderFromBasket 메소드 " + new Date());	
		
		MemberDto user = (MemberDto) req.getSession().getAttribute("login");
		logger.info("장바구니의 주인 id = " + user.getId());
		
		for (int i = 0; i < optionSeq.length; i++) {
			logger.info("구매희망 프로젝트 seq = " + projectSeq[i]);
			logger.info("구매희망 리워드 seq = " + optionSeq[i]);
			logger.info("희망 구매수량 = " + count[i]);
		}
		
		return "redirect:/myBasket.do";	// 일단 장바구니 창으로 가도록 임시설정해놈. 나중에 주문창으로 가도록 변경하기. 
		
	}
		
	// 프로젝트 검색
	@RequestMapping(value="searchProjectList.do", method= {RequestMethod.GET, RequestMethod.POST})
	public String searchProjectList(Model model, ProjectParam pParam, String doc_title) throws Exception{
		logger.info("ProjectController searchProjectList.do " + new Date());
		logger.info("searchProjectList.do 로 들어온 pParam : " + pParam.toString());
		
		// null 들어오면 xml 에서 오류 발생. 오류방지위함
		if(pParam.getS_type() == null) { pParam.setS_type(""); }
		if(pParam.getS_category() == null) { pParam.setS_category(""); }
		if(pParam.getS_keyword() == null) { pParam.setS_keyword(""); }
		if(pParam.getS_summary() == null) { pParam.setS_summary(""); }
		if(pParam.getS_complete() == null) { pParam.setS_complete(""); }
		if(pParam.getS_condition() == null) { pParam.setS_condition(""); }
		
		model.addAttribute("s_sort", pParam.getS_sort());	// 우선 원래값 보냄
		
		// doc_title 설정 (들어온 대로 보낸다)
		if(doc_title == null || doc_title.equals("")) {
			doc_title = "all";
		}
		
		model.addAttribute("doc_title", doc_title);
		
		// split 으로 DESC 구분하면 좋을 것 같긴한데
		if(pParam.getS_sort() == null || pParam.getS_sort().equals("")) {
			pParam.setS_sort("FUNDACHIVED");
			pParam.setS_asc_desc("DESC");
		} else if(pParam.getS_sort().equals("buycountDESC")) {
			pParam.setS_sort("BUYCOUNT");
			pParam.setS_asc_desc("DESC");
		} else if(pParam.getS_sort().equals("fundachivedDESC")) {
			pParam.setS_sort("FUNDACHIVED");
			pParam.setS_asc_desc("DESC");
		} else if(pParam.getS_sort().equals("sdateDESC")) {
			pParam.setS_sort("SDATE");
			pParam.setS_asc_desc("DESC");
		} else if(pParam.getS_sort().equals("edateASC")) {
			pParam.setS_sort("EDATE");
			pParam.setS_asc_desc("ASC");
		} else if(pParam.getS_sort().equals("regdateDESC")) {
			pParam.setS_sort("REGDATE");
			pParam.setS_asc_desc("DESC");
		}
		
//		logger.info("S_category" + pParam.getS_category() + "getS_complete" + pParam.getS_complete());
		
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
		model.addAttribute("s_complete", pParam.getS_complete());
		model.addAttribute("s_condition", pParam.getS_condition());
		
//		model.addAttribute("s_sort", pParam.getS_sort());	// 정렬기준
//		model.addAttribute("s_asc_desc", pParam.getS_asc_desc());	// 내림 오름 차순 기준
		
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
							Integer.parseInt(op_price[i]), -1));
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
			File file = new File(uploadPath + "/" + projectSeq);
			logger.info("파일 : " + uploadPath + "/" + projectSeq);	// 경로확인

			// [2]-3. 실제 업로드 부분
			FileUtils.writeByteArrayToFile(file, mainImage.getBytes());
		
		return "redirect:/projectDetail.do?seq=" + projectSeq;
	}
		
	// 스마트 에디터 이미지 업로드
	@ResponseBody	// <== ajax에 필수
	@RequestMapping(value="summernotePhotoUpload.do",produces="application/String; charset=UTF-8",
					method= {RequestMethod.GET, RequestMethod.POST}) 
	public String summernotePhotoUpload(HttpServletRequest request, HttpServletResponse response,
				@RequestParam("summerFile") MultipartFile summerFile) throws IOException {
		logger.info("summernotePhotoUpload 들어옴 " + new Date());
		logger.info("파일 원래 이름 = " + summerFile.getOriginalFilename());
		

		response.setContentType("text/html;charset=utf-8");
		// 업로드할 폴더 경로
		String realFolder = request.getSession().getServletContext().getRealPath("/upload");
		UUID uuid = UUID.randomUUID();
		
		// 업로드할 파일 이름
		String org_filename = summerFile.getOriginalFilename();
		String str_filename = uuid.toString() + org_filename;
		
		logger.info("원본 파일명 : " + org_filename);
		logger.info("저장할 파일명 : " + str_filename);

		String filepath = realFolder + "\\" + str_filename;
		logger.info("파일경로 : " + filepath);

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
		
		// 수정할 펀딩
		ProjectDto myProject = projectService.getProject(seq);
		model.addAttribute("myProject", myProject);
		
		List<OptionDto> myOption = null;
		if(myProject.getFundtype().equals("reward")) {
			// 펀딩에 딸린 리워드들
			myOption = projectService.getOptions(seq);
		}
		model.addAttribute("optionList", myOption);
		
		return "projectUpdate.tiles";
	}
	
	// 실제로 수정하는 메소드(승지)
	@RequestMapping(value="projectUpdateAf.do", method= {RequestMethod.GET, RequestMethod.POST}) 
	public String projectUpdateAf(ProjectDto newProjectDto,/* String proSeq,*/
							int option_total,
							String[] op_title, String[] op_content, String[] op_price, String[] op_stock,
							HttpServletRequest req,
							@RequestParam(value="fileload", required=false) MultipartFile newImage, String message) throws Exception {
		//logger.info("ProjectController projectUpdateAf 들어옴 " + new Date());
		// 업데이트 값 확인
		//logger.info("컨트롤러에 들어온 펀딩 수정입력 값 = " + newProjectDto.toString() );
		/*logger.info("수정할 펀딩의 seq = " + proSeq);*/
		//logger.info("새 이미지파일 이름 = "+newImage.getOriginalFilename());
		
		// 리워드 입력값 배열 모두 list로 변환.
		List<OptionDto> newPotionlist = new ArrayList<OptionDto>();
		//logger.info(option_total+"");
		//logger.info(Arrays.toString(op_stock));
		//logger.info(Arrays.toString(op_content));
		//logger.info(Arrays.toString(op_price));
		if(newProjectDto.getFundtype().equals("reward")) {
			for (int i = 0; i < option_total; i++) {
				//logger.info(i + "번째 재고 : [" + op_stock[i]+"]");
				if(op_stock[i] != null && op_stock[i].trim().length()>0) {
					logger.info("재고 있음");
					newPotionlist.add(new OptionDto(0, op_title[i], op_content[i], 
							Integer.parseInt(op_price[i]), Integer.parseInt(op_stock[i])));
				}else {
					logger.info("재고가 없어!!!무제한");
					newPotionlist.add(new OptionDto(0, op_title[i], op_content[i], Integer.parseInt(op_price[i]), 0));
				}
			}
			// 확인용
			for (int i = 0; i < newPotionlist.size(); i++) {
				logger.info(i + "번째 리워드 리스트 : " + newPotionlist.get(i).toString());
			}
		}
		
		// DB 수정
		projectService.updateProject(newProjectDto, newPotionlist, message);
		
		
		if(!newImage.isEmpty()) {	// 파일이 있을때		
			// 파일 수정
			String uploadPath = req.getServletContext().getRealPath("/upload");
			
			try {
				File file = new File(uploadPath + "/" + newProjectDto.getSeq());
				// 실제 업로드
				FileUtils.writeByteArrayToFile(file, newImage.getBytes());	// 해당 경로에 동일한 이름의 이미지 파일이 있으면 자동 덮어씌워질것.
			} catch(Exception e) {
				logger.info("수정 이미지 파일 업로드에 실패했습니다");
			}
			
		}else {
			System.out.println("들어온 이미지 파일이 없습니다");
		}
		return "redirect:/projectDetail.do?seq="+newProjectDto.getSeq();
	}
	
	// 내 등록 프로젝트 삭제하는 메소드(승지)
	@RequestMapping(value="projectDelete.do", method= {RequestMethod.GET, RequestMethod.POST}) 
	public String projectDelete(HttpServletRequest req, int seq) throws Exception {
		logger.info("ProjectController projectDelete 들어옴 " + new Date());
		if(UtilFunctions.getLoginId(req) == projectService.getProject(seq).getId()) { // 혹시 모르니 삭제 전에 로그인 정보를 확인
			projectService.deleteProject(seq);
		}
		return "redirect:/mySchedule.do";
	}
	
	// 프로젝트 승인
	@RequestMapping(value="approve.do", method= {RequestMethod.GET, RequestMethod.POST})
	public String approve(Model model, int projectseq) throws Exception{
		logger.info("approve " + new Date());
		projectService.approveProject(projectseq);
		
		return "redirect:/projectDetail.do?seq=" + projectseq;
	}
	
	// 프로젝트 거절
	@RequestMapping(value="rejectProject.do", method= {RequestMethod.GET, RequestMethod.POST})
	public String rejectProject(ProjectmsgDto msgDto) throws Exception{
		logger.info("rejectProject " + new Date());
		projectService.rejectProject(msgDto);
		
		return "redirect:/projectDetail.do?seq=" + msgDto.getProjectseq();
	}
	
	// 대기중인 프로젝트 갯수 가져오기
	@ResponseBody
	@RequestMapping(value="getWaitCount.do", method= {RequestMethod.GET, RequestMethod.POST})
	public String getWaitCount() throws Exception{
		logger.info("getWaitCount " + new Date());
				
		return projectService.getWaitCount()+""; 
	}
	
	// 이 프로젝트의 상태 메시지 가져오기
	@ResponseBody
	@RequestMapping(value="getStatusWithMessage.do", method= {RequestMethod.GET, RequestMethod.POST}, produces="text/plain;charset=UTF-8")
	public String getStatusWithMessage(int projectseq) throws Exception{
		List<ProjectmsgDto> msgList = projectService.getMsgList(projectseq);
		String messageData = "{\"items\":[";
		String messageFrom = "";
		for(int i=0;i<msgList.size();i++) {
			
			if(msgList.get(i).isResubmit()) {
				messageFrom = "작성자";
			}else {
				messageFrom = "에디터";
			}
			messageData += "{\"seq\":\"" + msgList.get(i).getSeq() +"\",";
			messageData += "\"proejctseq\":\"" + msgList.get(i).getProjectseq() +"\",";
			messageData += "\"writer\":\"" + messageFrom +"\",";
			messageData += "\"status\":\"" + msgList.get(i).getStatusKor() +"\",";
			messageData += "\"message\":\"" + msgList.get(i).getMessage() +"\",";
			messageData += "\"date\":\"" + UtilFunctions.getDateFormKorean(msgList.get(i).getRegdate()) +"\"}";
			if(i < msgList.size()-1) {
				messageData += ",";
			}
		}
		messageData += "]}";
		logger.info(messageData);
		
		return messageData; 
	}
	
	// 메인 화면으로 이동
	@RequestMapping(value="main.do", method= {RequestMethod.GET, RequestMethod.POST}) 
	public String goMain(Model model) throws Exception {
		logger.info("ProjectController goMain 메소드 " + new Date());	
		
		ProjectParam mainParam = new ProjectParam();
		
		// null 들어오면 xml 에서 오류 발생. 오류방지위함
		if(mainParam.getS_type() == null) { mainParam.setS_type(""); }
		if(mainParam.getS_category() == null) { mainParam.setS_category(""); }
		if(mainParam.getS_keyword() == null) { mainParam.setS_keyword(""); }
		if(mainParam.getS_summary() == null) { mainParam.setS_summary(""); }
		if(mainParam.getS_complete() == null) { mainParam.setS_complete("");}
		
		
		// split 으로 DESC 구분하면 좋을 것 같긴한데
		if(mainParam.getS_sort() == null || mainParam.getS_sort().equals("")) {
			mainParam.setS_sort("FUNDACHIVED");
			mainParam.setS_asc_desc("DESC");
		} else if(mainParam.getS_sort().equals("buycountDESC")) {
			mainParam.setS_sort("BUYCOUNT");
			mainParam.setS_asc_desc("DESC");
		} else if(mainParam.getS_sort().equals("fundachivedDESC")) {
			mainParam.setS_sort("FUNDACHIVED");
			mainParam.setS_asc_desc("DESC");
		} else if(mainParam.getS_sort().equals("sdateDESC")) {
			mainParam.setS_sort("SDATE");
			mainParam.setS_asc_desc("DESC");
		} else if(mainParam.getS_sort().equals("edateASC")) {
			mainParam.setS_sort("EDATE");
			mainParam.setS_asc_desc("ASC");
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
		
		
		///////////////////////////////////
		// 곧 마감되는 프로젝트 
		mainParam.setS_sort("EDATE");
		mainParam.setS_asc_desc("ASC");
		
		List<ProjectDto> edate_list = projectService.searchProjectList(mainParam);
		model.addAttribute("edate_list", edate_list);
		
		///////////////////////////////////
		// 메인 이미지 올린 4개 프로젝트
		// 성공한 프로젝트 중 모금액순
//		mainParam.setS_sort("BUYCOUNT");
//		mainParam.setS_asc_desc("DESC");
//		mainParam.setS_complete("complete");
//		
//		List<ProjectDto> success_list = projectService.searchProjectList(mainParam);
//		model.addAttribute("success_list", success_list);
				
		return "home.tiles";
	}
	
	/*------------- 화면만 이동 -------------*/
	
	// 새 프로젝트 창으로 이동
	@RequestMapping(value="newProject.do", method= {RequestMethod.GET, RequestMethod.POST}) 
	public String newProject() throws Exception{
		logger.info("ProjectController newProject 들어옴 " + new Date());
		return "newProject.tiles";
	}
	
	//내 일정 이동 (내 프로젝트 보기)
	@RequestMapping(value="mySchedule.do", method= {RequestMethod.GET, RequestMethod.POST})
	public String mySchedule(Model model, HttpServletRequest req, StatCountParam sParam) throws Exception{
		logger.info("ProjectController mySchedule " + new Date());
		logger.info("ProjectController getStatusCount " + new Date());
		
		String loginId = UtilFunctions.getLoginId(req); 
		sParam.setId(loginId);
		
		sParam.setStatus(ProjectDto.WAITING); // 이건 revise를 포함해서 가져올 거임 
		int waitCount = projectService.getStatusCount(sParam);
		model.addAttribute("waitCount", waitCount);

		sParam.setStatus(ProjectDto.REJECT);
		int rejCount = projectService.getStatusCount(sParam);
		model.addAttribute("rejCount", rejCount);
		
		sParam.setStatus(ProjectDto.PREPARING);
		int preCount = projectService.getStatusCount(sParam);
		model.addAttribute("preCount", preCount);
		
		sParam.setStatus(ProjectDto.ONGOING);
		int onCount =  projectService.getStatusCount(sParam);
		model.addAttribute("onCount", onCount);
		
		sParam.setStatus(ProjectDto.COMPLETE_SUCCESS);
		int sucCount =  projectService.getStatusCount(sParam);
		model.addAttribute("sucCount", sucCount);
		
		sParam.setStatus(ProjectDto.COMPLETE_FAIL);
		int failCount =  projectService.getStatusCount(sParam);
		model.addAttribute("failCount", failCount);
		
		// Intercepter 통해서 로그인 확인한 뒤에 오므로 세션 바로 사용해도 무방
		List<ProjectDto> myschedule = projectService.getMemberProjectList(loginId);
		
		/*for (int i = 0; i < myschedule.size(); i++) {
			ProjectDto dto = myschedule.get(i);
			logger.info("Schedule list : " + dto.toString());
		}*/
		model.addAttribute("schedule", myschedule);		
		return "mySchedule.tiles";
	}
	
	// 좋아요 변경
	@ResponseBody
	@RequestMapping(value="changeLike.do", method= {RequestMethod.GET, RequestMethod.POST}) 
	public Map<String, Object> changeLike(LikeDto like) {
		logger.info("changeLike " + new Date());
		boolean isLike = projectService.changeLike(like);
		int likeCount = projectService.getLikeCount(like.getProjectseq());
		
		Map<String, Object> rmap = new HashMap<String, Object>();
		rmap.put("isLike", isLike);
		rmap.put("likeCount", likeCount);		
		return rmap;
	}

	// 분야별 인기 프로젝트
	@RequestMapping(value="hotProject.do", method= {RequestMethod.GET, RequestMethod.POST})
	public String hotProject(Model model) throws Exception {
		logger.info("ProjectController hotProject " + new Date());
		
		model.addAttribute("doc_title", "categoryBest");
		
		///////////////////////////////////////////////////////////////////////////////
		// 기부 - 인권 프로젝트 1/5
		ProjectParam human_Param = new ProjectParam();
		
		// null 들어오면 xml 에서 오류 발생. 오류방지위함
		if(human_Param.getS_type() == null) { human_Param.setS_type(ProjectDto.TYPE_DONATION); }
		if(human_Param.getS_category() == null) { human_Param.setS_category(ProjectDto.CATEGORY_HUMAN); }
		if(human_Param.getS_keyword() == null) { human_Param.setS_keyword(""); }
		if(human_Param.getS_summary() == null) { human_Param.setS_summary(""); }
		if(human_Param.getS_complete() == null) { human_Param.setS_complete("");}
		
		
		// split 으로 DESC 구분하면 좋을 것 같긴한데
		if(human_Param.getS_sort() == null || human_Param.getS_sort().equals("")) {
			human_Param.setS_sort("FUNDACHIVED");
			human_Param.setS_asc_desc("DESC");
		} 
		
//		4페이지씩 보여주려고
		human_Param.setStart(1);
		human_Param.setEnd(4);
		human_Param.setRecordCountPerPage(8);
		
		List<ProjectDto> human_List = projectService.searchProjectList(human_Param);
		
		///////////////////////////////////////////////////////////////////////////////
		
		///////////////////////////////////////////////////////////////////////////////
		// 기부 - 동물 프로젝트 2/5
		ProjectParam dona_Animal_Param = new ProjectParam();
		
		// null 들어오면 xml 에서 오류 발생. 오류방지위함
		if(dona_Animal_Param.getS_type() == null) { dona_Animal_Param.setS_type(ProjectDto.TYPE_DONATION); }
		if(dona_Animal_Param.getS_category() == null) { dona_Animal_Param.setS_category(ProjectDto.CATEGORY_ANIMAL); }
		if(dona_Animal_Param.getS_keyword() == null) { dona_Animal_Param.setS_keyword(""); }
		if(dona_Animal_Param.getS_summary() == null) { dona_Animal_Param.setS_summary(""); }
		if(dona_Animal_Param.getS_complete() == null) { dona_Animal_Param.setS_complete("");}
		
		
		// split 으로 DESC 구분하면 좋을 것 같긴한데
		if(dona_Animal_Param.getS_sort() == null || dona_Animal_Param.getS_sort().equals("")) {
			dona_Animal_Param.setS_sort("FUNDACHIVED");
			dona_Animal_Param.setS_asc_desc("DESC");
		} 
		
//		4페이지씩 보여주려고
		dona_Animal_Param.setStart(1);
		dona_Animal_Param.setEnd(4);
		dona_Animal_Param.setRecordCountPerPage(8);
		
		List<ProjectDto> dona_Animal_List = projectService.searchProjectList(dona_Animal_Param);
		
		///////////////////////////////////////////////////////////////////////////////
		
		///////////////////////////////////////////////////////////////////////////////
		// 리워드 - 음식 프로젝트  3/5
		ProjectParam food_Param = new ProjectParam();
		
		// null 들어오면 xml 에서 오류 발생. 오류방지위함
		if(food_Param.getS_type() == null) { food_Param.setS_type(ProjectDto.TYPE_REWARD); }
		if(food_Param.getS_category() == null) { food_Param.setS_category(ProjectDto.CATEGORY_FOOD); }
		if(food_Param.getS_keyword() == null) { food_Param.setS_keyword(""); }
		if(food_Param.getS_summary() == null) { food_Param.setS_summary(""); }
		if(food_Param.getS_complete() == null) { food_Param.setS_complete("");}
		
		
		// split 으로 DESC 구분하면 좋을 것 같긴한데
		if(food_Param.getS_sort() == null || food_Param.getS_sort().equals("")) {
			food_Param.setS_sort("FUNDACHIVED");
			food_Param.setS_asc_desc("DESC");
		} 
		
//		4페이지씩 보여주려고
		food_Param.setStart(1);
		food_Param.setEnd(4);
		food_Param.setRecordCountPerPage(8);
		
		List<ProjectDto> food_List = projectService.searchProjectList(food_Param);
		
		///////////////////////////////////////////////////////////////////////////////
		
		///////////////////////////////////////////////////////////////////////////////
		// 리워드 - IT / 전자 프로젝트  4/5
		ProjectParam it_Param = new ProjectParam();
		
		// null 들어오면 xml 에서 오류 발생. 오류방지위함
		if(it_Param.getS_type() == null) { it_Param.setS_type(ProjectDto.TYPE_REWARD); }
		if(it_Param.getS_category() == null) { it_Param.setS_category(ProjectDto.CATEGORY_IT); }
		if(it_Param.getS_keyword() == null) { it_Param.setS_keyword(""); }
		if(it_Param.getS_summary() == null) { it_Param.setS_summary(""); }
		if(it_Param.getS_complete() == null) { it_Param.setS_complete("");}
		
		
		// split 으로 DESC 구분하면 좋을 것 같긴한데
		if(it_Param.getS_sort() == null || it_Param.getS_sort().equals("")) {
			it_Param.setS_sort("FUNDACHIVED");
			it_Param.setS_asc_desc("DESC");
		} 
		
//		4페이지씩 보여주려고
		it_Param.setStart(1);
		it_Param.setEnd(4);
		it_Param.setRecordCountPerPage(8);
		
		List<ProjectDto> it_List = projectService.searchProjectList(it_Param);
		
		///////////////////////////////////////////////////////////////////////////////
		
		///////////////////////////////////////////////////////////////////////////////
		// 리워드 - 동물 프로젝트  5/5
		ProjectParam reward_animal_Param = new ProjectParam();
		
		// null 들어오면 xml 에서 오류 발생. 오류방지위함
		if(reward_animal_Param.getS_type() == null) { reward_animal_Param.setS_type(ProjectDto.TYPE_REWARD); }
		if(reward_animal_Param.getS_category() == null) { reward_animal_Param.setS_category(ProjectDto.CATEGORY_ANIMAL); }
		if(reward_animal_Param.getS_keyword() == null) { reward_animal_Param.setS_keyword(""); }
		if(reward_animal_Param.getS_summary() == null) { reward_animal_Param.setS_summary(""); }
		if(reward_animal_Param.getS_complete() == null) { reward_animal_Param.setS_complete("");}
		
		
		// split 으로 DESC 구분하면 좋을 것 같긴한데
		if(reward_animal_Param.getS_sort() == null || reward_animal_Param.getS_sort().equals("")) {
			reward_animal_Param.setS_sort("FUNDACHIVED");
			reward_animal_Param.setS_asc_desc("DESC");
		}
		
//		4페이지씩 보여주려고
		reward_animal_Param.setStart(1);
		reward_animal_Param.setEnd(4);
		reward_animal_Param.setRecordCountPerPage(8);
		
		List<ProjectDto> reward_animal_List = projectService.searchProjectList(reward_animal_Param);
		
		///////////////////////////////////////////////////////////////////////////////
		
		model.addAttribute("human_List", human_List);
		model.addAttribute("dona_Animal_List", dona_Animal_List);
		model.addAttribute("food_List", food_List);
		model.addAttribute("it_List", it_List);
		model.addAttribute("reward_animal_List", reward_animal_List);
		
		return "hotProject.tiles";
	}
	
	//판매자의 프로젝트리스트
	@ResponseBody
	@RequestMapping(value="sellerPList.do", method= {RequestMethod.GET, RequestMethod.POST}, produces="text/plain;charset=UTF-8")
	public String sellerPList(String id) {
		logger.info("ProjectController sellerPList " + new Date());
		
		List<ProjectDto> pList = projectService.getSellerProjectList(id);
		String listData = "{\"projects\":[";		
		for(int i=0;i<pList.size();i++) {
			listData += "{\"title\":\"" + pList.get(i).getTitle() +"\"}";
			if(i < pList.size()-1) {
				listData += ",";
			}
		}
		listData += "]}";
		
		return listData;
	}
	
		
	/*	
	@RequestMapping(value="calendar.do", method= {RequestMethod.GET, RequestMethod.POST})
	public String calendar(Model model, myCal jcal, ProjectDto pro) throws Exception {
		logger.info("ProjectController calendar" + new Date());
		
		jcal.calculate();
		
		String yyyymm = CalendarUtil.yyyymm(jcal.getYear(), jcal.getMonth());
		
		ProjectDto fcal = new ProjectDto();
		fcal.setSeq(pro.getSeq());
		fcal.setRegdate(yyyymm);
		
		List<ProjectDto> flist = projectService.getCalendarList(pro);
		
		model.addAttribute("flist", flist);
		model.addAttribute("jcal", jcal);
		
		return null;		
	}
	*/
}
