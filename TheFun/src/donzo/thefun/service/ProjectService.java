package donzo.thefun.service;

import java.util.List;

import donzo.thefun.model.ProjectDto;
import donzo.thefun.model.ProjectParam;

public interface ProjectService {

	List<ProjectDto> searchProjectList(ProjectParam pParm) throws Exception;
	
	int getProjectCount(ProjectParam pParam) throws Exception;
	
}
