package donzo.thefun.daoimpl;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;

import donzo.thefun.dao.ProjectDao;

public class ProjectDaoImpl implements ProjectDao {

	@Autowired
	SqlSessionTemplate sqlSession;
	
	String ns = "FunProject.";
}
