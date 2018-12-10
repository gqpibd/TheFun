package donzo.thefun.dao;

import java.util.List;

import donzo.thefun.model.MemberDto;
import donzo.thefun.model.ProjectDto;
import donzo.thefun.model.ProjectParam;
import donzo.thefun.model.ProjectmsgDto;

public interface ProjectDao { 
	
	public int projectWrite(ProjectDto newProjectDto) throws Exception;
	public ProjectDto getProject(int seq);
	public MemberDto getWriter(int seq);
	public List<ProjectDto> searchProjectList(ProjectParam pParam) throws Exception;
	
	public int getProjectCount(ProjectParam pParam) throws Exception;

	public List<ProjectDto> getWaitingList();
	public boolean approveProject(int projectseq);
	
	public List<ProjectDto> mySchedule(String id) throws Exception;
	
	public boolean updateProject(ProjectDto myProjectDto) throws Exception;
	public void deleteProject(int seq) throws Exception;
	public int getWaitCount();
	public boolean rejectProject(ProjectDto projectdto);
	
	// 내 모든 프로젝트 가져오기(승지 : 차트구현)
	public List<ProjectDto> myAllProject(String id);
	
}
