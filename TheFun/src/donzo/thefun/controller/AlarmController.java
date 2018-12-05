package donzo.thefun.controller;

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

import donzo.thefun.model.AlarmDto;
import donzo.thefun.model.MemberDto;
import donzo.thefun.service.AlarmService;

@Controller
public class AlarmController {
	
	private static final Logger logger = LoggerFactory.getLogger(AlarmController.class);
	
	@Autowired
	AlarmService alarmService; 	
	
	// 알람 목록 보기
	@RequestMapping(value="viewAlarms.do", method={RequestMethod.POST, RequestMethod.GET})
	public String viewAlarms(Model model, HttpServletRequest req) {
		MemberDto loginUser = (MemberDto) req.getSession().getAttribute("login");		
		logger.info("viewAlarms.do");
		List<AlarmDto> alist = alarmService.getAlarmList(loginUser.getId());
		/*for(AlarmDto dto : alist) {
			logger.info(dto.toString());
		}*/
		model.addAttribute("alarmList",alarmService.getAlarmList(loginUser.getId()));		
		return "myAlarms.tiles";
	}
	
	// 알람 읽고 해당 프로젝트로 이동
	@RequestMapping(value="readAlarm.do", method= {RequestMethod.POST, RequestMethod.GET})
	public String readAlarm(int seq, int projectseq) {
		
		alarmService.deleteAlarm(seq);
		
		return "redirect:/projectDetail.do?seq="+projectseq;
	}
	
	/* Ajax */
	
	// 알람 갯수 가져오기
	@ResponseBody
	@RequestMapping(value="getAlarmCount.do", method= {RequestMethod.POST, RequestMethod.GET})
	public String getAlarmCount(String id) {
		return alarmService.getAlarmCount(id)+"";		
	}
		
	// 알람 읽지 않고 알람 삭제
	@ResponseBody
	@RequestMapping(value="deleteAlarm.do", method= {RequestMethod.POST, RequestMethod.GET})
	public String deleteAlarm(int seq) {
		
		if(alarmService.deleteAlarm(seq)>0) {
			return "OK";	
		}else {
			return "NOTOK";
		}
	}
 
} 
