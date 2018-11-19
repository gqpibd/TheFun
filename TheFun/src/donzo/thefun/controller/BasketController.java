package donzo.thefun.controller;

import java.util.Date;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class BasketController {
	
	private static final Logger logger = LoggerFactory.getLogger(BasketController.class);
	
	@Autowired
	// BasketService basketService; 주석 풀어서 쓰길...
	
	
	@RequestMapping(value="어쩌구.do", method= {RequestMethod.GET, RequestMethod.POST}) 
	public String hahaha() {
		logger.info("BasketController 어쩌구 메소드 " + new Date());
		
		return "뭔.tiles";
	}

}
