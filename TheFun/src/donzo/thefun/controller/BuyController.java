
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
import donzo.thefun.model.MemberDto;
import donzo.thefun.model.OptionDto;
import donzo.thefun.model.ProjectDto;
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
	public String myOrderList(HttpServletRequest req, Model model) {
		logger.info("BuyController myOrderList 메소드 " + new Date());
		
		//로그인정보 (login 세션에서 로그인유저정보 가져옴)
		MemberDto user=(MemberDto) req.getSession().getAttribute("login");
		List<BuyDto> orderlist = buyService.orderList(user.getId());
		model.addAttribute("orderlist", orderlist);

		return "myOrder.tiles";
	} 
	
/*	//내 주문내역 상세보기
	@RequestMapping(value="myOrderDetail.do", method= {RequestMethod.GET, RequestMethod.POST})
	public String myOrderDetail(int projectSeq, HttpServletRequest req, Model model) {
		
		//프로젝트정보 seq
		//프로젝트옵션정보 n개 
		//작성자정보
		//결제정보
		
	}
*/	
	//주문완료
	@RequestMapping(value="addOrder.do", method= {RequestMethod.GET, RequestMethod.POST}) 
	public String addOrder(String fundtype, BuyDto newbuy, int[] opSeq, int[] opPrice, int[] opCount, Model model) {
		logger.info("BuyController addOrder 메소드 " + new Date());
		
		System.out.println("buy 컨트롤러 dto : "+newbuy);
		
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
	
 
}  
