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

	@Override
	public void updateBasket(BasketDto basketDto) {
		sqlSession.update(ns+"updateBasket", basketDto);
	}

	@Override
	public void insertBasket(BasketDto basketDto) {
		sqlSession.insert(ns+"addBasket",basketDto);
	}

	@Override
	public int getBasketCount(String id) {
		return sqlSession.selectOne(ns+"getBasketCount",id);
	}

	@Override
	public int getBasketExist(BasketDto basketDto) {
		return sqlSession.selectOne(ns+"getBasketExist", basketDto);
	}

	@Override
	public void updateCountBasket(BasketDto basketDto) {
		sqlSession.update(ns+"updateCountBasket", basketDto);
	}
	
}
