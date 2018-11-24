package donzo.thefun.dao.impl;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import donzo.thefun.dao.ProjectDao;
import donzo.thefun.model.ProjectDto;

@Repository
public class ProjectDaoImpl implements ProjectDao {

	@Autowired
	SqlSessionTemplate sqlSession;
	
	String ns = "Project.";

	@Override
	public void projectWrite(ProjectDto newProjectDto) throws Exception {
		System.out.println("다오 : "+ newProjectDto.toString());
		sqlSession.insert(ns+"newWrite", newProjectDto);
	}
	
	
}
