package donzo.thefun.controller;

import java.util.Date;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import donzo.thefun.service.QnaService;

@Controller
public class QnaController {
	
	private static final Logger logger = LoggerFactory.getLogger(QnaController.class);
	
	@Autowired
	QnaService qnaService; 	
	

	@RequestMapping(value="reply.do", method= {RequestMethod.GET, RequestMethod.POST})
	public String reply(Model model) {
		logger.info("QnaController reply " + new Date());

		
		
		return "reply.tiles";
	}


}
