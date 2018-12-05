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

import donzo.thefun.model.BasketDto;
import donzo.thefun.service.BasketService;

@Controller
public class BasketController {
	private static final Logger logger = LoggerFactory.getLogger(BasketController.class);
	 
	@Autowired
	BasketService basketService;
	

	// 장바구니 창으로
	@RequestMapping(value="myBasket.do", method= {RequestMethod.GET, RequestMethod.POST})
	public String myBasket(String id, Model model) throws Exception {
		logger.info("BuyController basket들어옴 " + new Date());
		logger.info("아이디 = " + id);
		// 내 장바구니 목록(view) 찾아오기(SEQ, ID, PROJECTSEQ, OPTIONSEQ, COUNT, REGDATE, PTITLE, OTITLE, OCONTENT, STATUS, PRICE)
		List<BasketDto> myBasketList = basketService.selectMyBasket(id);
		logger.info("찾아온 장바구니 목록 개수 = " + myBasketList.size());  
		for (int i = 0; i < myBasketList.size(); i++) {
			logger.info("찾아온 장바구니 = " + myBasketList.toString());
		}
		model.addAttribute("myBasket", myBasketList);
		
		return "basket.tiles";
	}
	
	
	
	@RequestMapping(value="testbasket.do", method= {RequestMethod.GET, RequestMethod.POST}) 
	public void testbasket() {
		logger.info("testbasket" + new Date());
		logger.info("●●●●●●잘들어왔슈~~~~~~~~~~~~~~~~~~~");
		
	}
	
	
	//장바구니 넣기 addBasket.do
	@RequestMapping(value="addBasket.do", method= {RequestMethod.GET, RequestMethod.POST}) 
	public void addBasket(String id, int projectSeq, int[] optionSeq, int[] optionCount) {
		logger.info(" BuyController addBasket" + new Date());
		
		System.out.println("id : "+id+" / projectSeq : ");
		for(int i=0; i<optionCount.length;i++) {
			logger.info("옵션 시퀀스  : "+optionSeq[i] +"옵션 카운트 : "+optionCount[i]);
		}

		//장바구니 insert
		 
	}
}
