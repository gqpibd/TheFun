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
	
	//장바구니에 이미 있는 물건인지
	public int getBasketExist(int optionseq);
	
	//이미 있는거면 갯수 update
	public void updateCountBasket(BasketDto basketDto);
}
