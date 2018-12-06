
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
	//@RequestMapping(value="addOrder.do", method= {RequestMethod.GET, RequestMethod.POST}) 
	//public String addOrder(BuyDto newbuy, int[] opSeq, int[] opCount, int[] opPrice, Model model) {
	//	logger.info("BuyController addOrder 메소드 " + new Date());

		//주문 insert
	//	buyService.addOrders(newbuy, opSeq, opCount, opPrice);
		
	//	return "redirect:/myOrderList.do";
	//}
	
	
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
	
	// 장바구니 창으로
	@RequestMapping(value="myBasket.do", method= {RequestMethod.GET, RequestMethod.POST})
	public String myBasket(String id, Model model) throws Exception {
		logger.info("BuyController basket 들어옴 " + new Date());
		logger.info("아이디 = " + id);
		// 내 장바구니 목록(view) 찾아오기(SEQ, ID, PROJECTSEQ, OPTIONSEQ, COUNT, REGDATE, PTITLE, OTITLE, OCONTENT, STATUS, PRICE)
		List<BuyDto> myBasketList = buyService.selectMyBasket(id);
		logger.info("찾아온 장바구니 목록 개수 = " + myBasketList.size());
		for (int i = 0; i < myBasketList.size(); i++) {
			logger.info("찾아온 장바구니 = " + myBasketList.toString());
		}
		model.addAttribute("myBasket", myBasketList);
		
		return "basket.tiles";
	}
	
	@RequestMapping(value="deleteBasket.do", method= {RequestMethod.GET, RequestMethod.POST})
	public String deleteBasket(int seq, String id) throws Exception{
		logger.info("BuyController deleteBasket 들어옴 " + new Date());
		logger.info("삭제할 장바구니의 seq값 = " + seq);
		logger.info("삭제할 장바구니의 주인 id = " + id);
		
		// 장바구니 DB에서 해당 리워드 삭제
		int success = buyService.deleteBasket(seq);
		if(success > 0) {
			logger.info("장바구니 삭제에 성공했습니다");
		}else {
			logger.info("장바구니 삭제에 실패했습니다");
		}
		
		return "redirect:myBasket.do?id="+id;
	}
	
	@RequestMapping(value="updateBasket.do", method= {RequestMethod.GET, RequestMethod.POST})
	public String updateBasket(int seq, String id) throws Exception{
		logger.info("BuyController deleteBasket 들어옴 " + new Date());
		logger.info("삭제할 장바구니의 seq값 = " + seq);
		logger.info("삭제할 장바구니의 주인 id = " + id);
		
		return "redirect:myBasket.do?id="+id;
	}
	
	
}  
