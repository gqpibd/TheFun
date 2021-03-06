package donzo.thefun.dao.impl;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import donzo.thefun.dao.OptionDao;
import donzo.thefun.model.OptionDto;

@Repository
public class OptionDaoImpl implements OptionDao {

	@Autowired
	SqlSessionTemplate sqlSession;
	
	String ns = "Option.";

	@Override
	public boolean optionWrite(List<OptionDto> newPotionlist, int projectSeq) throws Exception {
		int n=0;		
		for (int i = 0; i < newPotionlist.size(); i++) {
			// projectseq 컬럼 세팅
			newPotionlist.get(i).setProjectseq(projectSeq);
			// 옵션 값 확인
			System.out.println(newPotionlist.get(i).toString());
			// DB에 insert
			n += sqlSession.insert(ns+"newWrite", newPotionlist.get(i));
		}
		return n>0?true:false;
	}
	
	
	@Override
	public List<OptionDto> getOptions(int seq) {	//프로젝트 seq
		return sqlSession.selectList(ns+"getOptions",seq);
	}
	
	@Override
	public OptionDto getOptionDetail(int seq) {	//옵션 seq
		return sqlSession.selectOne(ns+"selectOptions",seq);
	}
	

	@Override
	public boolean deleteOptions(int seq) throws Exception {	// 프로젝트 seq
		return sqlSession.delete(ns+"deleteOptions", seq)>0?true:false;
		
	}


	@Override
	public boolean updateStock(OptionDto opdto) {
		return sqlSession.update(ns+"updateStock",opdto)>0?true:false;
	}
}
