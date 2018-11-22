package donzo.thefun.dao.impl;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import donzo.thefun.dao.ProjectDao;
import donzo.thefun.model.MemberDto;
import donzo.thefun.model.NoticeDto;
import donzo.thefun.model.OptionDto;
import donzo.thefun.model.ProjectDto;

@Repository
public class ProjectDaoImpl implements ProjectDao {

	@Autowired
	SqlSessionTemplate sqlSession;
	
	String ns = "Project.";

	@Override
	public ProjectDto getProject(int seq) {
		return sqlSession.selectOne(ns+"getProject",seq);
	}

	@Override
	public MemberDto getWriter(int seq) {
		return sqlSession.selectOne(ns+"getWriter",seq);
	}

	@Override
	public List<OptionDto> getOptions(int seq) {
		return sqlSession.selectList(ns+"getOptions",seq);
	}

	@Override
	public int howmanyBuy(int seq) {
		return sqlSession.selectOne(ns+"howmanyBuy",seq);
	}

	@Override
	public List<NoticeDto> getNotice(int seq) {
		return sqlSession.selectList(ns+"noticeInfo",seq);
	}
	
	
}
