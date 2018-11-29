package donzo.thefun.dao;

import java.util.List;

import donzo.thefun.model.BuyDto;
import donzo.thefun.model.ProjectDto;

public interface BuyDao {

	
	public List<BuyDto> orderList(BuyDto buy);
	
	//주문 최종입력
	public void addOrders(BuyDto buy);
	
	//특정 게시글 당 후원자 인원 count
	public int sponsorCount(int projectSeq);

	
}
