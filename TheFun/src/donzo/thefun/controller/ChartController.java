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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import donzo.thefun.model.MemberDto;
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
	
	// myChart.jsp로 이동하는 메소드
	@RequestMapping(value="myChart.do", method= {RequestMethod.GET, RequestMethod.POST})
	public String myChart() throws Exception{
		logger.info("ChartController myChart 들어옴 " + new Date());
		return "myChart.tiles";
	}
	
	// [1] 원형 통계(fundtype 분포도) 구현용
	@ResponseBody
	@RequestMapping(value="myFundingFundtype.do", method= {RequestMethod.GET, RequestMethod.POST})
	public Map<String, Object> myFundingFundtype(HttpServletRequest req) throws Exception{
		logger.info("ChartController myFundingFundtype 들어옴 " + new Date());
		
		// 유저 정보 가져오기
		MemberDto loginUser = (MemberDto)req.getSession().getAttribute("login");
		logger.info("유저 id = " + loginUser.getId());
		
		// 내 모든 프로젝트 가져오기
		List<ProjectDto> myProject = projectService.getMemberProjectList(loginUser.getId());
		logger.info("내 프로젝트 리스트 길이 = " + myProject.size());
		// 가져온 프로젝트로 기부/리워드 퍼센트 평균내기
		int length = 0;
		double reward = 0;
		double donation = 0;
		
		Map<String, Object> rmap = new HashMap<String, Object>();
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
			
			/*MyChartDto myproject = new MyChartDto(length+"", Math.round(reward)+"", Math.round(donation)+"");
			
			model.addAttribute("myFundtype", myproject);*/
			
			rmap.put("nickname", loginUser.getNickname());
			rmap.put("reward", Math.round(reward));
			rmap.put("donation", Math.round(donation));
		}
		
		return rmap;
	}
	
	// [2] 막대그래프(category 분포도) 구현용
	@ResponseBody
	@RequestMapping(value="myFundingCategory.do", method= {RequestMethod.GET, RequestMethod.POST})
	public Map<String, Object> myFundingCategory(HttpServletRequest req) throws Exception{
		logger.info("ChartController myFundingCategory 들어옴 " + new Date());
		
		// 유저 정보 가져오기
		MemberDto loginUser = (MemberDto)req.getSession().getAttribute("login");
		logger.info("유저 id = " + loginUser.getId());
		
		// 내 모든 프로젝트 가져오기
		List<ProjectDto> myProject = projectService.getMemberProjectList(loginUser.getId());
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
			
			rmap.put("nickname", loginUser.getNickname());
			rmap.put("food", Math.round(food));
			rmap.put("r_animal", Math.round(r_animal));
			rmap.put("it", Math.round(it));
			rmap.put("human", Math.round(human));
			rmap.put("d_animal", Math.round(d_animal));
		}
		
		return rmap;
	}
	
	
	// [3] 원형 통계(성패율 비교) 구현용
	@ResponseBody
	@RequestMapping(value="myFundingResult.do", method= {RequestMethod.GET, RequestMethod.POST})
	public Map<String, Object> myFundingResult(HttpServletRequest req) throws Exception{
		logger.info("ChartController myFundingResult 들어옴 " + new Date());
		
		// 유저 정보 가져오기
		MemberDto loginUser = (MemberDto)req.getSession().getAttribute("login");
		logger.info("유저 id = " + loginUser.getId());
		
		// 내 모든 프로젝트 가져오기
		List<ProjectDto> myProject = projectService.getWinOrLoseList(loginUser.getId());
		logger.info("내 프로젝트 리스트 길이 = " + myProject.size());
		// 가져온 프로젝트로 성공/실패 퍼센트내기
		int length = 0;
		double win = 0;
		double lose = 0;
		
		Map<String, Object> rmap = new HashMap<String, Object>();
		if(myProject.size()>0) {
			length = myProject.size();
			for (int i = 0; i < myProject.size(); i++) {
				logger.info((i+1) + "번째 프로젝트 내용 = " + myProject.get(i).toString());
				if(myProject.get(i).getStatus().equals("complete_success")) {
					win +=1;
				}else if(myProject.get(i).getStatus().equals("complete_fail")) {
					lose +=1;
				}
			}
			logger.info("성공한 프로젝트의 갯수 = " + win);
			logger.info("실패한 프로젝트의 갯수 = " + lose);
			
			win = (win/length)*100;
			lose = (lose/length)*100;
			
			logger.info("성공한 프로젝트의 퍼센트 = " + win);
			logger.info("실패한 프로젝트의 퍼센트 = " + lose);
			
			rmap.put("nickname", loginUser.getNickname());
			rmap.put("length", length);
			rmap.put("win", Math.round(win));
			rmap.put("lose", Math.round(lose));
			
			
		}
		
		return rmap;
	}

}
