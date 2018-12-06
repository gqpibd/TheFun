package donzo.thefun.dao;

import java.util.List;

import donzo.thefun.model.BuyDto;
import donzo.thefun.model.ProjectDto;

public interface BuyDao {

	
	public List<BuyDto> orderList(String id);
	
	//주문 최종입력
	public void addOrders(BuyDto buy);

	public boolean addReview(BuyDto buydto);

	public List<BuyDto> selectReviewList(int seq);
	
	// 장바구니 불러오기
	public List<BuyDto> selectMyBasket(String id);
	
	// 장바구니 목록 삭제하기
	public int deleteBasket(int seq);
		
}
