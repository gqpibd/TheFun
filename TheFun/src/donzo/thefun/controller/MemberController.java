package donzo.thefun.controller;

import java.io.File;
import java.util.Date;
import java.util.List;

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

import donzo.thefun.model.MemberDto;
import donzo.thefun.model.MyChartDto;
import donzo.thefun.model.ProjectDto;
import donzo.thefun.service.MemberService;
import donzo.thefun.service.ProjectService;
import donzo.thefun.util.FUpUtil;


@Controller
public class MemberController {
	
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
	
	@Autowired
	MemberService memberService;
	
	@Autowired
	ProjectService projectService; 
	
	//로그인 처리
	@RequestMapping(value="loginAf.do", method= {RequestMethod.GET, RequestMethod.POST}) 
	public String loginAf(HttpServletRequest req, Model model, MemberDto dto, String loginType, String callback) throws Exception {
		logger.info("loginAf " + new Date());
		MemberDto loginUser=null;
		logger.info(loginType);		
		
		if(dto.getPwd() != null && loginType.equals("normal")) { // 계정 연동 로그인이 아닌 경우
			loginUser = memberService.tryLogin(dto);
			if(loginUser == null) { // 로그인 실패
				return "redirect:/login.do?message=retry&callback=" + callback;
			}
		}else if(loginType.equals("kakao") || loginType.equals("naver") ||loginType.equals("google") || loginType.equals("facebook")){ // 계정 연동 로그인인 경우
			loginUser = memberService.tryLogin(dto);			
		}
		loginUser.setAccount(loginType);
		logger.info("로그인 결과: " + loginUser.toString());
		req.getSession().setAttribute("login", loginUser);
		
		if(callback!=null) {
			callback = callback.replaceAll("_/_", "&"); //&로 바로 보내면 잘리니까 /로 보내고 받은 다음에 바꿔서 보여줌
			return "redirect:/" + callback;
		}
		return "redirect:/main.do";
	}
	
	// 내 정보 수정
	@RequestMapping(value="updateInfo.do", method= RequestMethod.POST)
	public String updateInfo(MemberDto mem, String imgPath, Model model, HttpServletRequest req,
			  @RequestParam(value="fileload", required=false)MultipartFile fileload) throws Exception{
		logger.info("updateInfo " + new Date());
		logger.info("updateInfo mem : " + mem.toString());
		
		//pdsdto.setFilename(fileload.getOriginalFilename());
		String fname = fileload.getOriginalFilename(); 
		String fupload = req.getServletContext().getRealPath("/image/profile");
		
		if(fname!=null && !fname.equals("")) {// 프로필 사진이 변경된 경우
			String f = fname;
			String newFile = FUpUtil.getNewFile(f,mem.getId()); // 파일 이름을 사용자의 아이디로 바꿈
			//pdsdto.setFilename(newFile);
			//파일 업로드
			try {
				File file = new File(fupload + "/" + newFile);
				logger.info(file.getPath());
				// 파일 업로드 작업
				FileUtils.writeByteArrayToFile(file, fileload.getBytes());	
				mem.setProfile("image/profile/"+newFile);
			}catch(Exception e) {
				e.printStackTrace();
			}
		}else if(imgPath.equals(MemberDto.DEFAULTIMGPATH)) { // 기본이 이미지인 경우 업로드가 필요 없다.
			mem.setProfile(imgPath);
		}
		memberService.updateMember(mem);
		
		req.getSession().invalidate();
		req.getSession().setAttribute("login", mem);
		return "redirect:/myInfo.do";
	}	
	
	// 로그아웃 처리
	@RequestMapping(value="logout.do", method= {RequestMethod.GET, RequestMethod.POST}) 
	public String logout(HttpServletRequest req) {
		logger.info("MemberController logout " + new Date());		
		req.getSession().invalidate();
		return "redirect:/main.do";
	}
	
	// 회원가입 처리
	@RequestMapping(value="regiAf.do", method= {RequestMethod.GET, RequestMethod.POST}) 
	public String regiAf(HttpServletResponse resp, MemberDto dto) {
		logger.info("regiAf " + new Date());
		logger.info("dto = " + dto);
		memberService.addAccount(dto);
		if(dto.getPwd() == null) { // 연동로그인인 경우 바로 로그인시켜준다
			return "redirect:/loginAf.do?id="+dto.getId() +"&loginType=" + dto.getAccount();
		}
		return "redirect:/login.do?message='registered'";
	}
	
	//idpw찾기 처리
	@ResponseBody
	@RequestMapping(value="find_idpw.do", method= {RequestMethod.GET, RequestMethod.POST})
	public String find_idpw(MemberDto dto) {
		logger.info("find_idpw" + new Date());
		
		MemberDto find_idpw = memberService.find_idpw(dto);
		logger.info(find_idpw.toString());
		
		return find_idpw.getId();
	}
	
	
	
	/*-------------Ajax--------------*/
	// 아이디 중복 검사
	@ResponseBody
	@RequestMapping(value="idCheck.do", method= {RequestMethod.GET, RequestMethod.POST}) 
	public String idCheck(String id) {
		logger.info("MemberController idCheck " + new Date());
		String result = "OK";
		if(memberService.idExists(id)) {
			result = "NOTOK";
		}
		return result;
	}	
	
	// 비밀번호 검사 --> 회원정보 수정시
	@ResponseBody
	@RequestMapping(value="pwdCheck.do", method=RequestMethod.POST) 
	public String pwdCheck(MemberDto dto) {
		logger.info("MemberController pwdCheck " + new Date());
		String result = "NOTOK";
		if(memberService.tryLogin(dto)!=null) {
			result = "OK";
		}
		return result;
	}	
	
	// 이메일 중복 검사
	@ResponseBody
	@RequestMapping(value="emailCheck.do", method= {RequestMethod.GET, RequestMethod.POST}) 
	public String emailCheck(String email) {
		logger.info("MemberController emailCheck " + new Date());
		String result = "OK";
		if(memberService.emailExists(email)) {
			result = "NOTOK";
		}
		return result;
	}		
	
	/*-------------이 아래는 페이지 이동--------------*/
	// 로그인 페이지로 이동
	@RequestMapping(value="login.do", method= {RequestMethod.GET, RequestMethod.POST}) 
	public String login(Model model, String message, String callback) {		
		logger.info("MemberController login " + new Date());	
		
		model.addAttribute("message",message);
		model.addAttribute("callback",callback);
		return "login.tiles";
	}
	
	// idpw찾기 폼으로 이동
		@RequestMapping(value="find_id_from.do", method= {RequestMethod.GET, RequestMethod.POST})
		public String find_id_from(Model model, String message, String callback) {
			logger.info("MemberController login " + new Date());	
			
			model.addAttribute("message",message);
			model.addAttribute("callback",callback);
			
			return "find_id_from.tiles";
		}
	
	// 마이페이지로 이동
	@RequestMapping(value="myPage.do", method= {RequestMethod.GET, RequestMethod.POST})
	public String getMypage() throws Exception{
		logger.info("MemberController getMypage " + new Date());		
		
		return "MyPage.tiles";
	}
		
	// 내 정보 보기, 수정하기 페이지로 이동
	@RequestMapping(value="myInfo.do", method= {RequestMethod.GET, RequestMethod.POST})
	public String getMyinfo() throws Exception{
		logger.info("MemberController myInfo " + new Date());
		
		return "myInfo.tiles";	
	}
	
	@RequestMapping(value="myChart.do", method= {RequestMethod.GET, RequestMethod.POST})
	public String myChart(String id, Model model) throws Exception{
		// 유저 정보 가져오기
		logger.info("유저 id = " + id);
		MemberDto user = memberService.getUserInfo(id);
		logger.info("유저 정보 = " + user.toString());
		model.addAttribute("user", user);
		
		// 내 모든 프로젝트 가져오기
		List<ProjectDto> myProject = projectService.myAllProject(id);
		logger.info("내 프로젝트 리스트 길이 = " + myProject.size());
		// 가져온 프로젝트로 기부/리워드 퍼센트 평균내기
		int length = 0;
		double reward = 0;
		double donation = 0;
		if(myProject.size()>0) {
			length = myProject.size();
			for (int i = 0; i < myProject.size(); i++) {
				logger.info((i+1) + "번째 프로젝트 내용 = " + myProject.toString());
				if(myProject.get(i).getFundtype().equals("reward")) {
					reward +=1;
				}else if(myProject.get(i).getFundtype().equals("donation")) {
					donation +=1;
				}
			}
			logger.info("reward 프로젝트의 갯수 = " + reward);
			logger.info("donation 프로젝트의 갯수 = " + donation);
			
			reward = (reward/length)*100;
			donation = (donation/length)*100;
			
			logger.info("reward 프로젝트의 퍼센트 = " + reward);
			logger.info("donation 프로젝트의 퍼센트 = " + donation);
			
			MyChartDto myproject = new MyChartDto(length+"", Math.round(reward)+"", Math.round(donation)+"");
			
			model.addAttribute("myProject", myproject);
		}
		
		return "myChart.tiles";
	}
	
/*	// 내 일정 보기 ( 캘린더 테스트..)
	@RequestMapping(value="myCalendar.do", method= {RequestMethod.GET, RequestMethod.POST})
	public String myCalendar(Model model) throws Exception{	
		logger.info("MemberController myCalendar " + new Date());
		
		return "myCalendar.tiles";	
	}*/
	
}
