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

import donzo.thefun.model.BasketDto;
import donzo.thefun.model.MemberDto;
import donzo.thefun.model.OptionDto;
import donzo.thefun.service.BasketService;
import donzo.thefun.service.ProjectService;

@Controller
public class BasketController {
	private static final Logger logger = LoggerFactory.getLogger(BasketController.class);
	 
	@Autowired
	BasketService basketService;
	
	@Autowired
	ProjectService projectService; 
	
	//장바구니 넣기 addBasket.do
	@ResponseBody
	@RequestMapping(value="addBasket.do", method= {RequestMethod.GET, RequestMethod.POST}) 
	public String addBasket(int projectSeq, int[] selectOpSeq, int[] optionCount, HttpServletRequest req) {
		logger.info(" BuyController addBasket" + new Date());	
		String id = ((MemberDto)req.getSession().getAttribute("login")).getId();

		//장바구니 insert
		basketService.insertBasket(id, projectSeq, selectOpSeq, optionCount);
		return "YES";
	}
	
	//장바구니 넣기 addBasket.do
	@ResponseBody
	@RequestMapping(value="getBasketCount.do", method= {RequestMethod.GET, RequestMethod.POST}) 
	public String getBasketCount(String id) {		
		return basketService.getBasketCount(id)+"";
	}
	
	// 장바구니 창으로
	@RequestMapping(value="myBasket.do", method= {RequestMethod.GET, RequestMethod.POST})
	public String myBasket(HttpServletRequest req, Model model) throws Exception {
		logger.info("myBasket " + new Date());
		MemberDto user = (MemberDto) req.getSession().getAttribute("login");
		// 내 장바구니 목록(view) 찾아오기(SEQ, ID, PROJECTSEQ, OPTIONSEQ, COUNT, REGDATE, PTITLE, OTITLE, OCONTENT, STATUS, PRICE)
		List<BasketDto> myBasketList = basketService.selectMyBasket(user.getId());
		logger.info("찾아온 장바구니 목록 개수 = " + myBasketList.size());
		
		for (int i = 0; i < myBasketList.size(); i++) {
			logger.info("찾아온 장바구니 = " + myBasketList.get(i).toString());
			OptionDto option = projectService.getOptionDetail(myBasketList.get(i).getOptionseq());
			int leftCount = option.getStock() - option.getBuycount();
			if(!myBasketList.get(i).getStatus().toLowerCase().equals("ongoing")) {
	            // 진행중인 프로젝트가 아니면 장바구니에서 삭제
	            basketService.deleteBasket(myBasketList.get(i).getSeq());
	            myBasketList.remove(i); // 리스트에서 삭제하고
	            i--; // 이 자리 비니까 다시 체크
	        }else if(option.getStock() <= 0 ) { // 제한 수량 무제한인 경우
				continue;
			}else if(leftCount <= 0) { // 남은 재고가 없으면 장바구니에서 삭제
				basketService.deleteBasket(myBasketList.get(i).getSeq());
				myBasketList.remove(i); // 리스트에서 삭제하고
				i--; // 이 자리 비니까 다시 체크
			}else if(leftCount < myBasketList.get(i).getCount() ) { // if(남은수량<장바구니수량)
				myBasketList.get(i).setCount(leftCount);
			}
		}
		
		model.addAttribute("myBasket", myBasketList);
		
		return "basket.tiles";
	}
	
	// 장바구니 삭제
	@RequestMapping(value="deleteBasket.do", method= {RequestMethod.GET, RequestMethod.POST})
	public String deleteBasket(HttpServletRequest req,int seq) throws Exception{
		logger.info("BuyController deleteBasket 들어옴 " + new Date());
		logger.info("삭제할 장바구니의 seq값 = " + seq);
		
		// 장바구니 DB에서 해당 리워드 삭제
		int success = basketService.deleteBasket(seq);
		if(success > 0) {
			logger.info("장바구니 삭제에 성공했습니다");
		}else {
			logger.info("장바구니 삭제에 실패했습니다");
		}
		return "redirect:/myBasket.do";
	}
	
	// 장바구니 업데이트(장바구니 페이지에서 수량 + - 할때마다 ajax로 수시로 반영.)
	@RequestMapping(value="updateBasket.do", method= {RequestMethod.GET, RequestMethod.POST})
	public String updateBasket(HttpServletRequest req, BasketDto basketDto) throws Exception{
		logger.info("BuyController updateBasket 들어옴 " + new Date());
		//seq랑 count만 알면됨
		logger.info("업뎃에 들어온  seq = " + basketDto.getSeq());
		logger.info("업뎃에 들어온  count = " + basketDto.getCount());
		
		// DB 장바구니 업데이트
		basketService.updateBasket(basketDto);
		
		return "redirect:/myBasket.do";
	}
	
	
}
