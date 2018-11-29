package donzo.thefun.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import donzo.thefun.dao.BuyDao;
import donzo.thefun.model.BuyDto;
import donzo.thefun.service.BuyService;

@Service
public class BuyServiceImpl implements BuyService {

	@Autowired
	BuyDao buyDao;
	
	@Override
	public List<BuyDto> orderList(BuyDto buy) {
		return buyDao.orderList(buy);
	}

	@Override
	public void addOrders(String loginId,int projectSeq, int[] opSeq, int[] opCount) {				
		
		for(int i=0; i<opSeq.length; i++) {		
			BuyDto buy = new BuyDto(projectSeq, loginId, opSeq[i], opCount[i]);
			buyDao.addOrders(buy);			
		}
		
	}
	
	
	
	
}

