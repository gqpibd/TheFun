package donzo.thefun.dao.impl;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import donzo.thefun.dao.BuyDao;
import donzo.thefun.model.BuyDto;
import donzo.thefun.model.ProjectDto;

@Repository
public class BuyDaoImpl implements BuyDao {

	@Autowired
	SqlSessionTemplate sqlSession;
	
	String ns = "Buy.";
	
	String ns2 = "Basket.";

	@Override
	public List<BuyDto> orderList(String id) {
		//buy.setRegdate(buy.getRegdate().substring(0, 9));
		List<BuyDto> list = sqlSession.selectList(ns + "myOrderList", id);
		return list;
	}

	@Override
	public void addOrders(BuyDto buy) {
		sqlSession.insert(ns+"addOrders", buy);
	}

	@Override
	public boolean addReview(BuyDto buydto) {
		int n= sqlSession.update(ns+"addReview",buydto);
		return n>0?true:false;
	}

	@Override
	public List<BuyDto> selectReviewList(int seq) {
		return sqlSession.selectList(ns+"selectReviewList",seq);
	}

	@Override
	public List<BuyDto> selectMyBasket(String id) {
		return sqlSession.selectList(ns2+"myBasketList", id);
	}	
	
}
