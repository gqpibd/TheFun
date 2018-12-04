
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

import donzo.thefun.model.BuyDto;
import donzo.thefun.model.MemberDto;
import donzo.thefun.model.OptionDto;
import donzo.thefun.model.ProjectDto;
import donzo.thefun.service.BuyService;
import donzo.thefun.service.ProjectService;


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

	/*-------------이 아래는 페이지 이동--------------*/
	
		
	
}  
