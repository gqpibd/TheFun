package donzo.thefun.dao;

import donzo.thefun.model.ProjectDto;

public interface ProjectDao {
	
	void projectWrite(ProjectDto newProjectDto) throws Exception;
	
	int findProjectSeq(ProjectDto newProjectDto) throws Exception;

}
