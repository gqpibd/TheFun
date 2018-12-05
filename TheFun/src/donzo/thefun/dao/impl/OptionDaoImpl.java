package donzo.thefun.dao.impl;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import donzo.thefun.dao.OptionDao;
import donzo.thefun.model.BuyDto;
import donzo.thefun.model.OptionDto;
import donzo.thefun.model.ProjectDto;

@Repository
public class OptionDaoImpl implements OptionDao {

	@Autowired
	SqlSessionTemplate sqlSession;
	
	String ns = "Option.";

	@Override
	public void optionWrite(List<OptionDto> newPotionlist, int projectSeq) throws Exception {
		
		for (int i = 0; i < newPotionlist.size(); i++) {
			// projectseq 컬럼 세팅
			newPotionlist.get(i).setProjectseq(projectSeq);
			// 옵션 값 확인
			System.out.println(newPotionlist.get(i).toString());
			// DB에 insert
			sqlSession.insert(ns+"newWrite", newPotionlist.get(i));
		}
	}
	
	
	@Override
	public List<OptionDto> getOptions(int seq) {	//프로젝트 seq
		return sqlSession.selectList(ns+"getOptions",seq);
	}
	
	@Override
	public OptionDto getSelectOptions(int seq) {	//옵션 seq
		return sqlSession.selectOne(ns+"selectOptions",seq);
	}


	@Override
	public void updateStock(OptionDto opdto) {
		sqlSession.update(ns+"updateStock",opdto);
	}


	@Override
	public void deleteOptions(int seq) throws Exception {
		// TODO Auto-generated method stub
		
	}
	
}
