package donzo.thefun.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import donzo.thefun.dao.AlarmDao;
import donzo.thefun.dao.LikeDao;
import donzo.thefun.dao.NoticeDao;
import donzo.thefun.dao.OptionDao;
import donzo.thefun.dao.ProjectDao;
import donzo.thefun.dao.ProjectmsgDao;
import donzo.thefun.dao.QnaDao;
import donzo.thefun.model.AlarmDto;
import donzo.thefun.model.LikeDto;
import donzo.thefun.model.MemberDto;
import donzo.thefun.model.NoticeDto;
import donzo.thefun.model.OptionDto;
import donzo.thefun.model.ProjectDto;
import donzo.thefun.model.ProjectParam;
import donzo.thefun.model.ProjectmsgDto;
import donzo.thefun.model.QnaDto;
import donzo.thefun.model.StatCountParam;
import donzo.thefun.model.adminParam;
import donzo.thefun.service.ProjectService;

@Service
public class ProjectServiceImpl implements ProjectService {
	
	private static final Logger logger = LoggerFactory.getLogger(ProjectServiceImpl.class);
	
	@Autowired
	ProjectDao projectDao;
	
	@Autowired
	OptionDao optionDao;	
	
	@Autowired
	NoticeDao noticeDao;

	@Autowired
	QnaDao qnaDao;

	@Autowired
	ProjectmsgDao projectmsgDao;
	
	@Autowired
	LikeDao likeDao;
	
	@Autowired 
	AlarmDao alarmDao;

	@Override
	public List<ProjectDto> getProject(int[] seq) {
		
		List<ProjectDto> dtolist= new ArrayList<>();
		for(int i=0; i<seq.length;i++) {
			ProjectDto dto= projectDao.getProject(seq[i]);
			dtolist.add(dto);
		}
		return dtolist;
	}

	@Override
	public MemberDto getWriter(int seq) {
		return projectDao.getWriter(seq);
	}

	@Override
	public List<OptionDto> getOptions(int seq) {
		return optionDao.getOptions(seq);
	}

	@Override
	public List<NoticeDto> getNotice(int seq) {
		return noticeDao.getNotice(seq);
	}

	@Override
	public List<OptionDto> getSelectOptions(int[] seq) {
		
		//return할 리스트
		List<OptionDto> optionList = new ArrayList<>();
		
		//입력된 seq 배열의 길이만큼 loop
		for(int i=0; i<seq.length;i++) {
			optionList.add(optionDao.getSelectOptions(seq[i]));
		}
		
		return optionList;
	}

	@Override
	public int projectWrite(ProjectDto newProjectDto, List<OptionDto> newPotionlist) throws Exception {
		// edate 종료일 자정직전까지 시간설정
		String edate = newProjectDto.getEdate();
		if(newProjectDto.getEdate() != null && !newProjectDto.getEdate().equals("")) {
			newProjectDto.setEdate(edate+" 23:59:59");
		}
		
		// [1] 프로젝트 insert + 생성한 프로젝트 seq값 찾아오기
		int projectSeq = projectDao.projectWrite(newProjectDto);
		logger.info("찾아온 project seq : " + projectSeq);
		
		if(newProjectDto.getFundtype().equals("reward")) {	// 리워드일 경우(기부는 옵션 없음)
			// [2] 옵션 insert
			optionDao.optionWrite(newPotionlist, projectSeq);
		}
		
		return projectSeq;
	}
	
	@Override
	public void updateProject(ProjectDto myProjectDto, List<OptionDto> newPotionlist, String message) throws Exception {
		// edate 종료일 자정직전까지 시간설정
		String edate = myProjectDto.getEdate();
		myProjectDto.setEdate(edate+" 23:59:59");
		
		// [1] 프로젝트 DB 수정
		boolean success1 = projectDao.updateProject(myProjectDto);		
		boolean success2 = true;
		
		// [2] 옵션 DB도 수정(리워드일 경우만)
		if(myProjectDto.getFundtype().equals("reward")) {
			// [2]-1. 기존 리워드 삭제
			optionDao.deleteOptions(myProjectDto.getSeq());
			// [2]-2. 새 리워드 입력
			success2 = optionDao.optionWrite(newPotionlist, myProjectDto.getSeq());
		}
		if(success1 && success2) {
			System.out.println("승인 요청 알람 생성");
			// [3] 재승인 요청
			if(projectmsgDao.insertProjectMsg(new ProjectmsgDto(myProjectDto.getSeq(),ProjectmsgDto.RESUBMIT,message))) {			
				// [4] 알람 작성
				alarmDao.addSubmitStatusAlarm(new AlarmDto(myProjectDto.getSeq(), null, null , AlarmDto.ATYPE_SUBMISSION, AlarmDto.BTYPE_OTHER, message));
			}
		}
	}
	
	@Override
	public void deleteProject(int seq) throws Exception {
		projectDao.deleteProject(seq);
	}

	@Override
	public List<ProjectDto> searchProjectList(ProjectParam pParam) throws Exception{
		return projectDao.searchProjectList(pParam);
	}

	@Override
	public int getProjectCount(ProjectParam pParam) throws Exception {
		return projectDao.getProjectCount(pParam);
	}

//	@Override
//	public List<ProjectDto> getWaitingList() {
//		return projectDao.getWaitingList();
//	}

	@Override
	public List<ProjectDto> getWaitingPagingList(adminParam aParam) {
		return projectDao.getWaitingPagingList(aParam);
	}

	@Override
	public List<QnaDto> getQna(int seq) {
		return qnaDao.getQnaList(seq);
	}
	
	//schedule
	@Override
	public List<ProjectDto> mySchedule(String id) throws Exception {
		return projectDao.mySchedule(id);
	}
	
	//내 프로젝트 요약 건 수
	@Override
	public int getStatusCount(StatCountParam sParam) throws Exception {
		return projectDao.getStatusCount(sParam);
	}

	// 프로젝트 승인
	@Override
	public boolean approveProject(int projectseq) {
		String message = "관리자가 프로젝트 게시를 승인하였습니다.";
		alarmDao.addSubmitStatusAlarm(new AlarmDto(projectseq, "에디터", null , AlarmDto.ATYPE_SUBMISSION, AlarmDto.BTYPE_MYPROJECT, message));
		projectmsgDao.insertProjectMsg(new ProjectmsgDto(projectseq,ProjectmsgDto.APPROVE,message));		
		return projectDao.approveProject(projectseq);		
	}
	
	// 프로젝트 승인
	@Override
	public boolean rejectProject(ProjectmsgDto msgdto) {
		alarmDao.addSubmitStatusAlarm(new AlarmDto(msgdto.getProjectseq(), "에디터", null , AlarmDto.ATYPE_SUBMISSION, AlarmDto.BTYPE_MYPROJECT, msgdto.getMessage()));
		projectmsgDao.insertProjectMsg(msgdto);
		ProjectDto pdto = new ProjectDto();
		pdto.setSeq(msgdto.getProjectseq());
		pdto.setStatus(msgdto.getStatus());
		return projectDao.rejectProject(pdto);		
	}

	// 대기중이 프로젝트 갯수
	@Override
	public int getWaitCount() {		
		return projectDao.getWaitCount();
	}

	@Override
	public boolean changeLike(LikeDto like) {		
		return likeDao.changeLike(like);
	}

	@Override
	public int getLikeCount(int projectseq) {
		return likeDao.getLikeCount(projectseq);
	}

	@Override
	public List<ProjectmsgDto> getMsgList(int projectseq) {		
		return projectmsgDao.getMsgList(projectseq);
	}
	
	//판매자의 프로젝트리스트
	@Override
	public List<ProjectDto> getProjectList(String id) {		
		return projectDao.getProjectList(id);
	}
	
	
	
	
	
	
	
}
