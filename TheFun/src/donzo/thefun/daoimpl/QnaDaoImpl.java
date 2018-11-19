package donzo.thefun.daoimpl;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;

import donzo.thefun.dao.QnaDao;

public class QnaDaoImpl implements QnaDao {

	@Autowired
	SqlSessionTemplate sqlSession;
	
	String ns = "Qna.";
}
