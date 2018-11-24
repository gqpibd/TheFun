package donzo.thefun.dao.impl;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import donzo.thefun.dao.OptionDao;
import donzo.thefun.model.OptionDto;

@Repository
public class OptionDaoImpl implements OptionDao {

	@Autowired
	SqlSessionTemplate sqlSession;
	
	String ns = "Option.";
	
	@Override
	public List<OptionDto> getOptions(int seq) {
		return sqlSession.selectList(ns+"getOptions",seq);
	}
	
	@Override
	public OptionDto getSelectOptions(int seq) {
		return sqlSession.selectOne(ns+"selectOptions",seq);
	}
}
