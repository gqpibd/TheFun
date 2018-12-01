package donzo.thefun.service.impl;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import donzo.thefun.dao.AlarmDao;
import donzo.thefun.dao.QnaDao;
import donzo.thefun.model.AlarmDto;
import donzo.thefun.model.QnaDto;
import donzo.thefun.service.QnaService;

@Service
public class QnaServiceImpl implements QnaService {

	@Autowired
	QnaDao qnaDao;
	
	@Autowired
	AlarmDao alarmDao;

	@Override
	public int addQna(QnaDto newQna, String projectOwner) {
		AlarmDto newAlarm;
		if(!newQna.getId().equals(projectOwner)) { // 작성자가 프로젝트 작성자가 아니면 프로젝트 작성자에게 알람 생성
			newAlarm = new AlarmDto(newQna.getProjectseq(),newQna.getNickname(),projectOwner,AlarmDto.ATYPE_QNA,AlarmDto.BTYPE_MYPROJECT,newQna.getContent());
			System.out.println("프로젝트 작성자에게:" + newAlarm);
			alarmDao.addAlarm(newAlarm);
		}
		if(newQna.getTowhom() != null && newQna.getTowhom().length()>0 && !newQna.getTowhom().equals(projectOwner) && !newQna.getTowhom().equals(newQna.getId())) { // 받는 사람이 있고 받는사람이 프로젝트 작성자가 아닌 경우 알람 생성
			newAlarm = new AlarmDto(newQna.getProjectseq(),newQna.getNickname(),newQna.getTowhom(),AlarmDto.ATYPE_QNA,AlarmDto.BTYPE_OTHER,newQna.getContent()); // 댓글은 프로젝트 상태가 중요하지 않으므로 생략
			System.out.println("내가 지정한 사람에게:" + newAlarm);
			alarmDao.addAlarm(newAlarm);
		}
		if(newQna.getRefseq() > 0 ) { // 대댓일 때 원래글 작성자에게 알람
			String refQnaWriter = qnaDao.getRefWriter(newQna.getRefseq());
			if(!refQnaWriter.equals(newQna.getTowhom()) && !refQnaWriter.equals(projectOwner) && !refQnaWriter.equals(newQna.getId())) {
				newAlarm = new AlarmDto(newQna.getProjectseq(),newQna.getNickname(),refQnaWriter,AlarmDto.ATYPE_QNA,AlarmDto.BTYPE_OTHER,newQna.getContent()); // 댓글은 프로젝트 상태가 중요하지 않으므로 생략
				System.out.println("원래 댓글 작성자에게:" + newAlarm);
				alarmDao.addAlarm(newAlarm);
			}
		}
		
		
		return qnaDao.addQna(newQna);
		
	}

	@Override
	public boolean delQna(int seq) {
		return qnaDao.delQna(seq);		
	}

	@Override
	public boolean updateQna(QnaDto dto) {		
		return qnaDao.updateQna(dto);
	}	
}
