package donzo.thefun.dao.impl;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import donzo.thefun.dao.MemberDao;

@Repository
public class MemberDaoImpl implements MemberDao {

	@Autowired
	SqlSessionTemplate sqlSession;
	
	String ns = "Member.";
}
