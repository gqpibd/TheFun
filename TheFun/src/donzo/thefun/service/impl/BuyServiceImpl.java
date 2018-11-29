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
	public void addOrders(BuyDto buy ,int[] opSeq, int[] opCount, int[] opPrice) {				
		
		for(int i=0; i<opSeq.length; i++) {		
			BuyDto buydto = new BuyDto(buy.getId(), buy.getProjectseq(), buy.getOptionseq(), opCount[i], opPrice[i], buy.getName(), buy.getPhone(), buy.getPostcode(), buy.getRoadaddress(), buy.getDetailaddress());
			System.out.println("buyService의 dto : "+buydto);
			buyDao.addOrders(buydto);			
		}
		
	}
	
	
	
	
}

