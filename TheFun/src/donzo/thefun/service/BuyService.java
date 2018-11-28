package donzo.thefun.service;

import java.util.List;

import donzo.thefun.model.BuyDto;
import donzo.thefun.model.ProjectDto;

public interface BuyService {

	public List<BuyDto> orderList(BuyDto buy);
	
	//add order
	public void addOrders(String loginId,int projectSeq, int[] opSeq, int[] opCount);

}
