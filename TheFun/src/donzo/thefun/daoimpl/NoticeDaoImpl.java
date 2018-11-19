package donzo.thefun.daoimpl;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import donzo.thefun.dao.NoticeDao;

@Repository
public class NoticeDaoImpl implements NoticeDao {

	@Autowired
	SqlSessionTemplate sqlSession;
	
	String ns = "Notice.";
	
}
