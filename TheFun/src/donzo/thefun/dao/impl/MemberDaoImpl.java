package donzo.thefun.dao.impl;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import donzo.thefun.dao.MemberDao;
import donzo.thefun.model.MemberDto;

@Repository
public class MemberDaoImpl implements MemberDao {

	@Autowired
	SqlSessionTemplate sqlSession;
	
	String ns = "Member.";

	@Override
	public MemberDto getMypage(MemberDto mem) throws Exception{
		System.out.println("MemberDaoImpl mem.toString()" + mem.toString());
		
		MemberDto dto = sqlSession.selectOne(ns + "getMypage", mem);
		System.out.println("MemberDaoImpl 에서 출력된 dto : " + dto.toString());
		return dto;
	}
	
	
	
}
