package donzo.thefun.dao;

import java.util.List;

import donzo.thefun.model.MemberDto;
import donzo.thefun.model.ProjectDto;
import donzo.thefun.model.ProjectmsgDto;
import donzo.thefun.model.StatCountParam;
import donzo.thefun.model.pageparam.ProjectParam;
import donzo.thefun.model.pageparam.pageParam;

public interface ProjectDao { 
	
	public int projectWrite(ProjectDto newProjectDto) throws Exception;
	public ProjectDto getProject(int seq);
	public MemberDto getWriter(int seq);
	public List<ProjectDto> searchProjectList(ProjectParam pParam) throws Exception;
	
	public int getProjectCount(ProjectParam pParam) throws Exception;

	public List<ProjectDto> getWaitingPagingList(pageParam aParam);
	public int getWaitCount();
	
	//내가 등록한 프로젝트 요약 건 수
	public int getStatusCount(StatCountParam sParam) throws Exception;
	
	public boolean updateProject(ProjectDto myProjectDto) throws Exception;
	public void deleteProject(int seq) throws Exception;
	public boolean changeProjectStatus(ProjectDto projectdto);
	
	////특정 사용자의 프로젝트리스트
	public List<ProjectDto> getMemberProjectList(String id);
		
	//프로젝트 날짜 보여줄 달력
	public List<ProjectDto> getCalendarList(int seq) throws Exception;
	
	public List<ProjectDto> getSellerProjectList(String id);
	
	// 특정 판매자의 성공 or 실패한 프로젝트 리스트
	public List<ProjectDto> getWinOrLoseList(String id) throws Exception;
	
	
}
