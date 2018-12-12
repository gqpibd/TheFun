package donzo.thefun.service;

import java.util.List;

import donzo.thefun.model.NoticeDto;

public interface NoticeService {
	public NoticeDto addNotice(NoticeDto dto);

	//프로젝트별 공지사항 (프로젝트 seq)	
	public List<NoticeDto> getNotice(int seq);
}
