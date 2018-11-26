package donzo.thefun.controller;

import java.util.Date;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import donzo.thefun.service.AlarmService;

@Controller
public class AlarmController {
	
	private static final Logger logger = LoggerFactory.getLogger(AlarmController.class);
	
	@Autowired
	AlarmService alarmService; 	

}
