package donzo.thefun.service;

import java.util.List;

import donzo.thefun.model.LikeDto;
import donzo.thefun.model.MemberDto;
import donzo.thefun.model.NoticeDto;
import donzo.thefun.model.OptionDto;
import donzo.thefun.model.ProjectDto;
import donzo.thefun.model.ProjectParam;
import donzo.thefun.model.ProjectmsgDto;
import donzo.thefun.model.QnaDto;
    
public interface ProjectService {
	
	//프로젝트 디테일 select (프로젝트 seq)
	public ProjectDto getProject(int seq);
	
	//프로젝트 작성자 select (프로젝트 seq)
	public MemberDto getWriter(int seq);
	
	//프로젝트에 해당하는 옵션들 select (프로젝트 seq)
	public List<OptionDto> getOptions(int seq);
	
	//프로젝트별 공지사항 (프로젝트 seq)
	public List<NoticeDto> getNotice(int seq);

	//주문하고싶은 옵션 select (옵션 seq [])
	public List<OptionDto> getSelectOptions(int[] seq);
	
	// 프로젝트&리워드 생성하기(프로젝트 dto, 리워드 list) ==> 생성한 프로젝트 seq 리턴 
	public int projectWrite(ProjectDto newProjectDto, List<OptionDto> newPotionlist) throws Exception;
	
	// 내 프로젝트 수정 (수정 프로젝트 dto, 수정 리워드 리스트)
	public void updateProject(ProjectDto myProjectDto, List<OptionDto> newPotionlist, String message) throws Exception;
	
	// 내 프로젝트 삭제( 삭제할 프로젝트 seq ) 
	public void deleteProject(int seq) throws Exception;
	
	public List<ProjectDto> searchProjectList(ProjectParam pParm) throws Exception;
	
	public int getProjectCount(ProjectParam pParam) throws Exception;
	
	// 승인 대기중인 프로젝트 목록(관리자)
	public List<ProjectDto> getWaitingList();
	
	// Qna목록
	public List<QnaDto> getQna(int seq);

	// 프로젝트 승인
	public boolean approveProject(int projectseq);

	// 프로젝트 반려
	public boolean rejectProject(ProjectmsgDto msgdto);
	
	// 승인대기중인 프로젝트의 수	
	public int getWaitCount();
	
	//schedule
	public List<ProjectDto> mySchedule(String id) throws Exception;

	public boolean changeLike(LikeDto like);

	public int getLikeCount(int projectseq);

	public List<ProjectmsgDto> getMsgList(int projectseq);

	//판매자의 프로젝트 리스트
	public List<ProjectDto> getProjectList(String id);
	
	
}
