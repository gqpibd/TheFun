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
	
	@RequestMapping(value="goOrderReward.do", method= {RequestMethod.GET, RequestMethod.POST}) 
	public String goOrderReward() {
		logger.info("BuyController goOrderReward 메소드 " + new Date());
		return "project/selectReward";
	}
	
	@RequestMapping(value="goOrder.do", method= {RequestMethod.GET, RequestMethod.POST}) 
	public String goOrder() {
		logger.info("BuyController goOrderReward 메소드 " + new Date());
		return "project/orderReward";
	}
	
	@RequestMapping(value="myReward.do", method= {RequestMethod.GET, RequestMethod.POST})
	public String donaList(Model model, BuyDto buy) {
		logger.info("BuyController donaList 메소드 " + new Date());
		
		List<BuyDto> donalist = buyService.donaList(buy);
		model.addAttribute("donalist", donalist);

		return "mypage/myReward";
		
		
		
	}
} 
