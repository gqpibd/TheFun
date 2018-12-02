package donzo.thefun.dao.impl;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import donzo.thefun.dao.ProjectmsgDao;
import donzo.thefun.model.ProjectmsgDto;

@Repository
public class ProjectmsgDaoImpl implements ProjectmsgDao {

	@Autowired
	SqlSessionTemplate sqlSession;
	
	String ns = "Projectmsg.";

	@Override
	public void insertProjectMsg(ProjectmsgDto projectmsgDto) {
		sqlSession.insert(ns+"insertProjectMsg",projectmsgDto);		
	}
}
