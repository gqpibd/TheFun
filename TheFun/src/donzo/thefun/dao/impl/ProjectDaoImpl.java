package donzo.thefun.dao.impl;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import donzo.thefun.dao.ProjectDao;
import donzo.thefun.model.MemberDto;
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
		return sqlSession.selectOne(ns + "getProjectCount", pParam);
	}

	@Override
	public ProjectDto getProject(int seq) {
		return sqlSession.selectOne(ns+"getProject",seq);
	}

	@Override
	public MemberDto getWriter(int seq) {
		return sqlSession.selectOne(ns+"getWriter",seq);
	}

	@Override
	public int projectWrite(ProjectDto newProjectDto) throws Exception {
		// 생성할 새 프로젝트 값
		System.out.println("projectWrite 다오 : "+ newProjectDto.toString());
		// 프로젝트 생성!
		return sqlSession.insert(ns+"newWrite", newProjectDto);
	}

	/*@Override
	public int findProjectSeq(ProjectDto newProjectDto) throws Exception {
		// 생성한 프로젝트 seq값 찾아와! (==> for. 이미지 파일명 설정 / 옵션 생성할때 projectSeq)
		int projectSeq = sqlSession.selectOne(ns+"findProjectSeq", newProjectDto);
		return projectSeq;
	}*/
}
