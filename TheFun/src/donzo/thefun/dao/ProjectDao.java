package donzo.thefun.dao;

import java.util.List;

import donzo.thefun.model.MemberDto;
import donzo.thefun.model.ProjectDto;
import donzo.thefun.model.ProjectParam;

public interface ProjectDao {
	
	public int projectWrite(ProjectDto newProjectDto) throws Exception;
	
	/*public int findProjectSeq(ProjectDto newProjectDto) throws Exception;*/
	public ProjectDto getProject(int seq);
	public MemberDto getWriter(int seq);
	List<ProjectDto> searchProjectList(ProjectParam pParam) throws Exception;
	
	int getProjectCount(ProjectParam pParam) throws Exception;
	
}
