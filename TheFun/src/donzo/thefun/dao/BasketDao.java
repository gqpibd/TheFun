package donzo.thefun.dao;

import java.util.List;

import donzo.thefun.model.BasketDto;
import donzo.thefun.model.BuyDto;

public interface BasketDao {

	// 장바구니 불러오기
	public List<BasketDto> selectMyBasket(String id);
	
	// 장바구니 목록 삭제하기
	public int deleteBasket(int seq);

}
