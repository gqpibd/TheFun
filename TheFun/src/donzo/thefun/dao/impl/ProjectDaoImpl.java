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
	public List<ProjectDto> searchProjectList(ProjectParam pParam) throws Exception{
		
		System.out.println("searchProjectList로 들어가는 pParam :" + pParam.toString());
		
		return sqlSession.selectList(ns + "searchProjectList", pParam);
	}

	@Override
	public int getProjectCount(ProjectParam pParam) throws Exception {
		System.out.println("getProjectCount로 들어가는 pParam :" + pParam.toString());
		System.out.println("나온 숫자 : " + sqlSession.selectOne(ns + "getProjectCount", pParam));
		return sqlSession.selectOne(ns + "getProjectCount", pParam);
	}
	
}
