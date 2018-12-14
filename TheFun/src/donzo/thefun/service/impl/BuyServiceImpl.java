package donzo.thefun.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import donzo.thefun.dao.BuyDao;
import donzo.thefun.model.BuyDto;
import donzo.thefun.model.BuyGroupParam;
import donzo.thefun.model.ProjectDto;
import donzo.thefun.model.buyParam;
import donzo.thefun.model.participantParam;
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
	   public void addOrders(BuyDto buy ,int[] projectseq,int[] opSeq, int[] opPrice ,int[] opCount,String fundtype) {            
	      
	      if(buy.getBankName()==null || buy.getBankName()=="") {
	         buy.setBankName("간편결제");
	      }
	      
	      if(fundtype.equalsIgnoreCase(ProjectDto.TYPE_DONATION)) {
	         //System.out.println("buy 서비스 임플리 here============= ");
	    	     	  
	         BuyDto buydto=new BuyDto(
	                  buy.getId(), projectseq[0], opSeq[0], 1,opPrice[0], 
	                  buy.getName(), buy.getPhone(), buy.getPostcode(), buy.getRoadaddress(), buy.getDetailaddress(),
	                  buy.getCardNumber(), buy.getBankName(),0);
	         //System.out.println("addorders의 dto : "+buydto);
	         buyDao.addOrders(buydto);
	         
	      }else if(fundtype.equalsIgnoreCase(ProjectDto.TYPE_REWARD)) {
	         for(int i=0; i<opSeq.length; i++) {      
	            BuyDto buydto = new BuyDto(
	                  buy.getId(),projectseq[i], opSeq[i], opCount[i], opPrice[i], 
	                  buy.getName(), buy.getPhone(), buy.getPostcode(), buy.getRoadaddress(), buy.getDetailaddress(),
	                  buy.getCardNumber(), buy.getBankName(),buy.getUsePoint());
	            System.out.println("addorders의 dto : "+buydto);
	            buyDao.addOrders(buydto);         
	         }
	      }else {
	         System.out.println("너는 무슨 타입이냐:" + fundtype);
	      }
	      
	   }

	@Override
	public boolean addReview(BuyDto buydto) {
		return buyDao.addReview(buydto);
	}

	@Override
	public List<BuyDto> selectReviewList(int seq) {
		return buyDao.selectReviewList(seq);
	}
	

/////////페이징
	@Override
	public List<BuyDto> myOrderPageList(buyParam param) {
		return buyDao.myOrderPageList(param);
	}

	@Override
	public int getOrderCount(buyParam param) {
		return buyDao.getOrderCount(param);
	}
/////////	

	@Override
	public List<BuyDto> myOrderDetail(BuyDto buy) {
		return buyDao.myOrderDetail(buy);
	}

	// 참여 현황
	@Override
	public List<BuyDto> getParticipantList(participantParam partiParam) {
		return buyDao.getParticipantList(partiParam);
	}

	@Override
	public int getParticipantCount(participantParam partiParam) {
		return buyDao.getParticipantCount(partiParam);
	}

	@Override
	public BuyGroupParam getBuyGroupInfo(BuyDto buyDto) {
		return buyDao.getBuyGroupInfo(buyDto);
	}

	@Override
	public void deleteOrder(int seq) {
		buyDao.deleteOrder(seq);
	}
	
	
}

