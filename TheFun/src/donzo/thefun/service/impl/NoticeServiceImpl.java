package donzo.thefun.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import donzo.thefun.dao.AlarmDao;
import donzo.thefun.dao.NoticeDao;
import donzo.thefun.model.AlarmDto;
import donzo.thefun.model.NoticeDto;
import donzo.thefun.service.NoticeService;

@Service
public class NoticeServiceImpl implements NoticeService {

	@Autowired
	NoticeDao noticeDao;
	
	@Autowired
	AlarmDao alarmDao;

	@Override
	public NoticeDto addNotice(NoticeDto dto) {		
		noticeDao.addNotice(dto);
		List<AlarmDto> relatedUserList = alarmDao.getRelatedUserList(dto.getProjectseq()); // 알람이 생성되어야 할 관계있는 아이디의 목록
		// 리스트 받을 때 id랑 buytype 채워서 온다.
		// 나머지를 채워서 알람 저장하자
		for(AlarmDto item : relatedUserList) {
			item.setAtype(AlarmDto.ATYPE_NOTICE);
			//item.setFromid(""); // 우선 비워놨다. 공지에서는 굳이 필요 없을듯...?
			item.setProjectseq(dto.getProjectseq());
			item.setAcontent(dto.getTitle());
			alarmDao.addAlarm(item);
		}
		
		NoticeDto newDto = noticeDao.selectNotice(dto);
		return newDto;
	}

	@Override
	public List<NoticeDto> getNotice(int seq) {
		return noticeDao.getNotice(seq);
	}

}
