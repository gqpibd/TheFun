package donzo.thefun.dao.impl;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import donzo.thefun.dao.ProjectDao;
import donzo.thefun.model.ProjectDto;
import donzo.thefun.model.ProjectParam;

@Repository
public class ProjectDaoImpl implements ProjectDao {

	@Autowired
	SqlSessionTemplate sqlSession;
	
	String ns = "Project.";

	@Override
	public List<ProjectDto> getAllProjectList(ProjectParam pParam) {
		
		System.out.println("getAllProjectList로 들어가는 pParam :" + pParam.toString());
		
		return sqlSession.selectList(ns + "getAllProjectList", pParam);
	}
	
	
	
}
