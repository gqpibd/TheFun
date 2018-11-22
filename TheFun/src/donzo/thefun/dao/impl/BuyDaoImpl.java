package donzo.thefun.dao.impl;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import donzo.thefun.dao.BuyDao;
import donzo.thefun.model.BuyDto;

@Repository
public class BuyDaoImpl implements BuyDao {

	@Autowired
	SqlSessionTemplate sqlSession;
	
	String ns = "Buy.";

	@Override
	public List<BuyDto> donaList(BuyDto buy) {
		List<BuyDto> list = sqlSession.selectList(ns + "myDonaList", buy);
		return list;
	}
	
	
	
}
