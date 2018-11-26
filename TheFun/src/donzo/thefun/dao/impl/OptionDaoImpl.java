package donzo.thefun.dao.impl;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import donzo.thefun.dao.OptionDao;
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
	
	
}
