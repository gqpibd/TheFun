package donzo.thefun.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import donzo.thefun.dao.BuyDao;
import donzo.thefun.dao.ProjectDao;
import donzo.thefun.model.BuyDto;
import donzo.thefun.model.ProjectDto;
import donzo.thefun.service.BuyService;

@Service
public class BuyServiceImpl implements BuyService {

	@Autowired
	BuyDao buyDao;
	
	@Override
	public List<BuyDto> orderList(String id) {
		return buyDao.orderList(id);
	}

	@Override
	public void addOrders(BuyDto buy ,int[] opSeq, int[] opCount, int[] opPrice) {				
		
		for(int i=0; i<opSeq.length; i++) {		
			BuyDto buydto = new BuyDto(buy.getId(), buy.getProjectseq(), opSeq[i], opCount[i], opPrice[i], buy.getName(), buy.getPhone(), buy.getPostcode(), buy.getRoadaddress(), buy.getDetailaddress());
			buyDao.addOrders(buydto);			
		}
		
	}
	
	
}

