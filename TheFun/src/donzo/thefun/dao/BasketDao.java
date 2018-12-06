package donzo.thefun.dao;

import java.util.List;

import donzo.thefun.model.BasketDto;

public interface BasketDao {

	// 장바구니 불러오기
	public List<BasketDto> selectMyBasket(String id);

}
