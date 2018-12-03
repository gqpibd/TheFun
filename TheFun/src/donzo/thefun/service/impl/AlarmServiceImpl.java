package donzo.thefun.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import donzo.thefun.dao.AlarmDao;
import donzo.thefun.model.AlarmDto;
import donzo.thefun.service.AlarmService;

@Service
public class AlarmServiceImpl implements AlarmService {

	@Autowired
	AlarmDao alarmDao; 
	
	@Override
	public int getAlarmCount(String id) {
		return alarmDao.getAlarmCount(id);
	}

	@Override
	public List<AlarmDto> getAlarmList(String id) {
		return alarmDao.getAlarmList(id);
	}

	@Override
	public int deleteAlarm(int seq) {
		return alarmDao.deleteAlarm(seq);
		
	}
}
