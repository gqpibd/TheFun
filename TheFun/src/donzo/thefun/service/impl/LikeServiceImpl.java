package donzo.thefun.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import donzo.thefun.dao.LikeDao;
import donzo.thefun.model.LikeDto;
import donzo.thefun.service.LikeService;

@Service
public class LikeServiceImpl implements LikeService {

	@Autowired
	LikeDao likeDao;
	
	@Override
	public boolean isLike(LikeDto dto) {
		return likeDao.isLike(dto);
	}

}
