package donzo.thefun.service;

import java.util.List;

import donzo.thefun.model.ProjectDto;
import donzo.thefun.model.ProjectParam;

public interface ProjectService {

	List<ProjectDto> getAllProjectList(ProjectParam pParm);
	
}
