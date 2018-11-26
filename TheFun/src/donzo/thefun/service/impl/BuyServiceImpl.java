package donzo.thefun.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import donzo.thefun.dao.BuyDao;
import donzo.thefun.dao.OptionDao;
import donzo.thefun.model.BuyDto;
import donzo.thefun.model.OptionDto;
import donzo.thefun.service.BuyService;

@Service
public class BuyServiceImpl implements BuyService {

	@Autowired
	BuyDao buyDao;
	
	@Autowired
	OptionDao optiondao;
	
	@Override
	public List<BuyDto> orderList(BuyDto buy) {
		return buyDao.orderList(buy);
	}

	@Override
	public void addOrders(String loginId,int projectSeq, int[] opSeq, int[] opCount) {
		
		//가격추출
		int[] prices = new int[opSeq.length];
		int[] stocks = new int[opSeq.length];
		for(int i=0; i<opSeq.length;i++) {
			OptionDto opDto= optiondao.getSelectOptions(opSeq[i]);
			prices[i]=opDto.getPrice();
			stocks[i]=opDto.getStock();
		}
		
		for(int i=0; i<opSeq.length; i++) {
			
			//주문 insert
			BuyDto buy = new BuyDto(0, loginId, projectSeq, opSeq[i], opCount[i], prices[i], "", 0, "", "", "", "", "");
			System.out.println(buy.toString());
			buyDao.addOrders(buy);
			
			//재고 update
			OptionDto opdto = new OptionDto(opSeq[i], projectSeq, "", "", prices[i], opCount[i]-stocks[i], 0);
			System.out.println(opdto.toString());
			optiondao.updateStock(opdto);
		}

	}


	
	
	
	
	
}

