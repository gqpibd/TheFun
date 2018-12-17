package donzo.thefun.dao;

import java.util.List;


import donzo.thefun.model.BuyDto;
import donzo.thefun.model.BuyGroupParam;
import donzo.thefun.model.pageparam.buyParam;
import donzo.thefun.model.pageparam.participantParam;

public interface BuyDao {

	
	public List<BuyDto> orderList(String id);
	
	//주문 최종입력
	public void addOrders(BuyDto buy);
	
	public boolean addReview(BuyDto buydto);

	public List<BuyDto> selectReviewList(int seq);
	
		
///////페이징		
	public List<BuyDto> orderPageList(buyParam param);
	
	public int getOrderCount(buyParam param);
/////////////	
	
	//내가 주문한 건의 디테일
	public List<BuyDto> orderDetailList(BuyDto buy);
	
	// 참여 현황
	public List<BuyDto> getParticipantList(participantParam partiParam);
	
	// 참여 카운트(for 페이징)
	public int getParticipantCount(participantParam partiParam);

	public BuyGroupParam getBuyGroupInfo(BuyDto buyDto);
	
	//주문삭제
	public void deleteOrder(int seq);

	public boolean finishFunding(int i);

	public boolean givePoint(BuyDto buydto);

	public BuyDto getBuyDetail(int i);

	public void addDonation(BuyDto donation);

	public List<BuyDto> getParticipantList(int seq);

	
}
