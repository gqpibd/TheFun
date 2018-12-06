package donzo.thefun.service;

import java.util.List;

import donzo.thefun.model.BuyDto;
import donzo.thefun.model.ProjectDto;

public interface BuyService {

	public List<BuyDto> orderList(String id);
	
	//add order
	public void addOrders(BuyDto buy ,int[] opSeq, int[] opPrice, int[] opCount, String fundtype);

	//후기 등록
	public boolean addReview(BuyDto buydto);

	public List<BuyDto> selectReviewList(int seq);
	
	// 장바구니 가져오기
	public List<BuyDto> selectMyBasket(String id);
	
	// 장바구니 목록 삭제하기
	public int deleteBasket(int seq);

}
