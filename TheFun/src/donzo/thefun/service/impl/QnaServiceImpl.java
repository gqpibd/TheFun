package donzo.thefun.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import donzo.thefun.dao.QnaDao;
import donzo.thefun.service.QnaService;

@Service
public class QnaServiceImpl implements QnaService {

	@Autowired
	QnaDao QnaDao; 
	
}
