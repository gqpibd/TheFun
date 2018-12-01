package donzo.thefun.dao;

import java.util.List;

import donzo.thefun.model.QnaDto;

public interface QnaDao {

	public List<QnaDto> getQnaList(int seq);

	public int addQna(QnaDto newQna);

	public boolean delQna(int seq);

	public boolean updateQna(QnaDto dto);

	public String getRefWriter(int refseq);

	public String getProjectOwner(int projectseq);
	

	
}
