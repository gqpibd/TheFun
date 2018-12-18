package donzo.thefun.dao.impl;

import java.util.ArrayList;
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
		sqlSession.insert(ns + "addAlarm", alarmDto);
	}

	@Override
	public int getAlarmCount(String id) {
		return sqlSession.selectOne(ns + "getAlarmCount", id);
	}

	@Override
	public List<AlarmDto> getAlarmList(String id) {
		return sqlSession.selectList(ns + "getAlarmList", id);
	}

	@Override
	public int deleteAlarm(int seq) {
		return sqlSession.delete(ns + "deleteAlarm", seq);
	}

	@Override
	public List<AlarmDto> getRelatedUserList(int projectseq) {
		List<AlarmDto> allList = sqlSession.selectList(ns + "getRelatedUserList", projectseq);
		List<AlarmDto> selectedList = new ArrayList<AlarmDto>();
		// 쿼리에서 중복 제거가 안 되어서 여기서 처리
		if(allList !=null && allList.size()>0) {
			selectedList.add(allList.get(0)); // 첫 번째꺼는 무조건 넣고
			for(int i=1;i<allList.size();i++) {	// 다음꺼	부터 처리		
				AlarmDto temp = allList.get(i);
				int j=0;
				for(j=0;j<selectedList.size();j++) {
					AlarmDto sel = selectedList.get(j);
					if(temp.getId().equals(sel.getId())){ // 같은 아이디가 있는 경우 걸러주고 넘어감.
						if(buyComparator(temp.getBuytype()) > buyComparator(sel.getBuytype())) { // 새로 들어온게 우선순위가 높으면
							sel.setBuytype(temp.getBuytype()); // 바꿔주고 넘어감.
						}
						break;
					}
				}
				if(j>=selectedList.size()) { // 이 조건을 만족한다는 것은 for문이 정상 종료된 경우이므로 중복이 아니다
					selectedList.add(temp); // 리스트에 추가해준다.
				}
			}
		}
			
		return selectedList;
	}

	private int buyComparator(String bType) { // 숫자가 큰 걸 살릴거임.
		if(bType.equals(AlarmDto.BTYPE_LIKE)) {
			return 0;
		}else if(bType.equals(AlarmDto.BTYPE_BASKET)) {
			return 1;
		}else {
			return 2;
		}
	}
	@Override
	public boolean addSubmitStatusAlarm(AlarmDto alarmDto) {
		int n = sqlSession.insert(ns + "addSubmitStatusAlarm", alarmDto);
		return n > 0 ? true : false;
	}

	@Override
	public void addFinishAlarm(AlarmDto alarmDto) {
		sqlSession.insert(ns + "addFinishAlarm", alarmDto);		
	}
}
