package donzo.thefun.dao;

import java.util.List;

import donzo.thefun.model.ProjectmsgDto;

public interface ProjectmsgDao {

	public void insertProjectMsg(ProjectmsgDto projectmsgDto);

	public List<ProjectmsgDto> getMsgList(int projectseq);

}
