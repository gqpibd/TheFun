package donzo.thefun.service;

import java.util.List;

import donzo.thefun.model.LikeDto;
import donzo.thefun.model.MemberDto;
import donzo.thefun.model.OptionDto;
import donzo.thefun.model.ProjectDto;
import donzo.thefun.model.ProjectmsgDto;
import donzo.thefun.model.QnaDto;
import donzo.thefun.model.StatCountParam;
import donzo.thefun.model.pageparam.ProjectParam;
import donzo.thefun.model.pageparam.pageParam;
    
public interface ProjectService {
	
	//프로젝트 디테일 select (프로젝트 seq)
	public List<ProjectDto> getProjectList(int[] seq);

	//프로젝트 디테일 select (프로젝트 seq)
	public ProjectDto getProject(int seq);
	
	//프로젝트 작성자 select (프로젝트 seq)
	public MemberDto getWriter(int seq);
	
	//프로젝트에 해당하는 옵션들 select (프로젝트 seq)
	public List<OptionDto> getOptions(int seq);
	
	//주문하고싶은 옵션 select (옵션 seq [])
	public List<OptionDto> getSelectOptions(int[] seq);
	
	// 프로젝트&리워드 생성하기(프로젝트 dto, 리워드 list) ==> 생성한 프로젝트 seq 리턴 
	public int projectWrite(ProjectDto newProjectDto, List<OptionDto> newPotionlist) throws Exception;
	
	// 내 프로젝트 수정 (수정 프로젝트 dto, 수정 리워드 리스트)
	public void updateProject(ProjectDto myProjectDto, List<OptionDto> newPotionlist, String message) throws Exception;
	
	// 내 프로젝트 삭제( 삭제할 프로젝트 seq ) 
	public void deleteProject(int seq) throws Exception;
	
	// 프로젝트 검색
	public List<ProjectDto> searchProjectList(ProjectParam pParm) throws Exception;
	
	// 프로젝트의 갯수
	public int getProjectCount(ProjectParam pParam) throws Exception;
	
	// 승인 대기중인 프로젝트 목록(관리자)
	public List<ProjectDto> getWaitingPagingList(pageParam aParam);
	
	// Qna목록
	public List<QnaDto> getQna(int seq);

	// 프로젝트 승인
	public boolean approveProject(int projectseq);

	// 프로젝트 반려
	public boolean rejectProject(ProjectmsgDto msgdto);
	
	// 승인대기중인 프로젝트의 수	
	public int getWaitCount();
	
	//내 프로젝트 요약 건 수
	public int getStatusCount(StatCountParam sParam) throws Exception;
	
	// 좋아요 변경
	public boolean changeLike(LikeDto like);

	// 특정 프로젝트의 좋아요 구
	public int getLikeCount(int projectseq);

	// 특정 프로젝트의 메시지 목록
	public List<ProjectmsgDto> getMsgList(int projectseq);

	// 내가 올린 프로젝트 리스트
	public List<ProjectDto> getMemberProjectList(String id);

	// 판매자의 성공 또는 진행중 프로젝트 리스트
	public List<ProjectDto> getSellerProjectList(String id);
	//일정 달력
	public List<ProjectDto> getCalendarList(int seq) throws Exception;
	
	// 특정 판매자의 성공 or 실패한 프로젝트 리스트
	public List<ProjectDto> getWinOrLoseList(String id) throws Exception;

	public OptionDto getOptionDetail(int optionseq);
	
}
