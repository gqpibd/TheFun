package donzo.thefun.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
	public void updateBasket(List<BasketDto> basketDto) {
		for (int i = 0; i < basketDto.size(); i++) {
			basketDao.updateBasket(basketDto.get(i));
		}
	}
	
}