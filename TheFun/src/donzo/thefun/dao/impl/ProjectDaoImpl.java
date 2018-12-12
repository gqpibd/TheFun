package donzo.thefun.dao.impl;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import donzo.thefun.dao.ProjectDao;
import donzo.thefun.model.MemberDto;
import donzo.thefun.model.ProjectDto;
import donzo.thefun.model.ProjectParam;
import donzo.thefun.model.StatCountParam;
import donzo.thefun.model.pageParam;

@Repository
public class ProjectDaoImpl implements ProjectDao {

	@Autowired
	SqlSessionTemplate sqlSession;
	
	String ns = "Project.";

	@Override
	public List<ProjectDto> searchProjectList(ProjectParam pParam) throws Exception{
		
//		System.out.println("searchProjectList로 들어가는 pParam :" + pParam.toString());
		List<ProjectDto> list = sqlSession.selectList(ns + "searchProjectList", pParam);
		
		/*for (int i = 0; i < list.size(); i++) {
			ProjectDto dto = list.get(i) ;
			System.out.println("sqlSession.selectList 에서 나온 list : " + dto.toString());
		}*/
		return list;
	}

	@Override
	public int getProjectCount(ProjectParam pParam) throws Exception {
//		System.out.println("getProjectCount로 들어가는 pParam :" + pParam.toString());
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
		sqlSession.insert(ns+"newWrite", newProjectDto);
		return newProjectDto.getSeq();
	}
	
	@Override
	public boolean updateProject(ProjectDto myProjectDto) throws Exception {
		// 내 프로젝트 업데이트하기(승지)
		return sqlSession.update(ns+"updateProject", myProjectDto)>0?true:false;
	}
	
	@Override
	public void deleteProject(int seq) throws Exception {
		// 내 프로젝트 삭제하기(승지)
		sqlSession.update(ns+"deleteProject", seq);		
	}

//	@Override
//	public List<ProjectDto> getWaitingList() {
//		return sqlSession.selectList(ns+"getWaitingList");
//	}

	@Override
	public List<ProjectDto> getWaitingPagingList(pageParam aParam) {
		return sqlSession.selectList(ns+"getWaitingPagingList", aParam);
	}
	
	@Override
	public boolean approveProject(int projectseq) {
		int n = sqlSession.update(ns + "approveProject", projectseq);		
		return n>0?true:false;
	}	
	
	//schedule
	@Override
	public List<ProjectDto> mySchedule(String id) throws Exception {
		return sqlSession.selectList(ns + "mySchedule", id);
	}
	
	//내 프로젝트 요약 건 수
	@Override
	public int getStatusCount(StatCountParam sParam) throws Exception {
		return sqlSession.selectOne(ns + "getStatusCount", sParam);
	}

	@Override
	public int getWaitCount() {		
		return sqlSession.selectOne(ns+"getWaitCount");
	}

	@Override
	public boolean rejectProject(ProjectDto projectdto) {
		int n = sqlSession.update(ns + "rejectProject", projectdto);		
		return n>0?true:false;
	}
	
	////판매자의 프로젝트리스트
	@Override
	public List<ProjectDto> getProjectList(String id) {
		List<ProjectDto> list = sqlSession.selectList(ns + "getProjectList", id);
		return list;
	}
	
}
