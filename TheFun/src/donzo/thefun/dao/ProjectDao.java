package donzo.thefun.dao;

import java.util.List;

import donzo.thefun.model.MemberDto;
import donzo.thefun.model.NoticeDto;
import donzo.thefun.model.OptionDto;
import donzo.thefun.model.ProjectDto;

public interface ProjectDao {
	
	public int projectWrite(ProjectDto newProjectDto) throws Exception;
	
	/*public int findProjectSeq(ProjectDto newProjectDto) throws Exception;*/
	public ProjectDto getProject(int seq);
	public MemberDto getWriter(int seq);
}
