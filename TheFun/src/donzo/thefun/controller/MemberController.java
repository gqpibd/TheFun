package donzo.thefun.controller;

import java.io.File;
import java.io.IOException;
import java.util.Date;

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
import donzo.thefun.service.MemberService;
import donzo.thefun.util.FUpUtil;


@Controller
public class MemberController {
	
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
	
	@Autowired
	MemberService memberService;	
	
	// 로그인 처리
	@RequestMapping(value="loginAf.do", method= {RequestMethod.GET, RequestMethod.POST}) 
	public String loginAf(HttpServletRequest req, Model model, MemberDto dto, String loginType) {
		logger.info("MemberController loginAf " + new Date());
		logger.info(dto.toString());
		logger.info(loginType);
		if(dto.getPwd() != null && loginType.equals("normal")) { // 계정 연동 로그인이 아닌 경우
			dto = memberService.tryLogin(dto);
			if(dto == null) { // 로그인 실패
				return "redirect:/login.do?message=retry";
			}
		}else if(loginType.equals("externalAccount")){ // 계정 연동 로그인인 경우
			logger.info("로그인 결과:" + dto);
			dto = memberService.tryLogin(dto);
		}
		req.getSession().setAttribute("login", dto);
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
			if(imgPath.equals(MemberDto.DEFAULTIMGPATH)) { // 기본이 이미지인 경우 업로드가 필요 없다.
				mem.setAddress(imgPath);
			}else {
				String f = fname;
				String newFile = FUpUtil.getNewFile(f,mem.getId()); // 파일 이름을 사용자의 아이디로 바꿈
				//pdsdto.setFilename(newFile);
				//파일 업로드
				try {
					File file = new File(fupload + "/" + newFile);
					logger.info(file.getPath());
					// 파일 업로드 작업
					FileUtils.writeByteArrayToFile(file, fileload.getBytes());	
					mem.setAddress("image/profile/"+newFile);
				}catch(Exception e) {
					e.printStackTrace();
				}
			}
		}
		memberService.updateMember(mem);
		
		req.getSession().invalidate();
		req.getSession().setAttribute("login", mem);
		return "redirect:/myInfo.do?id=" + mem.getId();
	}	
	
	// 내 정보 불러오기(내정보 보기)
	@RequestMapping(value="myInfo.do", method= {RequestMethod.GET, RequestMethod.POST})
	public String getMyinfo(MemberDto mem, Model model) throws Exception{
		logger.info("MemberController myInfo " + new Date());
		logger.info("myInfo mem" + mem.toString());
		MemberDto myinfo = memberService.getMypage(mem);		
				
		model.addAttribute("myi", myinfo);
		
		//return "getMypage.tiles";
		return "mypage/myInfo";	
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
		logger.info("MemberController regiAf " + new Date());
		logger.info("MemberController dto = " + dto);
		if(memberService.addAccount(dto)) {
			try {
				resp.getWriter().println("<script>alert('회원가입이 완료되었습니다. 로그인 해주세요')</script>");
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return "redirect:/login.do";
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
	
	/*-------------이 아래는 페이지 이동만--------------*/
	// 로그인 페이지로 이동
	@RequestMapping(value="login.do", method= {RequestMethod.GET, RequestMethod.POST}) 
	public String login(Model model, String message) {		
		logger.info("MemberController login " + new Date());	
		
		model.addAttribute("message",message);
		return "account/login";
	}
	
	// 마이페이지로 이동
	@RequestMapping(value="getMypage.do", method= {RequestMethod.GET, RequestMethod.POST})
	public String getMypage(HttpServletRequest req, Model model) throws Exception{
		logger.info("MemberController getMypage " + new Date());		
		
		return "mypage/mypage";
	}
}
