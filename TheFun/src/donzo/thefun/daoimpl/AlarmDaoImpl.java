package donzo.thefun.daoimpl;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;

import donzo.thefun.dao.AlarmDao;

public class AlarmDaoImpl implements AlarmDao {

	@Autowired
	SqlSessionTemplate sqlSession;
	
	String ns = "Alarm.";
}
