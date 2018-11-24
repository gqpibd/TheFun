package donzo.thefun.dao;

import java.util.List;

import donzo.thefun.model.MemberDto;
import donzo.thefun.model.NoticeDto;
import donzo.thefun.model.OptionDto;
import donzo.thefun.model.ProjectDto;

public interface ProjectDao {
	public ProjectDto getProject(int seq);
	public MemberDto getWriter(int seq);
}
