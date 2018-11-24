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
		// 생성할 새 프로젝트 값
		System.out.println("projectWrite 다오 : "+ newProjectDto.toString());
		// 프로젝트 생성!
		sqlSession.insert(ns+"newWrite", newProjectDto);
	}

	@Override
	public int findProjectSeq(ProjectDto newProjectDto) throws Exception {
		// 생성한 프로젝트 seq값 찾아와! (==> for. 이미지 파일명 설정 / 옵션 생성할때 projectSeq)
		int projectSeq = sqlSession.selectOne(ns+"findProjectSeq", newProjectDto);
		return projectSeq;
	}
	
	
}
