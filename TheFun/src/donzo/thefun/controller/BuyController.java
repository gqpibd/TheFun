
package donzo.thefun.controller;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import donzo.thefun.model.BuyDto;
import donzo.thefun.model.BuyGroupParam;
import donzo.thefun.model.MemberDto;
import donzo.thefun.model.buyParam;
import donzo.thefun.service.BuyService;
import donzo.thefun.service.MemberService;
import donzo.thefun.util.UtilFunctions;


@Controller
public class BuyController {
	
	private static final Logger logger = LoggerFactory.getLogger(BuyController.class);
	 
	@Autowired
	BuyService buyService;
	 
	@Autowired
	MemberService memberService;
	
	// 내 주문 내역 목록 (myOrderHistory)
	@RequestMapping(value="myOrderList.do", method= {RequestMethod.GET, RequestMethod.POST})
	public String myOrderList(HttpServletRequest req, Model model, buyParam param) {
		logger.info("BuyController myOrderList 메소드 " + new Date());
		//logger.info("myOrderList.do 로 들어온 param : " + param.toString());		
		
		//로그인정보 (login 세션에서 로그인유저정보 가져옴)
		//MemberDto user=(MemberDto) req.getSession().getAttribute("login");

		param.setO_id(UtilFunctions.getLoginId(req));
		
		int totalRecordCount = buyService.getOrderCount(param);

		// paging 처리
		int sn = param.getPageNumber();
		int start = (sn) * param.getRecordCountPerPage() + 1;
		int end = (sn+1) * param.getRecordCountPerPage();
		
		param.setStart(start);
		param.setEnd(end);
		
		List<BuyDto> orderlist = buyService.myOrderPageList(param);
		for(int i=0;i<orderlist.size();i++) {
			BuyDto b = orderlist.get(i);
			logger.info(b.toString());
			BuyGroupParam gparam = buyService.getBuyGroupInfo(b);
			//logger.info(gparam.toString());
			if(gparam.getGroupCount()>1) {
				b.setCount(gparam.getTotalcount());
				b.setOtitle(b.getOtitle() + "외 " + (gparam.getGroupCount()-1));
				b.setPrice(gparam.getTotalprice());
			}
		}
/*		//리스트 확인용
		for (int i = 0; i < orderlist.size(); i++) {
			BuyDto dto = orderlist.get(i);
			logger.info("후원내역 리스트 확인 : " + dto.toString());
		}
		*/
		model.addAttribute("pageNumber", sn);
		model.addAttribute("pageCountPerScreen", 10);	// 10개씩 표현한다. 페이지에서 표현할 총 페이지
		model.addAttribute("recordCountPerPage", param.getRecordCountPerPage());	// 맨끝 페이지의 개수 표현
		model.addAttribute("totalRecordCount", totalRecordCount);
		model.addAttribute("orderlist", orderlist);
		
		return "myOrder.tiles";
	} 
	
	//내 후원 상세보기
	@RequestMapping(value="myOrderDetail.do", method= {RequestMethod.GET, RequestMethod.POST})
	public String myOrderDetail(int projectSeq, String regiDate, HttpServletRequest req, Model model) {
		logger.info("BuyController myOrderDetail 메소드 " + new Date());
		
		MemberDto user=(MemberDto) req.getSession().getAttribute("login");
		model.addAttribute("login",user);
		
		//xml 보낼 dto
		BuyDto buy = new BuyDto(user.getId(), projectSeq, 1, regiDate.substring(0, 19));		
		List<BuyDto> buydto = buyService.myOrderDetail(buy);
		model.addAttribute("buydto",buydto);
		return "myOrderDetail.tiles";
	}
	
	//주문완료
	@RequestMapping(value="addOrder.do", method= {RequestMethod.GET, RequestMethod.POST}) 
	public String addOrder(String fundtype, BuyDto newbuy, int[] opSeq, int[] opPrice, int[] opCount, Model model) {
		logger.info("BuyController addOrder 메소드 " + new Date());
		
		//주문 insert
		buyService.addOrders(newbuy, opSeq, opPrice,opCount, fundtype);
		return "redirect:/myOrderList.do";
	}	
	
	// 후기 등록
	@RequestMapping(value="writeReview.do", method= {RequestMethod.GET, RequestMethod.POST})
	public String writeReview(BuyDto buydto, int point, HttpServletRequest req) throws Exception {
		logger.info("writeReview" + new Date());
		
		buyService.addReview(buydto);
		MemberDto mem = new MemberDto();
		mem.setId(buydto.getId());
		mem.setPoint(point);
		memberService.addPoint(mem); 
		
		// 변경된 포인트를 바로 확인할 수 있도록 현재 세션에 저장된 로그인 정보를 업데이트 해준다
		req.getSession().invalidate();
		req.getSession().setAttribute("login", memberService.getUserInfo(mem.getId()));
		
		return "redirect:/myOrderList.do";
	}
	
	// 후기 목록 가져오기	
	@ResponseBody
	@RequestMapping(value="selectReviewList.do", method= {RequestMethod.GET, RequestMethod.POST}, produces="text/plain;charset=UTF-8")
	public String selectReviewList(int seq) throws Exception {		
		logger.info("selectReviewList" + new Date());
		List<BuyDto> reviewList = buyService.selectReviewList(seq);
		String listData = "{\"reviews\":[";		
		for(int i=0;i<reviewList.size();i++) {		
			MemberDto member = memberService.getUserInfo(reviewList.get(i).getId());
			listData += "{\"seq\":\"" + reviewList.get(i).getSeq() +"\",";
			listData += "\"otitle\":\"" + reviewList.get(i).getOtitle() +"\","; // 옵션 제목
			listData += "\"ocontent\":\"" + reviewList.get(i).getOcontent().replaceAll("\r\n", "/") +"\","; // 옵션 내용
			listData += "\"nickname\":\"" + member.getNickname() +"\","; // 아이디 대신 닉네임으로 가져왔음
			listData += "\"profile\":\"" + member.getProfile() +"\","; // 프로필 사진 출력용
			listData += "\"date\":\"" + UtilFunctions.getDateFormKorean2(reviewList.get(i).getRegdate()) +"\",";
			listData += "\"score\":\"" + reviewList.get(i).getScore() +"\",";			
			listData += "\"comment\":\"" + reviewList.get(i).getBcomment() +"\"}";
			if(i < reviewList.size()-1) {
				listData += ",";
			}
		}
		listData += "]}";
		logger.info(listData);
		
		return listData; 
	}
	
	/*내가 진행 중인 프로젝트 참여 현황*/
	@RequestMapping(value="participant.do", method= {RequestMethod.GET, RequestMethod.POST})
	public String participant(BuyDto buyDto, Model model, String title) throws Exception {
		logger.info("ProjectController participant.do 들어옴 " + new Date());
		
//		ProjectDto participant_Dto = projectService.getProject(seq); // 프로젝트 정보가 필요해서... 생성 일단 보류
		List<BuyDto> participant_List = buyService.getParticipantList(buyDto); // 참여자 정보가 필요해서
		
		/*model.addAttribute("participant_Dto", participant_Dto);*/
		model.addAttribute("participant_List", participant_List);
		
		model.addAttribute("title", title);
		model.addAttribute("seq", buyDto.getSeq());
		
		return "project_participant.tiles";
	}
	
	
}  
