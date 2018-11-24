package donzo.thefun.service;

import java.util.List;

import donzo.thefun.model.MemberDto;
import donzo.thefun.model.NoticeDto;
import donzo.thefun.model.OptionDto;
import donzo.thefun.model.ProjectDto;

public interface ProjectService {
	public ProjectDto getProject(int seq);
	public MemberDto getWriter(int seq);
	public List<OptionDto> getOptions(int seq);
	public List<NoticeDto> getNotice(int seq);
	public List<OptionDto> getSelectOptions(int[] seq);
	public void projectWrite(ProjectDto newProjectDto, List<OptionDto> newPotionlist) throws Exception; 
}
