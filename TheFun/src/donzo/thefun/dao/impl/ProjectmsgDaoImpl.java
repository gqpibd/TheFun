package donzo.thefun.dao.impl;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import donzo.thefun.dao.ProjectmsgDao;
import donzo.thefun.model.ProjectDto;
import donzo.thefun.model.ProjectmsgDto;

@Repository
public class ProjectmsgDaoImpl implements ProjectmsgDao {

	@Autowired
	SqlSessionTemplate sqlSession;
	
	String ns = "Projectmsg.";

	@Override
	public boolean insertProjectMsg(ProjectmsgDto projectmsgDto) {
		int n = sqlSession.insert(ns+"insertProjectMsg",projectmsgDto);
		return n>0?true:false;
	}

	@Override
	public List<ProjectmsgDto> getMsgList(int projectseq) {		
		return sqlSession.selectList(ns+"getMsgList",projectseq);
	}

	
}
