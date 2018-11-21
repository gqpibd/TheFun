package donzo.thefun.service;

import java.util.List;

import donzo.thefun.model.MemberDto;
import donzo.thefun.model.OptionDto;
import donzo.thefun.model.ProjectDto;

public interface ProjectService {
	public ProjectDto getProject(int seq);
	public MemberDto getWriter(int seq);
	public List<OptionDto> getOptions(int seq);
	public int howmanyBuy(int seq);
}
