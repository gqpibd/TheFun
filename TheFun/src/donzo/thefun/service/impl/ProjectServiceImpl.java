package donzo.thefun.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import donzo.thefun.dao.ProjectDao;
import donzo.thefun.model.ProjectDto;
import donzo.thefun.service.ProjectService;

@Service
public class ProjectServiceImpl implements ProjectService {

	@Autowired
	ProjectDao ProjectDao;
	
	@Autowired
	ProjectDao OptionDao;

	@Override
	public void projectWrite(ProjectDto newProjectDto) throws Exception {
		ProjectDao.projectWrite(newProjectDto);
	}
	
}
