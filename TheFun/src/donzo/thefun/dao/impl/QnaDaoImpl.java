package donzo.thefun.dao.impl;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import donzo.thefun.dao.QnaDao;
import donzo.thefun.model.QnaDto;

@Repository
public class QnaDaoImpl implements QnaDao {

	@Autowired
	SqlSessionTemplate sqlSession;
	
	String ns = "Qna.";

	@Override
	public List<QnaDto> getQnaList(int seq) {
		List<QnaDto> list = sqlSession.selectList(ns, "getQnaList");
		return list;
	}

	
	
	
	
	
	
}
