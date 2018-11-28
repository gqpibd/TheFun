package donzo.thefun.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import donzo.thefun.dao.BuyDao;
import donzo.thefun.dao.NoticeDao;
import donzo.thefun.dao.OptionDao;
import donzo.thefun.dao.ProjectDao;
import donzo.thefun.dao.QnaDao;
import donzo.thefun.model.MemberDto;
import donzo.thefun.model.NoticeDto;
import donzo.thefun.model.OptionDto;
import donzo.thefun.model.ProjectDto;
import donzo.thefun.model.ProjectParam;
import donzo.thefun.model.QnaDto;
import donzo.thefun.service.ProjectService;

@Service
public class ProjectServiceImpl implements ProjectService {
	
	@Autowired
	ProjectDao projectDao;
	
	@Autowired
	OptionDao optionDao;	
	
	@Autowired
	NoticeDao noticeDao;

	@Autowired
	QnaDao qnaDao;
	
	@Autowired
	BuyDao buydao;
	
	@Override
	public ProjectDto getProject(int seq) {
		return projectDao.getProject(seq);
	}

	@Override
	public MemberDto getWriter(int seq) {
		return projectDao.getWriter(seq);
	}

	@Override
	public List<OptionDto> getOptions(int seq) {
		return optionDao.getOptions(seq);
	}

	@Override
	public List<NoticeDto> getNotice(int seq) {
		return noticeDao.getNotice(seq);
	}

	@Override
	public List<OptionDto> getSelectOptions(int[] seq) {
		
		//return할 리스트
		List<OptionDto> optionList = new ArrayList<>();
		
		//입력된 seq 배열의 길이만큼 loop
		for(int i=0; i<seq.length;i++) {
			optionList.add(optionDao.getSelectOptions(seq[i]));
		}
		
		return optionList;
	}

	@Override
	public int projectWrite(ProjectDto newProjectDto, List<OptionDto> newPotionlist) throws Exception {
		// [1] 프로젝트 insert + 생성한 프로젝트 seq값 찾아오기
		int projectSeq = projectDao.projectWrite(newProjectDto);
		System.out.println("찾아온 project seq : " + projectSeq);
		// [3] 옵션 insert
		optionDao.optionWrite(newPotionlist, projectSeq);
		
		return projectSeq;
	}
	
	@Override
	public List<ProjectDto> searchProjectList(ProjectParam pParam) throws Exception{
		return projectDao.searchProjectList(pParam);
	}

	@Override
	public int getProjectCount(ProjectParam pParam) throws Exception {
		return projectDao.getProjectCount(pParam);
	}

	@Override
	public List<ProjectDto> getWaitingList() {
		return projectDao.getWaitingList();
	}

	@Override
	public List<QnaDto> getQna(int seq) {
		return qnaDao.getQnaList(seq);
	}
	
	//schedule
	@Override
	public List<ProjectDto> mySchedule(ProjectDto pro) throws Exception {
		return projectDao.mySchedule(pro);
	}

	@Override
	public int sponsorCount(int projectSeq) {
		return buydao.sponsorCount(projectSeq);
	}

	
}
