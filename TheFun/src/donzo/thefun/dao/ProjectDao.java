package donzo.thefun.dao;

import java.util.List;

import donzo.thefun.model.ProjectDto;
import donzo.thefun.model.ProjectParam;

public interface ProjectDao {

	List<ProjectDto> getProjectList(ProjectParam pParam);
	
}
