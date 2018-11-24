package donzo.thefun.dao;

import java.util.List;

import donzo.thefun.model.BuyDto;
import donzo.thefun.model.ProjectDto;

public interface BuyDao {

	public List<BuyDto> orderList(BuyDto buy);
	

	
}
