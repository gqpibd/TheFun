package donzo.thefun.dao.impl;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import donzo.thefun.dao.AlarmDao;
import donzo.thefun.model.AlarmDto;

@Repository
public class AlarmDaoImpl implements AlarmDao {

	@Autowired
	SqlSessionTemplate sqlSession;
	
	String ns = "Alarm.";

	@Override
	public void addAlarm(AlarmDto alarmDto) {
		sqlSession.insert(ns+"addAlarm",alarmDto);		
	}

	@Override
	public int getAlarmCount(String id) {
		return sqlSession.selectOne(ns+"getAlarmCount",id);
	}

	@Override
	public List<AlarmDto> getAlarmList(String id) {
		return sqlSession.selectList(ns+"getAlarmList",id);
	}

	@Override
	public int deleteAlarm(int seq) {
		return sqlSession.delete(ns+"deleteAlarm",seq);
	}

	@Override
	public List<AlarmDto> getRelatedUserList(int projectseq) {
		return sqlSession.selectList(ns+"getRelatedUserList",projectseq);
	}
}
