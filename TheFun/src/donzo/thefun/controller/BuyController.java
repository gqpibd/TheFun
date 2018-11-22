package donzo.thefun.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import donzo.thefun.service.BuyService;


@Controller
public class BuyController {
	
	private static final Logger logger = LoggerFactory.getLogger(BuyController.class);
	
	@Autowired
	BuyService buyService;
	

}
