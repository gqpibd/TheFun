package donzo.thefun.dao.impl;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import donzo.thefun.dao.QnaDao;
import donzo.thefun.model.ProjectDto;
import donzo.thefun.model.QnaDto;
import donzo.thefun.model.pageparam.ProjectParam;

@Repository
public class QnaDaoImpl implements QnaDao {

	@Autowired
	SqlSessionTemplate sqlSession;
	
	String ns = "Qna.";

	@Override
	public List<QnaDto> getQnaList(int seq) {
		return sqlSession.selectList(ns + "getQnaList", seq);
	}

	@Override
	public int addQna(QnaDto newQna) {
		return sqlSession.insert(ns + "addNewQna", newQna);		
	}

	@Override
	public boolean delQna(int seq) {
		int n = sqlSession.update(ns + "delQna", seq);		
		return n>0?true:false;
	}

	@Override
	public boolean updateQna(QnaDto dto) {
		int n = sqlSession.update(ns + "updateQna", dto);		
		return n>0?true:false;
	}

	@Override
	public String getRefWriter(int refseq) {
		return sqlSession.selectOne(ns + "getRefWriter", refseq);
	}

	@Override
	public String getProjectOwner(int projectseq) {		
		return sqlSession.selectOne(ns + "getProjectOwner", projectseq);
	}

}
