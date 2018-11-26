package donzo.thefun.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import donzo.thefun.dao.BuyDao;
import donzo.thefun.dao.OptionDao;
import donzo.thefun.model.BuyDto;
import donzo.thefun.model.OptionDto;
import donzo.thefun.model.ProjectDto;
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
	public boolean addOrders(String loginId,int projectSeq, int[] opSeq, int[] opCount) {
		
		List<BuyDto> buyList = new ArrayList<>();
		
		//가격추출
		int[] prices = new int[opSeq.length];
		for(int i=0; i<opSeq.length;i++) {
			OptionDto opDto= optiondao.getSelectOptions(opSeq[i]);
			prices[i]=opDto.getPrice();
		}
		
		//list에 추가
		for(int i=0; i<opSeq.length; i++) {
			
			BuyDto buy = new BuyDto(loginId, projectSeq, opSeq[i], opCount[i], prices[i], "ongoing");
			buyList.add(buy);
		}

		return buyDao.addOrders(buyList);
	}

	
	
	
}

