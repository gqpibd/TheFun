package donzo.thefun.dao;

import java.util.List;
import donzo.thefun.model.BuyDto;


public interface BuyDao {

	
	public List<BuyDto> orderList(String id);
	
	//주문 최종입력
	public void addOrders(BuyDto buy);
	
	public boolean addReview(BuyDto buydto);

	public List<BuyDto> selectReviewList(int seq);

	public List<BuyDto> selectMyBasket(String id);
		
}
