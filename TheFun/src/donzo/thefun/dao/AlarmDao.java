package donzo.thefun.dao;

import java.util.List;

import donzo.thefun.model.AlarmDto;

public interface AlarmDao {

	public void addAlarm(AlarmDto alarmDto);
	
	public int getAlarmCount(String id);

	public List<AlarmDto> getAlarmList(String id);

	public int deleteAlarm(int seq);

	public List<AlarmDto> getRelatedUserList(int projectseq);

	public boolean addSubmitStatusAlarm(AlarmDto alarmDto);

}
