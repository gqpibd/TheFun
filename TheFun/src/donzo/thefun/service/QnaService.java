package donzo.thefun.service;

import donzo.thefun.model.QnaDto;

public interface QnaService {
	public int addQna(QnaDto newQna, String projectWriter);

	public boolean delQna(int seq);

	public boolean updateQna(QnaDto dto);

}
