package donzo.thefun.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import donzo.thefun.dao.AlarmDao;
import donzo.thefun.dao.BuyDao;
import donzo.thefun.dao.MemberDao;
import donzo.thefun.model.AlarmDto;
import donzo.thefun.model.BuyDto;
import donzo.thefun.model.BuyGroupParam;
import donzo.thefun.model.MemberDto;
import donzo.thefun.model.pageparam.buyParam;
import donzo.thefun.model.pageparam.participantParam;
import donzo.thefun.service.BuyService;

@Service
public class BuyServiceImpl implements BuyService {

	@Autowired
	BuyDao buyDao;

	@Autowired
	AlarmDao alarmDao;
	

	@Override
	public List<BuyDto> orderList(String id) {
		return buyDao.orderList(id);
	}

	// 리워드 주문
	@Override
	public void addOrders(BuyDto buy, int[] projectseq, int[] opSeq, int[] opPrice, int[] opCount, String fundtype) {
		if (buy.getBankName() == null || buy.getBankName() == "") {
			buy.setBankName("간편결제");
		}
		for (int i = 0; i < opSeq.length; i++) {
			BuyDto buydto = new BuyDto(buy.getId(), projectseq[i], opSeq[i], opCount[i], opPrice[i], buy.getName(),
					buy.getPhone(), buy.getPostcode(), buy.getRoadaddress(), buy.getDetailaddress(),
					buy.getCardNumber(), buy.getBankName(), buy.getUsepoint());
			System.out.println("addorders의 dto : " + buydto);
			buyDao.addOrders(buydto);
		}
	}

	@Override
	public boolean addReview(BuyDto buydto) {
		boolean success = buyDao.addReview(buydto);
		if(success) {
			buyDao.givePoint(buydto);
			int point = (int) Math.round((buydto.getPrice()*buydto.getCount())*0.01);
			//알람은 포인트 적립됐다고 알려줌
			alarmDao.addFinishAlarm(new AlarmDto(buydto.getProjectseq(), null, buydto.getId(), AlarmDto.ATYPE_POINT, AlarmDto.BTYPE_BUY, point + "점이 지급되었습니다.") );
		}
		return success;
	}

	@Override
	public List<BuyDto> selectReviewList(int seq) {
		return buyDao.selectReviewList(seq);
	}

/////////페이징
	@Override
	public List<BuyDto> myOrderPageList(buyParam param) {
		return buyDao.orderPageList(param);
	}

	@Override
	public int getOrderCount(buyParam param) {
		return buyDao.getOrderCount(param);
	}
/////////	

	@Override
	public List<BuyDto> myOrderDetail(BuyDto buy) {
		return buyDao.orderDetailList(buy);
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

	@Override
	public void finishFunding(int projectseq, int[] buyseq, boolean isReward) {
		for(int i=0;i<buyseq.length;i++) {
			BuyDto buydto = buyDao.getBuyDetail(buyseq[i]);
			buyDao.finishFunding(buyseq[i]);
			if(!isReward) { // 기부인 경우 바로 포인트 지급 -> 리워드는 후기 작성시 지급
				if(buyDao.givePoint(buydto)) {
					int point = (int) Math.round((buydto.getPrice() - buydto.getUsepoint())*0.01);
					alarmDao.addFinishAlarm(new AlarmDto(projectseq, null, buydto.getId(), AlarmDto.ATYPE_POINT, AlarmDto.BTYPE_BUY, point + "점이 지급되었습니다.") );
				}
			}else {
				alarmDao.addFinishAlarm(new AlarmDto(projectseq, null, buydto.getId(), AlarmDto.ATYPE_DELIVERY, AlarmDto.BTYPE_BUY, "구매하신 " + buydto.getOtitle() + "의 배송이 완료되었습니다.") );				
			}
		}
		
	}

	// 기부
	@Override
	public void addDonation(BuyDto donation) {
		buyDao.addDonation(donation);
		
	}

}
