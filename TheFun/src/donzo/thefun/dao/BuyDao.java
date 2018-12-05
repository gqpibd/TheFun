package donzo.thefun.dao;

import java.util.List;

import donzo.thefun.model.BuyDto;
import donzo.thefun.model.ProjectParam;

public interface BuyDao {

	
	public List<BuyDto> orderList(String id);
	
	//주문 최종입력
	public void addOrders(BuyDto buy);
	
	public boolean addReview(BuyDto buydto);

	public List<BuyDto> selectReviewList(int seq);
	
///////페이징		
//	public List<BuyDto> _myOrderList(ProjectParam param);
//	
//	public int getOrderCount(ProjectParam param);
/////////////	
}
