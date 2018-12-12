package donzo.thefun.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import donzo.thefun.model.MemberDto;
import donzo.thefun.model.MyChartDto;
import donzo.thefun.model.ProjectDto;
import donzo.thefun.service.MemberService;
import donzo.thefun.service.ProjectService;

@Controller
public class ChartController {
	
	private static final Logger logger = LoggerFactory.getLogger(ChartController.class);
	
	@Autowired
	MemberService memberService;
	
	@Autowired
	ProjectService projectService;
	
	// [1] 원형 통계(fundtype 분포도) 구현용
	@RequestMapping(value="myChart.do", method= {RequestMethod.GET, RequestMethod.POST})
	public String myChart(HttpServletRequest req, Model model) throws Exception{
		logger.info("ChartController myChart 들어옴 " + new Date());
		
		// 유저 정보 가져오기
		MemberDto loginUser = (MemberDto)req.getSession().getAttribute("login");
		logger.info("유저 id = " + loginUser.getId());
		MemberDto user = memberService.getUserInfo(loginUser.getId());
		logger.info("유저 정보 = " + user.toString());
		model.addAttribute("user", user);
		
		// 내 모든 프로젝트 가져오기
		List<ProjectDto> myProject = projectService.getProjectList(loginUser.getId());
		logger.info("내 프로젝트 리스트 길이 = " + myProject.size());
		// 가져온 프로젝트로 기부/리워드 퍼센트 평균내기
		int length = 0;
		double reward = 0;
		double donation = 0;
		if(myProject.size()>0) {
			length = myProject.size();
			for (int i = 0; i < myProject.size(); i++) {
				logger.info((i+1) + "번째 프로젝트 내용 = " + myProject.get(i).toString());
				if(myProject.get(i).getFundtype().equals("reward")) {
					reward +=1;
				}else if(myProject.get(i).getFundtype().equals("donation")) {
					donation +=1;
				}
			}
			logger.info("reward 프로젝트의 갯수 = " + reward);
			logger.info("donation 프로젝트의 갯수 = " + donation);
			
			reward = (reward/length)*100;
			donation = (donation/length)*100;
			
			logger.info("reward 프로젝트의 퍼센트 = " + reward);
			logger.info("donation 프로젝트의 퍼센트 = " + donation);
			
			MyChartDto myproject = new MyChartDto(length+"", Math.round(reward)+"", Math.round(donation)+"");
			
			model.addAttribute("myFundtype", myproject);
		}
		
		return "myChart.tiles";
	}
	
	// [2] 
	@ResponseBody
	@RequestMapping(value="myFundingCategory.do", method= {RequestMethod.GET, RequestMethod.POST})
	public Map<String, Object> myFundingCategory(HttpServletRequest req, Model model) throws Exception{
		logger.info("ChartController myFundingCategory 들어옴 " + new Date());
		
		// 유저 정보 가져오기
		MemberDto loginUser = (MemberDto)req.getSession().getAttribute("login");
		logger.info("유저 id = " + loginUser.getId());
		//MemberDto user = memberService.getUserInfo(loginUser.getId());
		//logger.info("유저 정보 = " + user.toString());
		//model.addAttribute("user", user);
		
		// 내 모든 프로젝트 가져오기
		List<ProjectDto> myProject = projectService.getProjectList(loginUser.getId());
		logger.info("내 프로젝트 리스트 길이 = " + myProject.size());
		// 가져온 프로젝트로 카테고리(리워드의 음식,동물,기술&기부의 사람,동물) 퍼센트내기
		/*
		FUNDTYPE VARCHAR2(50) NOT NULL, -- REWARD | DONATION
		CATEGORY VARCHAR2(50) NOT NULL, -- FOOD, ANIMAL, IT | ANIMAL, HUMAN
		 */
		int length = 0;
		double food = 0;
		double r_animal = 0;
		double it = 0;
		double human = 0;
		double d_animal = 0;
		/*MyChartDto myproject = new MyChartDto();*/
		Map<String, Object> rmap = new HashMap<String, Object>();
		if(myProject.size()>0) {
			length = myProject.size();
			for (int i = 0; i < myProject.size(); i++) {
				logger.info((i+1) + "번째 프로젝트 내용 = " + myProject.get(i).toString());
				if(myProject.get(i).getFundtype().equals("reward") && myProject.get(i).getCategory().equals("Food")) {
					food +=1;
				} else if(myProject.get(i).getFundtype().equals("reward") && myProject.get(i).getCategory().equals("Animal")) {
					r_animal +=1;
				} else if(myProject.get(i).getFundtype().equals("reward") && myProject.get(i).getCategory().equals("IT")) {
					it +=1;
				} else if(myProject.get(i).getFundtype().equals("donation") && myProject.get(i).getCategory().equals("Human")) {
					human +=1;
				} else if(myProject.get(i).getFundtype().equals("donation") && myProject.get(i).getCategory().equals("Animal")) {
					d_animal +=1;
				}
			}
			logger.info("food 프로젝트의 갯수 = " + food);
			logger.info("r_animal 프로젝트의 갯수 = " + r_animal);
			logger.info("it 프로젝트의 갯수 = " + it);
			logger.info("human 프로젝트의 갯수 = " + human);
			logger.info("d_animal 프로젝트의 갯수 = " + d_animal);
			
			food = (food/length)*100;
			r_animal = (r_animal/length)*100;
			it = (it/length)*100;
			human = (human/length)*100;
			d_animal = (d_animal/length)*100;
			
			logger.info("food 프로젝트의 퍼센트 = " + food);
			logger.info("r_animal 프로젝트의 퍼센트 = " + r_animal);
			logger.info("it 프로젝트의 퍼센트 = " + it);
			logger.info("human 프로젝트의 퍼센트 = " + human);
			logger.info("d_animal 프로젝트의 퍼센트 = " + d_animal);
			
			rmap.put("length", length);
			rmap.put("food", food);
			rmap.put("r_animal", r_animal);
			rmap.put("it", it);
			rmap.put("human", human);
			rmap.put("d_animal", d_animal);
			
			/*myproject = new MyChartDto(length+"", Math.round(food)+"", Math.round(r_animal)+"",
													Math.round(it)+"", Math.round(human)+"", Math.round(d_animal)+"");*/
		}
		
		return rmap;
	}

}
