package donzo.thefun.service;

import java.util.List;

import donzo.thefun.model.BasketDto;

public interface BasketService {

	// 장바구니 가져오기
	public List<BasketDto> selectMyBasket(String id);
}
