package donzo.thefun.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import donzo.thefun.dao.MemberDao;
import donzo.thefun.service.MemberService;

@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	MemberDao memberDao;
	
}
