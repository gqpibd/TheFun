package donzo.thefun.controller;

import java.util.ArrayList;
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

import donzo.thefun.model.BasketDto;
import donzo.thefun.model.BuyDto;
import donzo.thefun.model.MemberDto;
import donzo.thefun.service.BasketService;

@Controller
public class BasketController {
	private static final Logger logger = LoggerFactory.getLogger(BasketController.class);
	 
	@Autowired
	BasketService basketService;
	
	
	//장바구니 넣기 addBasket.do
	@RequestMapping(value="addBasket.do", method= {RequestMethod.GET, RequestMethod.POST}) 
	public void addBasket(int projectSeq, int[] optionSeq, int[] optionCount, HttpServletRequest req) {
		logger.info(" BuyController addBasket" + new Date());
		
		String id = ((MemberDto)req.getSession().getAttribute("login")).getId();
		
		System.out.println("id : "+id+" / projectSeq : "+projectSeq);
		for(int i=0; i<optionCount.length;i++) {
			logger.info("옵션 시퀀스  : "+optionSeq[i] +"옵션 카운트 : "+optionCount[i]);
		}

		//장바구니 insert
		
	}
	
	// 장바구니 창으로
	@RequestMapping(value="myBasket.do", method= {RequestMethod.GET, RequestMethod.POST})
	public String myBasket(String id, Model model) throws Exception {
		logger.info("BuyController basket 들어옴 " + new Date());
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
	
	// 장바구니 삭제
	@RequestMapping(value="deleteBasket.do", method= {RequestMethod.GET, RequestMethod.POST})
	public String deleteBasket(int seq, String id) throws Exception{
		logger.info("BuyController deleteBasket 들어옴 " + new Date());
		logger.info("삭제할 장바구니의 seq값 = " + seq);
		logger.info("삭제할 장바구니의 주인 id = " + id);
		
		// 장바구니 DB에서 해당 리워드 삭제
		int success = basketService.deleteBasket(seq);
		if(success > 0) {
			logger.info("장바구니 삭제에 성공했습니다");
		}else {
			logger.info("장바구니 삭제에 실패했습니다");
		}
		
		return "redirect:myBasket.do?id="+id;
	}
	
	// 장바구니 업데이트
	@RequestMapping(value="updateBasket.do", method= {RequestMethod.GET, RequestMethod.POST})
	public String updateBasket(String id, String seq[], String count[]/* BasketDto basketDto*/) throws Exception{
		logger.info("BuyController updateBasket 들어옴 " + new Date());
		//seq랑 count만 알면됨
		
		logger.info("id = " + id);
		
		List<BasketDto> list = new ArrayList<BasketDto>();
		for (int i = 0; i < seq.length; i++) {
			logger.info("업뎃에 들어온 "+i+"번째 seq = " + seq[i]);
			logger.info("업뎃에 들어온 "+i+"번째  count = " + count[i]);
			BasketDto updateDto = new BasketDto();
			updateDto.setSeq(Integer.parseInt(seq[i]));
			updateDto.setCount(Integer.parseInt(count[i]));
			list.add(updateDto);
		}
		
		// DB 장바구니 업데이트
		basketService.updateBasket(list);
		
		return "redirect:myBasket.do?id="+id;
	}
	
}
