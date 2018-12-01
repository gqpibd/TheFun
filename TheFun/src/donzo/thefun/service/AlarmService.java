package donzo.thefun.service;

import java.util.List;

import donzo.thefun.model.AlarmDto;

public interface AlarmService {

	public int getAlarmCount(String id);

	public List<AlarmDto> getAlarmList(String id);

	public int deleteAlarm(int seq);

}
