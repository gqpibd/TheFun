package donzo.thefun.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import donzo.thefun.dao.NoticeDao;
import donzo.thefun.service.NoticeService;

@Service
public class NoticeServiceImpl implements NoticeService {

	@Autowired
	NoticeDao noticeDao;
	
}