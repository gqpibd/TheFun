package donzo.thefun.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sun.media.jfxmedia.logging.Logger;

import donzo.thefun.dao.BasketDao;
import donzo.thefun.model.BasketDto;
import donzo.thefun.service.BasketService;

@Service
public class BasketServiceImpl implements BasketService{
	
	@Autowired
	BasketDao basketDao;
	
	@Override
	public List<BasketDto> selectMyBasket(String id) {
		return basketDao.selectMyBasket(id);
	}

	@Override
	public int deleteBasket(int seq) {
		return basketDao.deleteBasket(seq);
	}

	@Override
	public void updateBasket(BasketDto basketDto) {
		basketDao.updateBasket(basketDto);
	}
	
	@Override
	public void insertBasket(String id, int projectSeq, int[] optionSeq, int[] optionCount) {
		int exist = 1;
		
		for(int i=0 ; i<optionSeq.length ; i++) {
			
			// 이미 장바구니에 있는 물건인지(id, optionseq만 필요)
			System.out.println(i + "번째 옵션시퀀스 = "+optionSeq[i]);
			BasketDto dto = new BasketDto();
			dto.setId(id);
			dto.setOptionseq(optionSeq[i]);
			exist = basketDao.getBasketExist(dto);
			System.out.println("장바구니 있는지 " + exist);
			
			if(exist == 1) {	// 있음(1)
				// 갯수만 update 처리
				System.out.println("장바구니 있음 ");
				BasketDto basket = new BasketDto(id, projectSeq, optionSeq[i], optionCount[i]);
				basketDao.updateCountBasket(basket);
			}else {				// 없음(0)
				// 새로 insert 처리
				System.out.println("장바구니 없음");
				BasketDto basket = new BasketDto(id, projectSeq, optionSeq[i], optionCount[i]);
				basketDao.insertBasket(basket);
			}
			
		}
	}

	@Override
	public int getBasketCount(String id) {
		return basketDao.getBasketCount(id);
	}
	
}
