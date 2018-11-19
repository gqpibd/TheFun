package donzo.thefun.dao;

import java.util.List;

import donzo.thefun.model.ProjectDto;

public interface ProjectDao {

	List<ProjectDto> getProjectDetail(int seq);
	
}
