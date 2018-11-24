package donzo.thefun.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import donzo.thefun.dao.ProjectDao;
import donzo.thefun.dao.OptionDao;
import donzo.thefun.model.OptionDto;
import donzo.thefun.model.ProjectDto;
import donzo.thefun.service.ProjectService;

@Service
public class ProjectServiceImpl implements ProjectService {

	@Autowired
	ProjectDao projectDao;
	
	@Autowired
	OptionDao optionDao;

	@Override
	public void projectWrite(ProjectDto newProjectDto, List<OptionDto> newPotionlist) throws Exception {
		// [1] 프로젝트 insert
		projectDao.projectWrite(newProjectDto);
		// [2] 생성한 프로젝트 seq값 찾아오기
		int projectSeq = projectDao.findProjectSeq(newProjectDto);
		System.out.println("찾아온 project seq : " + projectSeq);
		// [3] 옵션 insert
		optionDao.optionWrite(newPotionlist, projectSeq);
	}
	
}
