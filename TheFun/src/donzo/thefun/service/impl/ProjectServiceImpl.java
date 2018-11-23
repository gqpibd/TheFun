package donzo.thefun.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import donzo.thefun.dao.ProjectDao;
import donzo.thefun.model.ProjectDto;
import donzo.thefun.model.ProjectParam;
import donzo.thefun.service.ProjectService;

@Service
public class ProjectServiceImpl implements ProjectService {

	@Autowired
	ProjectDao projectDao;
	
	@Autowired
	ProjectDao optionDao;

	@Override
	public List<ProjectDto> searchProjectList(ProjectParam pParam) throws Exception{
		return projectDao.searchProjectList(pParam);
	}

	@Override
	public int getProjectCount(ProjectParam pParam) throws Exception {
		return projectDao.getProjectCount(pParam);
	}
	
	
	
}
