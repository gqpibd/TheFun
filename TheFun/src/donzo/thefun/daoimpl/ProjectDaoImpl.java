package donzo.thefun.daoimpl;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import donzo.thefun.dao.ProjectDao;

@Repository
public class ProjectDaoImpl implements ProjectDao {

	@Autowired
	SqlSessionTemplate sqlSession;
	
	String ns = "Project.";
	
	
}
