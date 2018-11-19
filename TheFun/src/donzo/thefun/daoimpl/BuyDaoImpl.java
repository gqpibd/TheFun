package donzo.thefun.daoimpl;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import donzo.thefun.dao.BuyDao;

@Repository
public class BuyDaoImpl implements BuyDao {

	@Autowired
	SqlSessionTemplate sqlSession;
	
	String ns = "Buy.";
}
