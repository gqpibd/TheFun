package donzo.thefun.dao;

import java.util.List;

import donzo.thefun.model.NoticeDto;

public interface NoticeDao {

	public List<NoticeDto> getNotice(int seq);
}
