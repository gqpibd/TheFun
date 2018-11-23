package donzo.thefun.dao;

import java.util.List;

import donzo.thefun.model.ProjectDto;
import donzo.thefun.model.ProjectParam;

public interface ProjectDao {

	List<ProjectDto> searchProjectList(ProjectParam pParam) throws Exception;
	
	int getProjectCount(ProjectParam pParam) throws Exception;
	
}
