package donzo.thefun.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import donzo.thefun.model.MemberDto;
import donzo.thefun.model.NoticeDto;
import donzo.thefun.service.NoticeService;
import donzo.thefun.util.UtilFunctions;

@Controller
public class NoticeController {
       
	private static final Logger logger = LoggerFactory.getLogger(NoticeController.class);
	
	@Autowired
	NoticeService noticeService;	
	
	// 공지 등록
	@ResponseBody
	@RequestMapping(value="addNotice.do", method= {RequestMethod.GET, RequestMethod.POST}) 
	public Map<String, String> addNotice(NoticeDto dto) {
		logger.info("addNotice " + new Date());
		logger.info(dto.toString());
		NoticeDto newDto = noticeService.addNotice(dto);
		logger.info("등록결과: " + newDto.toString());
		logger.info("날짜:" + newDto.getRegdate());
		String date = UtilFunctions.getDateFormKorean(newDto.getRegdate());
		logger.info(date);
		Map<String, String> rmap = new HashMap<String, String>();
		rmap.put("number", newDto.getSeq()+"");
		rmap.put("date", date);		
		return rmap;
	}
	
	// 공지 목록
	@ResponseBody
	@RequestMapping(value="selectNotice.do", method= {RequestMethod.GET, RequestMethod.POST}, produces="text/plain;charset=UTF-8") 
	public String selectNotice(int seq) {
		logger.info("selectNotice" + new Date());
		List<NoticeDto> noticeList = noticeService.getNotice(seq);
		String listData = "{\"notices\":[";		
		for(int i=0;i<noticeList.size();i++) {					
			listData += "{\"seq\":\"" + noticeList.get(i).getSeq() +"\",";
			//listData += "\"projectseq\":\"" + noticeList.get(i).getProjectseq() +"\","; 
			listData += "\"title\":\"" + noticeList.get(i).getTitle() +"\",";
			listData += "\"content\":\"" + noticeList.get(i).getContent().replaceAll("\n", "<br>") +"\","; 			
			listData += "\"date\":\"" + UtilFunctions.getDateFormKorean(noticeList.get(i).getRegdate()) +"\"}";
			if(i < noticeList.size()-1) {
				listData += ",";
			}
		}
		listData += "]}";
		logger.info(listData);
		
		return listData; 
	}
}
