package donzo.thefun.service.impl;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import donzo.thefun.dao.QnaDao;
import donzo.thefun.model.QnaDto;
import donzo.thefun.service.QnaService;

@Service
public class QnaServiceImpl implements QnaService {

	@Autowired
	QnaDao qnaDao;

	@Override
	public int addQna(QnaDto newQna) {
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
