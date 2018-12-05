package donzo.thefun.service;

import java.util.List;

import donzo.thefun.model.BuyDto;

public interface BuyService {

	public List<BuyDto> orderList(String id);
	
	//add order
	public void addOrders(BuyDto buy ,int[] opSeq, int[] opPrice, int[] opCount, String fundtype);

	//후기 등록
	public boolean addReview(BuyDto buydto);

	public List<BuyDto> selectReviewList(int seq);

}
