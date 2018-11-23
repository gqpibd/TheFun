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
	public boolean idExists(String id) {
		int n = sqlSession.selectOne(ns+"idCheck",id);
		return (n>0)?true:false;
	}

	@Override
	public boolean emailExists(String email) {
		int n = sqlSession.selectOne(ns+"emailCheck",email);
		return  (n>0)?true:false;
	}

	@Override
	public boolean addAccount(MemberDto dto) {
		int n = sqlSession.insert(ns+"addAccount",dto);
		return  (n>0)?true:false;
	}

	@Override
	public MemberDto tryLogin(MemberDto dto) {
		return sqlSession.selectOne(ns+"tryLogin",dto);
	}

	@Override
	public MemberDto getMypage(MemberDto mem) throws Exception{
		System.out.println("MemberDaoImpl mem.toString()" + mem.toString());
		
		MemberDto dto = sqlSession.selectOne(ns + "getMypage", mem);
		System.out.println("MemberDaoImpl 에서 출력된 dto : " + dto.toString());
		return dto;
	}

	@Override
	public boolean updateMember(MemberDto mem) {
		int n = sqlSession.update(ns+"updateMember",mem);
		return  (n>0)?true:false;
	}
}
