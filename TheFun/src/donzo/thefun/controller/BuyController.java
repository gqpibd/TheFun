
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
import donzo.thefun.util.UtilFunctions;


@Controller
public class BuyController {
	
	private static final Logger logger = LoggerFactory.getLogger(BuyController.class);
	 
	@Autowired
	BuyService buyService;
	
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
	
	//주문완료
	@RequestMapping(value="addOrder.do", method= {RequestMethod.GET, RequestMethod.POST}) 
	public String addOrder(BuyDto newbuy, int[] opSeq, int[] opCount, int[] opPrice, Model model) {
		logger.info("BuyController addOrder 메소드 " + new Date());

		//주문 insert
		buyService.addOrders(newbuy, opSeq, opCount, opPrice);
		
		return "redirect:/myOrderList.do";
	}	
	
	// 후기 등록
	@RequestMapping(value="addReview.do", method= {RequestMethod.GET, RequestMethod.POST})
	public String addReview(BuyDto buydto) {
		logger.info("addReview" + new Date());
		
		buyService.addReview(buydto);
		
		return "redirect:/projectDetail.do?seq=" + buydto.getProjectseq();
	}
	
	// 후기 목록 가져오기	
	@ResponseBody
	@RequestMapping(value="selectReviewList.do", method= {RequestMethod.GET, RequestMethod.POST}, produces="text/plain;charset=UTF-8")
	public String selectReviewList(int seq) {		
		logger.info("selectReviewList" + new Date());
		List<BuyDto> reviewList = buyService.selectReviewList(seq);
		String listData = "{\"reviews\":[";		
		for(int i=0;i<reviewList.size();i++) {			
			listData += "{\"seq\":\"" + reviewList.get(i).getSeq() +"\",";
			listData += "\"otitle\":\"" + reviewList.get(i).getOtitle() +"\","; // 옵션 제목
			listData += "\"ocontent\":\"" + reviewList.get(i).getOcontent().replaceAll("\r\n", "/") +"\","; // 옵션 내용
			listData += "\"nickname\":\"" + reviewList.get(i).getId() +"\","; // 아이디 대신 닉네임으로 가져왔음
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
