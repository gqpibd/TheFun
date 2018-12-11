package donzo.thefun.dao.impl;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import donzo.thefun.dao.NoticeDao;
import donzo.thefun.model.NoticeDto;

@Repository
public class NoticeDaoImpl implements NoticeDao {

	@Autowired
	SqlSessionTemplate sqlSession;
	
	String ns = "Notice.";

	@Override
	public List<NoticeDto> getNotice(int seq) {
		return sqlSession.selectList(ns+"noticeInfo",seq);
	}

	@Override
	public int addNotice(NoticeDto dto) {		
		return sqlSession.insert(ns+"addNotice",dto);
	}	
	
	@Override
	public NoticeDto selectNotice(NoticeDto dto) {		
		return sqlSession.selectOne(ns+"selectNotice",dto);
	}	
}
