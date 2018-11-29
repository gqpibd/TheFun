package donzo.thefun.controller;

import java.util.Date;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import donzo.thefun.model.QnaDto;
import donzo.thefun.service.QnaService;

@Controller
public class QnaController {
	
	private static final Logger logger = LoggerFactory.getLogger(QnaController.class);
	 
	@Autowired 
	QnaService qnaService; 	 
	
	// 댓글 등록 ------
	@RequestMapping(value="addQna.do", method= {RequestMethod.GET, RequestMethod.POST})
	public String addQna(Model model, QnaDto newQna, boolean secret) {
		logger.info("QnaController addQna " + new Date());		
		logger.info(newQna.toString());
		logger.info(secret + "");
		if(secret) {
			newQna.setStatus(QnaDto.HIDE);
		}
		qnaService.addQna(newQna);		
		return "redirect:/projectDetail.do?seq=" + newQna.getProjectseq();
	}	
	
	// 댓글 삭제
	@RequestMapping(value="delQna.do", method= {RequestMethod.GET, RequestMethod.POST})
	public String delQna(Model model, int seq, int projectseq) {
		logger.info("QnaController delQna " + new Date());
		qnaService.delQna(seq);		
		return "redirect:/projectDetail.do?seq=" + projectseq;
	}
	
	// 댓글 수정
	@RequestMapping(value="updateQna.do", method= {RequestMethod.GET, RequestMethod.POST})
	public String updateQna(Model model,  QnaDto dto, boolean secret) {
		logger.info("QnaController updateQna " + new Date());
		if(secret) {
			dto.setStatus(QnaDto.HIDE);
		}else {
			dto.setStatus(QnaDto.NORMAL);
		}
		logger.info(dto.toString());		
		qnaService.updateQna(dto);	
		return "redirect:/projectDetail.do?seq=" + dto.getProjectseq();
	}
}













