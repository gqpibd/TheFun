package donzo.thefun.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import donzo.thefun.dao.ProjectDao;
import donzo.thefun.model.MemberDto;
import donzo.thefun.model.NoticeDto;
import donzo.thefun.model.OptionDto;
import donzo.thefun.model.ProjectDto;
import donzo.thefun.service.ProjectService;

@Service
public class ProjectServiceImpl implements ProjectService {

	@Autowired
	ProjectDao projectDao;
	
	@Autowired
	ProjectDao optionDao;

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
		return projectDao.getOptions(seq);
	}

	@Override
	public int howmanyBuy(int seq) {
		return projectDao.howmanyBuy(seq);
	}

	@Override
	public List<NoticeDto> getNotice(int seq) {
		return projectDao.getNotice(seq);
	}

	@Override
	public List<OptionDto> getSelectOptions(int[] seq) {
		
		//return할 리스트
		List<OptionDto> optionList = new ArrayList<>();
		
		//입력된 seq 배열의 길이만큼 loop
		for(int i=0; i<seq.length;i++) {
			optionList.add(projectDao.getSelectOptions(seq[i]));
		}
		
		return optionList;
	}
	
	
}
