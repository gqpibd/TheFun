package donzo.thefun.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import donzo.thefun.dao.LikeDao;
import donzo.thefun.dao.NoticeDao;
import donzo.thefun.dao.OptionDao;
import donzo.thefun.dao.ProjectDao;
import donzo.thefun.dao.ProjectmsgDao;
import donzo.thefun.dao.QnaDao;
import donzo.thefun.model.LikeDto;
import donzo.thefun.model.MemberDto;
import donzo.thefun.model.NoticeDto;
import donzo.thefun.model.OptionDto;
import donzo.thefun.model.ProjectDto;
import donzo.thefun.model.ProjectParam;
import donzo.thefun.model.ProjectmsgDto;
import donzo.thefun.model.QnaDto;
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

	@Override
	public ProjectDto getProject(int seq) {
		return projectDao.getProject(seq);
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
		newProjectDto.setEdate(edate+"-23-59-59");
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
	public void updateProject(ProjectDto myProjectDto) throws Exception {
		projectDao.updateProject(myProjectDto);
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

	@Override
	public List<ProjectDto> getWaitingList() {
		return projectDao.getWaitingList();
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

	// 프로젝트 승인
	@Override
	public boolean approveProject(int projectseq) {
		projectmsgDao.insertProjectMsg(new ProjectmsgDto(projectseq,ProjectmsgDto.APPROVE,"관리자가 프로젝트 게시를 승인하였습니다."));		
		return projectDao.approveProject(projectseq);		
	}
	
	// 프로젝트 승인
	@Override
	public boolean rejectProject(ProjectmsgDto msgdto) {		
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
	
	
}
