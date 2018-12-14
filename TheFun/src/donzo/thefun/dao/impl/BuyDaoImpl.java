package donzo.thefun.dao.impl;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import donzo.thefun.dao.BuyDao;
import donzo.thefun.model.BuyDto;
import donzo.thefun.model.BuyGroupParam;
import donzo.thefun.model.pageparam.buyParam;
import donzo.thefun.model.pageparam.participantParam;

@Repository
public class BuyDaoImpl implements BuyDao {

	@Autowired
	SqlSessionTemplate sqlSession;
	
	String ns = "Buy.";

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

////////페이징
	@Override
	public List<BuyDto> myOrderPageList(buyParam param) {
		List<BuyDto> blist = sqlSession.selectList(ns + "myOrderPageList", param);
		return blist;
	}

	@Override
	public int getOrderCount(buyParam param) {
		return sqlSession.selectOne(ns + "getOrderCount", param);
	}	
///////////////	

	@Override
	public List<BuyDto> myOrderDetail(BuyDto buy) {
		return sqlSession.selectList(ns+"myOrderDetail",buy);
	}

	// 참여 현황
	@Override
	public List<BuyDto> getParticipantList(participantParam partiParam) {
		System.out.println("getParticipantList로 들어가는 participantParam : " + partiParam.toString());
		return sqlSession.selectList(ns + "participant_List", partiParam);
	}

	@Override
	public int getParticipantCount(participantParam partiParam) {
		return sqlSession.selectOne(ns + "getParticipantCount", partiParam);
	}

	@Override
	public BuyGroupParam getBuyGroupInfo(BuyDto buyDto) {
		return sqlSession.selectOne(ns + "getBuyGroupInfo", buyDto);
	}

	@Override
	public void deleteOrder(int seq) {
		sqlSession.delete(ns+"deleteBuy", seq);
	}
	
}
