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
	public MemberDto getUserInfo(String id) throws Exception{
		return sqlSession.selectOne(ns + "getUserInfo", id);		
	}

	@Override
	public boolean updateMember(MemberDto mem) {
		int n = sqlSession.update(ns+"updateMember",mem);
		return  (n>0)?true:false;
	}
	
	//id찾기
	@Override
	public String find_id(String email) throws Exception {
		
		return sqlSession.selectOne(ns+"find_id", email);
	}

	
	

	@Override
	public boolean addPoint(MemberDto mem) {
		System.out.println("MemberDaoImpl" + mem.toString());
		int n = sqlSession.update(ns+"addPoint",mem);
		System.out.println(n);
		return  (n>0)?true:false;
	}
	
}
