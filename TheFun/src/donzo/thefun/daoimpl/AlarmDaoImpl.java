package donzo.thefun.daoimpl;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import donzo.thefun.dao.AlarmDao;

@Repository
public class AlarmDaoImpl implements AlarmDao {

	@Autowired
	SqlSessionTemplate sqlSession;
	
	String ns = "Alarm.";
}
