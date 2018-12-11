package donzo.thefun.service;

import java.util.List;

import donzo.thefun.model.BasketDto;
import donzo.thefun.model.BuyDto;

public interface BasketService {

	// 장바구니 가져오기
	public List<BasketDto> selectMyBasket(String id);
		
	// 장바구니 목록 삭제하기
	public int deleteBasket(int seq);
	
	// 장바구니 목록 업데이트
	public void updateBasket(List<BasketDto> basketDto);
	
	//장바구니 insert 
	public void insertBasket(String id, int projectSeq, int[] optionSeq, int[] optionCount);
	
	//장바구니 물건 갯수
	public int getBasketCount(String id);
}
