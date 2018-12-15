package donzo.thefun.service;

import java.util.List;

import donzo.thefun.model.BuyDto;
import donzo.thefun.model.BuyGroupParam;
import donzo.thefun.model.pageparam.buyParam;
import donzo.thefun.model.pageparam.participantParam;

public interface BuyService {

	public List<BuyDto> orderList(String id);
	
	//add order
	public void addOrders(BuyDto buy ,int[] projectseq,int[] opSeq, int[] opPrice, int[] opCount, String fundtype);

	//후기 등록
	public boolean addReview(BuyDto buydto);

	public List<BuyDto> selectReviewList(int seq);

//////페이징	
	public List<BuyDto> myOrderPageList(buyParam param);
		
	public int getOrderCount(buyParam param);
///////////	
	
	//내가 주문한 건의 디테일
	public List<BuyDto> myOrderDetail(BuyDto buy);
	
	// 참여 현황
	public List<BuyDto> getParticipantList(participantParam partiParam);
	
	// 참여 카운트
	public int getParticipantCount(participantParam partiParam);
	
	// 묶음 정보
	public BuyGroupParam getBuyGroupInfo(BuyDto buyDto);
	
	//주문삭제
	public void deleteOrder(int seq);
	
	// 배송완료, 기부완료 처리
	public void finishFunding(int projectseq, int[] check_finish, boolean isReward);
}
