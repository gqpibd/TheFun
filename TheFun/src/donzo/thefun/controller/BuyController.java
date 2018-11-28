
package donzo.thefun.controller;

import java.util.Date;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import donzo.thefun.model.BuyDto;
import donzo.thefun.model.ProjectDto;
import donzo.thefun.service.BuyService;


@Controller
public class BuyController {
	
	private static final Logger logger = LoggerFactory.getLogger(BuyController.class);
	 
	@Autowired
	BuyService buyService;
	
	// 내 주문 내역 목록 (myOrderHistory)
	@RequestMapping(value="myOrderList.do", method= {RequestMethod.GET, RequestMethod.POST})
	public String myOrderList(Model model, BuyDto buy) {
		logger.info("BuyController myOrderList 메소드 " + new Date());
		
		List<BuyDto> orderlist = buyService.orderList(buy);
		
		model.addAttribute("orderlist", orderlist);

		return "myOrder.tiles";
	} 
	 
	//주문완료
	@RequestMapping(value="addOrder.do", method= {RequestMethod.GET, RequestMethod.POST}) 
	public String addOrder(String loginId,int projectSeq, int[] opSeq, int[] opCount, Model model) {
		
		//주문 insert
		buyService.addOrders(loginId,projectSeq, opSeq, opCount);
		return "redirect:/main.do";
	}
	
	/*-------------이 아래는 페이지 이동--------------*/
	
		
	
}  
