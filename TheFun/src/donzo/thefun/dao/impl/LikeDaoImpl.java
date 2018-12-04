package donzo.thefun.dao.impl;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import donzo.thefun.dao.LikeDao;
import donzo.thefun.model.LikeDto;

@Repository
public class LikeDaoImpl implements LikeDao {
	
	@Autowired
	SqlSessionTemplate sqlSession;
	
	String ns = "Like.";
			
	@Override
	public boolean changeLike(LikeDto dto) {
		boolean isLike = isLike(dto);
		if(isLike) {
			sqlSession.insert(ns+"disLike", dto);
		}else {
			sqlSession.delete(ns+"like", dto);
		}
		return !isLike;
	}
	
	@Override
	public boolean isLike(LikeDto dto) {
		int n = sqlSession.selectOne(ns+"isLike",dto);
		return n>0?true:false;
	}

	@Override
	public int getLikeCount(int projectseq) {		
		return sqlSession.selectOne(ns+"getLikeCount",projectseq);
	}
}