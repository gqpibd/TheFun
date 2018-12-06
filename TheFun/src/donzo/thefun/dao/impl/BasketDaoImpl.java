package donzo.thefun.dao.impl;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import donzo.thefun.dao.BasketDao;
import donzo.thefun.model.BasketDto;

@Repository
public class BasketDaoImpl implements BasketDao {
	@Autowired
	SqlSessionTemplate sqlSession;
	
	String ns = "Basket.";
	
	@Override
	public List<BasketDto> selectMyBasket(String id) {
		return sqlSession.selectList(ns+"myBasketList", id);
	}

	@Override
	public int deleteBasket(int seq) {
		return sqlSession.delete(ns+"deleteBasket", seq);
	}
	
	
}
