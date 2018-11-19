package donzo.thefun.daoimpl;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import donzo.thefun.dao.QnaDao;

@Repository
public class QnaDaoImpl implements QnaDao {

	@Autowired
	SqlSessionTemplate sqlSession;
	
	String ns = "Qna.";
}
