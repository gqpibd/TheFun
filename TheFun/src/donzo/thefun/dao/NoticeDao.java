package donzo.thefun.dao;

import java.util.List;

import donzo.thefun.model.NoticeDto;
import donzo.thefun.model.QnaDto;

public interface NoticeDao {

	public List<NoticeDto> getNotice(int seq);

}
