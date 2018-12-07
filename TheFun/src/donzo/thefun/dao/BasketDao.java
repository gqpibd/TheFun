package donzo.thefun.dao;

import java.util.List;

import donzo.thefun.model.BasketDto;
import donzo.thefun.model.BuyDto;

public interface BasketDao {

	// 장바구니 불러오기
	public List<BasketDto> selectMyBasket(String id);
	
	// 장바구니 목록 삭제하기
	public int deleteBasket(int seq);
	
	// 장바구니 업데이트
	public void updateBasket(BasketDto basketDto);
	
	//장바구니 insert 
	public void insertBasket(BasketDto basketDto);

	//장바구니 물건 갯수
	public int getBasketCount(String id);
}
